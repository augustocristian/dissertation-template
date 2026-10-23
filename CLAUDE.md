# plantillaUnioviTFG

Unofficial LaTeX port of the research group's official Word template for
BSc/MSc theses (TFG/TFM) at the Escuela Politécnica de Ingeniería de
Gijón, Universidad de Oviedo — since extended to the Escuela de
Ingeniería Informática and several specific degrees (see "School and
degree presets"). Repo: `augustocristian/dissertation-template`; the
project lives directly at the repo root (no `latex/` or `augustotemplate/`
wrapper folder).

This is a **reusable class-based template**, not a one-off document: the
design system lives in `uniovitfg.cls`, and `main.tex` + the content files
are a filled-in *example* thesis that doubles as living documentation of
every feature. A student edits `main.tex`'s metadata block and
`chapters/*.tex`; they should rarely need to touch `uniovitfg.cls`.

The original Word template (`2026-TFG-Templatev2.docx`) used to
reverse-engineer colors/fonts/layout is **not in this repo or its git
history**. For design questions this file doesn't answer, rely on the
"Design decisions" below and the rendered `main.pdf`.

## Docs: keep in sync

- `README.md` is the student-facing doc, **in Spanish**: badges, index,
  "what you need to change" checklist, build instructions (CLI, Overleaf,
  VSCode), CI/PDF naming, customization guide. It overlaps with this file
  by design — update both when a feature or build step changes.
- This file is dev-facing: gotchas and design decisions.
- Code comments and file names are in English; rendered text defaults to
  Spanish.

## Build

Run from the repo root:

```bash
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex
```

**XeLaTeX or LuaLaTeX only** — the class hard-errors under pdflatex
(`fontspec` for Aptos). Needs `biber` (not bibtex): `biblatex` with
`biblatex-ieee`. MiKTeX/TeX Live auto-install missing packages on first
compile (slow the first time).

Known-good clean rebuild:
```bash
rm -f main.aux main.bcf main.bbl main.blg main.log main.toc main.lof main.lot main.lol main.out main.run.xml main.synctex.gz
xelatex -interaction=nonstopmode -halt-on-error main.tex
biber main
xelatex -interaction=nonstopmode -halt-on-error main.tex
xelatex -interaction=nonstopmode -halt-on-error main.tex
```
Grep the log for `^! ` for real errors. `Underfull \hbox` warnings from
the right-ragged chapter titles are expected and cosmetic.

## CI: PDF build and publish

`.github/workflows/build-thesis.yml` does one thing — compile the thesis
and make the PDF available. No lint job, no log artifacts.

- **`build` job** (every push + manual dispatch, `texlive/texlive:latest-full`
  container): runs the clean-rebuild sequence above, fails on any `^! `
  error or undefined reference/citation, names the PDF, uploads it as the
  `thesis-pdf` artifact (30 days).
- **`publish` job** (only on the default branch; other branches get **no
  release**, just the artifact, whose URL is written to the run summary):
  deletes and recreates the rolling release tagged `latest-pdf` with the PDF
  attached, so the tag follows the commit and there is one stable,
  login-free URL. The README "Último PDF" badge links to
  `releases/tag/latest-pdf`. Needs `contents: write` (set on that job only);
  a forked repo must allow "Read and write permissions" under Settings →
  Actions.
- **PDF name**: `{year}-{school}-{TFG|TFM}-{SurnameName}-{branch}-{commit7}.pdf`,
  computed by `.github/scripts/pdf-name.sh` by parsing the *active*
  (non-commented) lines of `main.tex`:
  - year = last 4-digit number in `\thesisdate{}`;
  - school = `epigijon`/`eii` from the last `\degreepreset{}`/`\schoolpreset{}`
    (default `epigijon`); `TFM` only for `\degreepreset{master}`;
  - SurnameName = `\author{}` without accents; assumes "Name Surname1
    Surname2" — the **last two words are the surnames** and go first
    (1 word: used as is; 2 words: last is the surname).
  - A hand-set `\school{}`/`\thesistype{}` is invisible to the script (it
    parses presets only). A new preset key must be added to the script's
    `case`, which errors on unknown keys by design.
  - Test locally: `BRANCH=main COMMIT=<sha> bash .github/scripts/pdf-name.sh`.
- PRs use `head_ref`/head SHA for the name (the merge SHA is meaningless
  to a reader); the workflow currently triggers on `push`, not `pull_request`.

## File map

| Path | Purpose |
|---|---|
| `main.tex` | Thesis metadata (title/author/tutors/school/degree/date/…), language toggle, and the `\input` sequence. **The only file most users edit.** |
| `uniovitfg.cls` | Design system: fonts, colors, geometry, header/footer, chapter/section styling, cover (`\maketitle`), tutor rows, school/degree presets, `sheet` environment, table styling, bilingual toggle. |
| `extracommands.sty` | Optional: `\step{n}` and draft-review markers (`\TODO`, `\augusto`, `\tutortwo`, `\student`). |
| `declaration.tex`, `acknowledgements.tex` | Authorship statement / acknowledgements (header, no footer). |
| `abstract.tex` | Resumen/Abstract page. **`\startmainmatter` here resets the page counter to 1**, matching the Word template. |
| `chapters/ch0X_*.tex` | The 9 body chapters (below). `ch01` also demos the `\TODO`/`\augusto`/`\student` markers. |
| `sheets/risk_sheet_example.tex` | Example `sheet` ("ficha" fact-card). |
| `snippets/Average.java` | Example code file included via `\lstinputlisting`. |
| `bibliography.bib` | 5 example references, all cited (biber lists only cited entries). |
| `img/logos/` | Vector PDF logos: `logouniovi.pdf` (round seal, page header), `logouniovi-header.pdf` (despite the name: the FULL shield + wordmark, used on the cover), `logoepigijon.pdf` (header right by default), `logoeii.pdf` (used by `\schoolpreset{eii}`/`\degreepreset{software}` — exact name, no hyphen), `company_logo_placeholder.png` (replace for internship theses). |
| `.github/` | `workflows/build-thesis.yml`, `scripts/pdf-name.sh`, `dependabot.yml`. |
| `.gitignore` | Ignores LaTeX build artifacts and every `*.pdf` except under `img/`. |

### Chapter structure (the "clean" 9 chapters)

The original `.docx` TOC had a coherent chapters 1–9 outline plus a
second, overlapping outline from "Capítulo 10" on (broken
`¡Error! Marcador no definido.` cross-references) — leftover content from a
different template version. **Only chapters 1–9 were ported, intentionally.**

1. Descripción general del trabajo (Resumen/Palabras clave/Abstract/Keywords)
2. Planificación y Gestión (demo table + risk sheet)
3. Requisitos de usuario (`RQ n)` list demo)
4. Requisitos del Sistema
5. Diseño (demo figure)
6. Implementación (inline Python + `\lstinputlisting`'d Java demos)
7. Manuales
8. Conclusiones y Trabajo Futuro
9. Apéndices (includes `\printbibliography`)

New chapters: follow the numbering and use plain `\chapter`/`\section` —
the class styles them.

## Design decisions (each was a real, reproducible bug)

- **Never use `\bilingual{es}{en}` directly inside `\caption{...}`**
  (figure/table/lstlisting). `\bilingual` expands via `\ifthesisenglish`,
  and hyperref's `\newlabel`/bookmark machinery re-processes caption text
  in a way that corrupts the `.aux` on the *second* pass (fine from
  scratch, then breaks). Wrap the whole `\caption{...}` in a plain
  `\ifthesisenglish ... \else ... \fi`, or (for `lstlisting`'s `caption=`)
  resolve to a `\def`'d macro first. Copy the pattern from
  `ch02`/`ch05`/`ch06` for any new float.
- **Don't test a macro *parameter* holding another macro's NAME with
  `\ifdefempty`/`\ifblank`** (etoolbox) — they only work on a literal
  macro name in the source. `\tutorlogocell`'s argument arrives as a macro
  token (`\headerlogoleft` or `\@companylogopath`, which is legitimately
  empty without `\companylogo{}`). Use `\edef\tmp{#1}` then
  `\ifx\tmp\@empty ... \fi`. Bit twice; don't "simplify" it back.
- **Chapter opening pages keep the fancy header** (both logos + running
  title). Stock `report.cls` switches to `plain` there; patched with
  `\patchcmd{\chapter}{\thispagestyle{plain}}{\thispagestyle{fancy}}{}{}`,
  matching the Word template.
- **`\tableofcontents`/`\listoffigures`/`\listoftables`/`\lstlistoflistings`
  call `\chapter*` internally**, but Word uses a small unnumbered
  "Subtitle" style for them. `\frontmatterlist{...}` (in `main.tex`)
  re-`\titleformat`s `\chapter` inside a `\begingroup` before the call, so
  the override doesn't leak into real chapters.
- **Page numbering restart**: Word's cover + declaration + acknowledgements
  + index pages count as hidden pages; numbering restarts at 1 right before
  the Resumen/Abstract (`\startmainmatter`, called at the top of
  `abstract.tex`, not before Chapter 1).
- **`\@`-prefixed kernel macros (`\@title`, `\@author`, …) need
  `\makeatletter`/`\makeatother` in content `.tex` files** (not inside the
  `.cls`). Forgetting it doesn't error — it prints literal `title`/`author`.
  `abstract.tex` uses the public `\thesistypeabbrevvalue` to avoid this;
  `main.tex`'s `\hypersetup` needs the explicit guard.
- **Fonts fall back gracefully** via `\IfFontExistsTF`: Aptos → Calibri →
  Carlito (body), Aptos Display → Calibri Light → Carlito (display).
- **Load the final Carlito fallback by file name** (`Carlito-Regular.ttf`
  plus `BoldFont`/`ItalicFont`/`BoldItalicFont`), **never** `\setmainfont{Carlito}`.
  A bare name resolves via the OS font manager (fontconfig/Core Text);
  Overleaf's containers have the `carlito` TeX package but don't register
  it as an OS font, so a bare name hard-errors there. A file name with
  extension resolves via kpathsea (all TEXMF trees). This was the real
  Overleaf compile bug.

## Cover-page people system (author + tutors)

No photos/avatars (removed by request, along with `\authorphoto`,
`\authorlink`, `\avatarwithbadge`, `\avatarwithlink`, `\creditrow`,
`\avatarbordercolor`, `img/people/`). If photos return they must be
rebuilt — check git history for the old implementation first.

- `\author{Name}` — centered, own line, bigger/bold.
- `\tutor{Name}` (academic) / `\companytutor{Name}` (company) — name-only
  `\newcommand`s, called once per person, any number. Shown **one per
  line**: institution logo on the left (university logo for academic,
  `\companylogo{}` for company), small role label ("Tutor
  académico"/"Tutor en empresa") above the name.
- `\companylogo{path}` ALSO replaces the UNIOVI logo in the top-left of
  every page header (explicit ask: internship theses show the company brand).
- Implementation: `\tutor`/`\companytutor` `\gappto` one `\tutorcell{...}`
  per person onto `\@academiccreditrows`/`\@companycreditrows`, which
  `\maketitle` drops into a tabular via `\creditgroup`. Every row
  self-closes with `\\`.
- **Vertically centering the logo against the two-line "role\\name" text
  is not free from `m{}` columns**: an `\includegraphics` box is all height
  above baseline, a wrapped `\parbox` is lopsided differently, and `m{}`
  centers by raw height+depth, putting the logo visibly too high. Fix (see
  `\tutorcell`): measure the text into a saved box (`\@tutortextbox`) and
  `\raisebox` the logo by `0.5(\ht - \dp)` of that box. Two traps:
  `\raisebox`'s shift doesn't do inline dimen arithmetic (`0.5\ht0-0.5\dp0`
  silently truncates and prints "-0.5") — wrap in `\dimexpr ... \relax`;
  and the measuring `\sbox` must be `\global`, because `\halign` groups each
  cell (a local `\sbox` vanished before the next cell's `\usebox` — the row
  rendered with no tutor text and compiled with zero errors; caught only by
  rendering).

## Bilingual toggle

`\thesislanguage{spanish}` (default) or `{english}` near the top of
`main.tex`. Flips babel (hyphenation, `\today`), `\contentsname`/
`\listfigurename`/`\listtablename`/`\chaptername`/`\lstlistingname`/
`\bibname`, and every chapter/section title + placeholder paragraph via
`\bilingual{es}{en}` (a plain `\ifthesisenglish` macro — mind the caption
caveat above). `\thesistype`/`\thesistypeabbrev` get language-appropriate
defaults ("Trabajo Fin de Grado"/"TFG" vs "Bachelor's Thesis"/"BSc
Thesis"), resolved lazily in `\AtBeginDocument` and only if nothing set
them (`\ifdefempty{\@thesistype}`); `\degreepreset{master}` sets both
explicitly, so the guard skips the default.

Chapter 1 is a deliberate exception: §1.1/1.3 always show one Spanish
(Resumen) and one English (Abstract) blurb regardless of
`\thesislanguage`, since Spanish universities require both. Only that
chapter's title and the 1.2/1.4 headings ("Palabras clave"/"Keywords") are
language-fixed by design. §1.1 also demos the draft-review markers.

## School and degree presets

Two layers, both resolved **immediately at call time** (unlike
`\thesistype`'s `\AtBeginDocument` default): they branch on
`\ifthesisenglish` when called, which is only correct because `main.tex`
calls `\thesislanguage{}` earlier. Don't reorder `main.tex` or move either
preset into `\AtBeginDocument`.

- `\schoolpreset{epigijon|eii}` — sets `\school{}`, `\schoollogo{}` (a thin
  wrapper that `\renewcommand`s `\headerlogoright`) and that school's
  default `\degree{}`. Unknown key → `\ClassError` (same as `\thesislanguage{}`).
- `\degreepreset{it|datos|master|software}` — calls `\schoolpreset{}` for
  the right school, then overrides `\degree{}` (for `master` also
  `\thesistype{}`/`\thesistypeabbrev{}` — a Máster is a TFM).
  `it`/`software` don't re-set `\degree{}`; it's already their school's default.
- Degree names are the **official English names from uniovi.es** (looked
  up, not translated ad hoc), e.g. "Bachelor's Degree in Informatics
  Engineering in Information Technology". For a new preset, look up the
  real name — and update `pdf-name.sh` (see CI).
- A logo filename mismatch fails at `\includegraphics` time ("Unable to
  load picture or PDF file"), not at the preset call — easy to miss until
  someone compiles with that preset (`logoeii.pdf` was once `logo-eii.pdf`).
- Deliberately not a rigid enum: `\school`/`\schoollogo`/`\degree`/
  `\thesistype`/`\thesistypeabbrev` stay independently callable (like
  `\companylogo`/`\companytutor`), so unlisted schools/degrees are easy to
  set by hand and any piece of a preset can be overridden afterward.

## Draft-review comments (`extracommands.sty`)

Separate `.sty` (optional writing/review scaffolding, not visual design);
`main.tex` opts in with `\usepackage[showcomments,showtodos]{extracommands}`
right after `\documentclass`.

- `\TODO{}` and per-reviewer `\augusto{}`/`\tutortwo{}`/`\student{}` share
  one `\todomarker`/`\notemarker` implementation (`#1`=color `#2`=`\ding{}`
  symbol `#3`=label `#4`=text): a `\marginnote{}` colored symbol at the call
  site plus a real `\footnote{}` with the labeled text. A new reviewer is one
  more `\newcommand{\name}[1]{\notemarker{color}{\ding{n}}{Label}{#1}}` —
  pick an unused color/`\ding` code.
- **Hidden by default, shown via options**: `showtodos`/`showcomments` are
  two independent etoolbox booleans (`\DeclareOption`/`\ProcessOptions`),
  each gating its marker to the real implementation or a no-op `{}`. The
  calls can stay in the source permanently; drop the two options for the
  final compile.
- The no-op also skips the `\footnote{}`, so hidden markers don't reserve
  footnote numbers and can't shift real footnotes when toggled.
- `\step{n}` (small circled number, e.g. manual steps) is unrelated — same
  file only because both were requested together.
- Demoed in `ch01` §1.1 (one `\TODO`, one `\augusto`, one `\student` at the
  same point — their three margin symbols overlap there; not a bug).
