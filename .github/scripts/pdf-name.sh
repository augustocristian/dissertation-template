#!/usr/bin/env bash
# Prints the release file name of the thesis PDF:
#
#   {year}-{school}-{TFG|TFM}-{SurnameName}-{branch}-{commitid}.pdf
#
# Everything except branch/commit is read from the *active* (non-commented)
# lines of main.tex, so the name follows whatever the student configured:
#
#   year        last 4-digit number in \thesisdate{...} (else current year)
#   school      epigijon | eii, from the last \degreepreset{} / \schoolpreset{}
#   TFG|TFM     TFM only for \degreepreset{master}, TFG otherwise
#   SurnameName from \author{...}, accents stripped. Assumes the Spanish
#               "Name Surname1 Surname2" order: the LAST TWO words are the
#               surnames and go first (so "María José Pérez Gómez" ->
#               PerezGomezMariaJose). With two words the last one is the
#               surname; with one word it is used as is.
#
# Usage: BRANCH=main COMMIT=<sha> .github/scripts/pdf-name.sh [main.tex]
set -euo pipefail

main_tex="${1:-main.tex}"
branch="${BRANCH:-$(git rev-parse --abbrev-ref HEAD)}"
commit="${COMMIT:-$(git rev-parse HEAD)}"

# Drop TeX comments (an unescaped % to end of line).
active=$(sed -E 's/(^|[^\\])%.*/\1/' "$main_tex")

# Last match of "\cmd{value}" -> value
arg() { printf '%s\n' "$active" | sed -nE "s/.*\\\\$1\\{([^}]*)\\}.*/\\1/p" | tail -n 1; }

# ASCII-only: decompose accents and drop the combining marks.
ascii() { perl -MUnicode::Normalize -CSD -pe '$_ = NFD($_); s/\p{M}//g'; }

# --- school + thesis type -------------------------------------------------
preset=$(printf '%s\n' "$active" | grep -oE '\\(degreepreset|schoolpreset)\{[a-z]+\}' | tail -n 1 || true)
key=${preset#*\{}; key=${key%\}}
type=TFG
case "$key" in
  ""|it|datos|epigijon) school=epigijon ;;
  master)               school=epigijon; type=TFM ;;
  software|eii)         school=eii ;;
  *) echo "pdf-name.sh: unknown preset '$key' in $main_tex" >&2; exit 1 ;;
esac

# --- year -------------------------------------------------------------------
year=$(arg thesisdate | grep -oE '[0-9]{4}' | tail -n 1 || true)
year=${year:-$(date +%Y)}

# --- SurnameName ------------------------------------------------------------
author=$(arg author | ascii | tr -cd 'A-Za-z \n')
read -r -a words <<< "$author"
n=${#words[@]}
if   (( n == 0 )); then echo "pdf-name.sh: no \\author{} found in $main_tex" >&2; exit 1
elif (( n == 1 )); then given=();                  surnames=("${words[@]}")
elif (( n == 2 )); then given=("${words[0]}");     surnames=("${words[1]}")
else                    given=("${words[@]:0:n-2}"); surnames=("${words[@]:n-2}")
fi
person=""
for w in "${surnames[@]}" "${given[@]}"; do
  person+="${w^}"
done

# --- branch + commit --------------------------------------------------------
branch=$(printf '%s' "$branch" | tr -c 'A-Za-z0-9._\n-' '-')
printf '%s-%s-%s-%s-%s-%s.pdf\n' "$year" "$school" "$type" "$person" "$branch" "${commit:0:7}"
