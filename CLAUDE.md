# plantillaUnioviTFG

Unofficial LaTeX port of the research group's official Word template for
BSc/MSc theses (TFG/TFM) at the Escuela Politécnica de Ingeniería de
Gijón, Universidad de Oviedo — since extended to also cover the Escuela
de Ingeniería Informática and several specific degrees (see "School and
degree presets" below). Lives at `augustotemplate/` inside the
`TFGs-TFMs` git repo.

## What's in this folder

```
CLAUDE.md          ← this file: dev-facing notes, gotchas, design decisions
README.md          ← user-facing docs in Spanish (for students reusing the template) — install/build steps + customization guide, overlaps with this file by design
main.tex           ← thesis metadata + \input sequence — the only file most users should edit
uniovitfg.cls      ← the design system (fonts, colors, layout, cover page, bilingual toggle, school/degree presets)
extracommands.sty  ← optional: \step + draft-review comment/TODO markers, see "Draft-review comments" below
declaration.tex, acknowledgements.tex, abstract.tex, chapters/, sheets/, snippets/, bibliography.bib, img/
```

There is **no `latex/` subfolder** — the project lives directly at the
top of `augustotemplate/` (a past reorg flattened what used to be a
`latex/` wrapper directory). The original Word template
(`2026-TFG-Templatev2.docx`) and its rendered PDF export, once used as
one-time reference material to reverse-engineer colors/fonts/layout
(via `word/document.xml`, `word/styles.xml`, `word/numbering.xml`,
`word/header*.xml`, and `word/media/` inside the unzipped `.docx`), are
**not present in this folder or in git history** — they were working
material, not a deliverable, and were apparently never copied in here or
were removed after the port was done. If a design question comes up that
this file doesn't answer, there's no local copy of the original to
re-check against — rely on the "Design decisions" section below and the
rendered `main.pdf`.

## The LaTeX project

### Purpose and scope

This is a **reusable class-based template**, not a one-off document: the
design system lives in `uniovitfg.cls`, and `main.tex` + the content files
are a filled-in *example* thesis that doubles as living documentation of
every feature. A student reusing this template edits `main.tex`'s
metadata block and the `chapters/*.tex` files; they should rarely need to
touch `uniovitfg.cls`.

### Build

Run from inside `augustotemplate/`:

```bash
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex
```

**Must use XeLaTeX or LuaLaTeX** — the class hard-errors under pdflatex
because it needs `fontspec` for the Aptos/Aptos Display fonts. Needs
`biber` (not classic bibtex) because it uses `biblatex` with the
`biblatex-ieee` style. MiKTeX/TeX Live auto-install missing packages on
first compile (can take a while the very first time — `tikz`,
`biblatex-ieee`, etc.).

Known-good full rebuild from a clean state:
```bash
rm -f main.aux main.bcf main.bbl main.blg main.log main.toc main.lof main.lot main.lol main.out main.run.xml main.synctex.gz
xelatex -interaction=nonstopmode -halt-on-error main.tex
biber main
xelatex -interaction=nonstopmode -halt-on-error main.tex
xelatex -interaction=nonstopmode -halt-on-error main.tex
```
Grep the log for `^! ` to find real errors (as opposed to harmless
`Underfull \hbox` warnings from the right-ragged chapter titles, which are
expected and cosmetic).

### File map

| Path | Purpose |
|---|---|
| `README.md` | Student-facing documentation, in Spanish: install/build steps (local, Overleaf, VSCode), full customization guide (metadata, school/degree, tutors, draft-review comments, sheets, snippets, bibliography, tables, language toggle). Keep in sync with this file when either changes. |
| `main.tex` | Thesis metadata (title/author/tutors/school/degree/date/etc.), language toggle, and the `\input` sequence for the whole document. **This is the only file most users should edit.** |
| `uniovitfg.cls` | The design system: fonts, colors, page geometry, header/footer, chapter/section styling, cover page (`\maketitle`), tutor credit-row system, school/degree presets, `sheet` environment, table styling, bilingual toggle. |
| `extracommands.sty` | Optional: `\step{n}` (circled step number) and draft-review comment/TODO markers (`\TODO`, `\augusto`, `\tutortwo`, `\student`). See "Draft-review comments" below. |
| `declaration.tex` | Statement of authorship (shown with header, no footer). |
| `acknowledgements.tex` | Acknowledgements (shown with header, no footer). |
| `abstract.tex` | Free-standing "Resumen"/"Abstract" page. **This is where `\startmainmatter` resets the page counter to 1**, matching the Word template's hidden-front-matter-then-restart behavior. |
| `chapters/ch0X_*.tex` | The 9 body chapters (see "Chapter structure" below). `ch01_general_description.tex` also demos the `\TODO`/`\augusto`/`\student` markers. |
| `sheets/risk_sheet_example.tex` | Example of the `sheet` environment (a "ficha" fact-card, e.g. for a risk register entry). |
| `snippets/Average.java` | Example of a code file included via `\lstinputlisting` rather than typed inline. |
| `bibliography.bib` | 5 example references, all actually cited somewhere in the chapters (biblatex/biber only lists what's cited). |
| `img/logos/` | Institutional logos as vector PDFs: `logouniovi.pdf` (small round UNIOVI seal, used in the page header), `logouniovi-header.pdf` (despite the name, this is the FULL shield+"Universidad de Oviedo" wordmark, used on the cover), `logoepigijon.pdf` (EPI Gijón logo, header right by default), `logoeii.pdf` (Escuela de Ingeniería Informática logo, used by `\degreepreset{software}`/`\schoolpreset{eii}` — note the exact filename: no hyphen, unlike how it was first dropped in as `logo-eii.pdf`), `company_logo_placeholder.png` (placeholder — replace with a real company logo for internship-based theses). |
| `.gitignore` | Ignores all LaTeX build artifacts and any `*.pdf` except files under `img/`. |

### Chapter structure (the "clean" 9-chapter skeleton)

The original `.docx` table of contents is messy: chapters 1–9 form a
coherent, well-formed outline, but starting at the old "Capítulo 10" there
is a **second, overlapping outline** (Aspectos teóricos, Planificación y
Presupuesto Inicial, Análisis, Diseño del Sistema, Implementación del
Sistema, Plan de pruebas, Conclusiones, Bibliografía, Anexo...) full of
broken cross-references (`¡Error! Marcador no definido.`). This is almost
certainly leftover content from an earlier/different version of the
template that got merged into the file by accident. **Only chapters 1–9
were ported** — this is the intentional, correct scope, not an oversight:

1. Descripción general del trabajo (Resumen/Palabras clave/Abstract/Keywords)
2. Planificación y Gestión (planning, execution, closure — includes the demo table and the risk sheet example)
3. Requisitos de usuario (includes the `RQ n)` requirement-list demo)
4. Requisitos del Sistema
5. Diseño (includes the demo figure)
6. Implementación (includes both code-snippet demos: inline Python + `\lstinputlisting`'d Java)
7. Manuales
8. Conclusiones y Trabajo Futuro
9. Apéndices (includes `\printbibliography`)

If asked to add more chapters, follow this same numbering convention and
just use `\chapter`/`\section`/etc. — they automatically pick up the
correct styling from the class.

## Design decisions worth knowing before touching `uniovitfg.cls`

These aren't obvious from reading the code casually — they were each hit
as a real, reproducible compile bug during development. Repeating any of
them will reintroduce the bug.

- **Never use `\bilingual{es}{en}` directly inside a `\caption{...}`**
  (figure/table/lstlisting). `\bilingual` expands via `\ifthesisenglish`,
  and hyperref's `\newlabel`/bookmark machinery re-processes caption text
  in a way that corrupts the `.aux` file on the *second* compile pass
  (works fine on a from-scratch compile, then breaks — confusing to
  debug). Fix: wrap the whole `\caption{...}` call in a plain
  `\ifthesisenglish ... \else ... \fi`, or (for `lstlisting`'s
  `caption=` key) resolve to a `\def`'d macro first. See the comments in
  `chapters/ch02_planning_and_management.tex`, `ch05_design.tex`, and
  `ch06_implementation.tex` for the exact pattern — copy it verbatim for
  any new float you add.
- **`\ifdefempty`/`\ifblank` (etoolbox) don't reliably test a macro
  *parameter* that holds another macro's NAME, only a literal macro name
  written directly in the source.** `\tutorlogocell`'s argument (see
  "Cover-page people system" below) arrives as a macro token — `\headerlogoleft` or
  `\@companylogopath`, passed through `\tutor`/`\companytutor` →
  `\tutorcell` → `\tutorlogocell` — and `\@companylogopath` is
  legitimately empty whenever `\companylogo{}` was never called.
  Reliably testing that requires `\edef\tmp{#1}` (forces full expansion)
  then `\ifx\tmp\@empty ... \fi` (the plain LaTeX kernel idiom) instead.
  This bit twice historically (once for the now-removed avatar-photo
  system, again for `\tutorlogocell`) — don't "simplify" it back to
  `\ifdefempty`/`\ifblank`.
- **Chapter opening pages keep the fancy header** (both logos + running
  title), unlike stock `report.cls` which silently switches to a bare
  "plain" page style on the first page of every `\chapter`. This is
  patched away with
  `\patchcmd{\chapter}{\thispagestyle{plain}}{\thispagestyle{fancy}}{}{}`
  — this exactly matches what the Word template does (verified visually
  against the reference PDF).
- **`\tableofcontents`/`\listoffigures`/`\listoftables`/`\lstlistoflistings`
  all internally call `\chapter*`.** The Word template uses a much
  smaller, un-numbered "Subtitle" style for these front-matter page
  titles, not the big chapter style. `\frontmatterlist{...}` (in
  `main.tex`) locally re-`\titleformat`s `\chapter` inside a `\begingroup`
  right before calling one of these, so the override doesn't leak into
  real chapters.
- **Page numbering restart**: the Word template's cover + declaration +
  acknowledgements + TOC/index pages consume "hidden"/continuously-counted
  page numbers, and numbering restarts at 1 right before the
  Resumen/Abstract page (confirmed by inspecting the actual page-number
  fields rendered in the reference PDF, and by the `pgNumType
  start="1"` reset in the docx's section properties). `\startmainmatter`
  (called at the top of `abstract.tex`, not before Chapter 1) replicates
  this.
- **`\@`-prefixed kernel macros (`\@title`, `\@author`, ...) need
  `\makeatletter`/`\makeatother`** around them in any content file (not
  needed inside `uniovitfg.cls` itself, since class files load with `@`
  already catcode-11). Forgetting this in a `.tex` content file doesn't
  error — it silently prints the literal text `title`/`author` etc. This
  bit twice already (`abstract.tex`'s `\thesistypeabbrevvalue` public
  accessor exists specifically so content files don't need
  `\makeatletter` at all for that value; `main.tex`'s `\hypersetup` block
  does need the explicit guard since it uses `\@title`/`\@author`
  directly).
- **Fonts gracefully fall back**: `\IfFontExistsTF{Aptos}{...}{...}` tries
  Aptos → Calibri → Carlito for body text, and Aptos Display → Calibri
  Light → Carlito for the display font. Whoever compiles without Office
  365 / Aptos installed still gets a reasonable, closely-matching result
  (verified: this dev machine only has Calibri, not Aptos, and it falls
  back cleanly).
- **The final Carlito fallback must be loaded by file name
  (`Carlito-Regular.ttf`, with `BoldFont`/`ItalicFont`/`BoldItalicFont`
  keys), never by bare font name (`\setmainfont{Carlito}`).** `\setmainfont`/
  `\IfFontExistsTF` resolve a bare name through the OS's font manager
  (fontconfig on Linux, Core Text on macOS). Overleaf's compile containers
  have the `carlito` TeX package installed (so the `.ttf` files exist
  somewhere in the TEXMF tree) but don't register it as an OS-level font,
  so `\setmainfont{Carlito}` hard-errors there ("Font ... not loadable:
  Metric (TFM) file or installed font not found") even though it compiles
  fine on a machine with Carlito installed as a system font. Giving
  fontspec a filename *with a recognized extension* makes XeTeX/LuaTeX
  resolve it via kpathsea (TeX's own file search across all texmf trees)
  instead — verified locally by forcing MiKTeX to auto-install the
  `carlito` package and confirming XeTeX loads
  `Carlito-Regular/Bold/Italic/BoldItalic.ttf` purely by filename. This is
  the actual bug that broke compilation on Overleaf; don't "simplify" the
  fallback back to a bare name.

## Cover-page people system (author + tutors)

No photos/avatars on the cover as of the current design — an earlier
version had circular photo avatars for everyone (author + tutors), with an
affiliation-logo badge overlapping each tutor's avatar; both were removed
by explicit request, and the now-unused avatar-drawing machinery
(`\authorphoto`, `\authorlink`, `\avatarwithbadge`, `\avatarwithlink`,
`\creditrow`, `\avatarbordercolor`, plus `img/people/`'s photo files) was
deleted outright rather than left dead in the class. If photos come back,
they need to be rebuilt, not just re-wired — check git history for the
old implementation before reinventing it from scratch.

- `\author{Name}` — shown centered, its own line, bigger/bold name text.
  No photo.
- `\tutor{Name}` (academic) / `\companytutor{Name}` (company) — plain
  `\newcommand`s (name only, no optional args anymore). Call once per
  person; there can be any number of each kind. Shown **one per line**
  (not paired), each row: institution logo (university logo for academic
  tutors, `\companylogo{}` for company tutors) on the left, then a small
  role label ("Tutor académico"/"Tutor en empresa") above the name. No
  personal photo, no badge.
- `\companylogo{path}`, if set, ALSO replaces the UNIOVI logo in the
  top-left of every page header (not just the tutor row's institution
  logo) — this was an explicit ask: internship-based theses should show
  the company's brand in the running header, not the university's.
- Implementation: `\tutor`/`\companytutor` `\gappto` (etoolbox, appends
  without expanding) one `\tutorcell{...}` call per person onto an
  accumulator macro (`\@academiccreditrows`/`\@companycreditrows`), which
  `\maketitle` later drops straight into a tabular via `\creditgroup`. No
  odd/even pairing logic anymore (that only existed for the old
  two-per-line layout) — every row self-closes with `\\`.
- **Vertically centering the institution logo against the two-line
  "role\\name" text is NOT what the `m{}` tabular column type gives you
  for free**, even though that's exactly what `m{}` columns are for. A
  plain `\includegraphics` box has all its height above baseline and zero
  depth below; a `\parbox` of wrapped text has the opposite kind of
  lopsided height/depth (concentrated around its own first/last line).
  Centering both via `array`'s `m{}` column (which centers by raw
  height+depth) visibly put the logo too high — confirmed by rendering,
  not just by reasoning about it. The fix (see `\tutorcell`): measure the
  text block into a saved box (`\@tutortextbox`) and `\raisebox` the logo
  by exactly `0.5(\ht - \dp)` of that box, which lines up the logo's own
  visual center with the text block's visual center regardless of either
  box's internal height/depth split. Two gotchas in that fix specifically:
  `\raisebox`'s shift argument doesn't support inline dimen arithmetic
  (`0.5\ht0-0.5\dp0` silently truncates at the first term and dumps the
  leftover tokens as literal text — no error, just "-0.5" printed on the
  page) — wrap it in `\dimexpr ... \relax`. And the `\sbox` that measures
  the text block must be `\global` — `\halign` (which `tabular` is built
  on) groups each cell individually, so a local `\sbox` in the logo cell
  doesn't survive to the `\usebox` in the next cell (the row rendered with
  no tutor text at all until this was caught by rendering, not by
  compiling cleanly — it compiled with zero errors both times).

## Bilingual toggle

`\thesislanguage{spanish}` (default) or `\thesislanguage{english}` in
`main.tex`, near the top. Flips: babel's active language (hyphenation,
`\today`), `\contentsname`/`\listfigurename`/`\listtablename`/
`\chaptername`/`\lstlistingname`/`\bibname`, and every chapter/section
title + placeholder paragraph via `\bilingual{es}{en}` (defined in the
class as a plain `\ifthesisenglish` macro — see the caption-safety caveat
above, the one real gotcha with this mechanism). `\thesistype`/
`\thesistypeabbrev` also get language-appropriate defaults
("Trabajo Fin de Grado"/"TFG" vs "Bachelor's Thesis"/"BSc Thesis"),
resolved lazily in `\AtBeginDocument` and only applied if nothing set
them explicitly already (`\ifdefempty{\@thesistype}` guards it) —
`\degreepreset{master}` sets both explicitly (see below), which is
exactly what makes that guard skip its own default in that case.

Chapter 1 (`ch01_general_description.tex`) is a deliberate exception: its
1.1/1.3 subsections are meant to always show one Spanish blurb (Resumen)
and one English blurb (Abstract) side by side, regardless of
`\thesislanguage`, because Spanish universities typically require both
independent of the thesis's actual writing language. Only that chapter's
own title and the 1.2/1.4 headings ("Palabras clave"/"Keywords") are
language-fixed by design, not bugs. Section 1.1 also carries a live demo
of the `\TODO`/`\augusto`/`\student` draft-review markers (see below).

## School and degree presets

Added by explicit request, on top of the original single-school design
(the class originally hardcoded EPI Gijón everywhere). Two layers, both
resolved **immediately at call time, not deferred** — unlike
`\thesistype`'s `\AtBeginDocument` default above, `\schoolpreset`/
`\degreepreset` branch on `\ifthesisenglish` right when called, which is
only correct because `main.tex` always calls `\thesislanguage{}` earlier
in the preamble than either of these. Don't reorder `main.tex` (or move
either preset's implementation into `\AtBeginDocument`) without
preserving that ordering guarantee.

- `\schoolpreset{epigijon|eii}` — sets `\school{}` (cover text),
  `\schoollogo{}` (a thin wrapper that just `\renewcommand`s
  `\headerlogoright`, the header's top-right logo) and a default
  `\degree{}` for that school, all three in one call. Unknown key →
  `\ClassError`, same pattern as `\thesislanguage{}`.
- `\degreepreset{it|datos|master|software}` — calls `\schoolpreset{}`
  for the right school, then overrides `\degree{}` (and, for `master`,
  `\thesistype{}`/`\thesistypeabbrev{}` too, since a Máster is a TFM, not
  a TFG). `it`/`software` don't re-set `\degree{}` after
  `\schoolpreset{}` — they're already that school's default degree, so
  doing it again would just be redundant, not wrong.
- Every degree name and the two EPI Gijón/EII degree defaults are the
  **official English names** as published on uniovi.es (checked via web
  search, not translated ad hoc) — e.g. "Bachelor's Degree in
  Informatics Engineering in Information Technology", not a literal
  word-for-word translation. If you add another degree preset, look up
  its real English name on uniovi.es rather than guessing one.
- `img/logos/logoeii.pdf` (the EII header logo) is a real file now, but
  it originally shipped as `logo-eii.pdf` (with a hyphen) and had to be
  renamed to match what `\degreepreset{software}`/`\schoolpreset{eii}`
  actually reference — a filename mismatch here fails at
  `\includegraphics` time ("Unable to load picture or PDF file"), not at
  the `\schoolpreset`/`\degreepreset` call itself, so it's easy to miss
  until someone actually compiles with that preset.
- Deliberately NOT a single rigid enum baked into `\maketitle`: `\school`/
  `\schoollogo`/`\degree`/`\thesistype`/`\thesistypeabbrev` all remain
  independently callable (same as `\companylogo`/`\companytutor`
  already were), so a school/degree this template doesn't list is just
  as easy to set up by hand, and any one piece of a preset can be
  overridden by calling that command again afterward.

## Draft-review comments (`extracommands.sty`)

A separate `.sty`, not folded into `uniovitfg.cls`, since it's optional
scaffolding for the writing/review process rather than part of the
thesis's visual design — `main.tex` opts in with
`\usepackage[showcomments,showtodos]{extracommands}` right after
`\documentclass`.

- `\TODO{text}` and the per-reviewer `\augusto{text}`/`\tutortwo{text}`/
  `\student{text}` all funnel through one shared `\todomarker`/
  `\notemarker` implementation (`#1`=color `#2`=`\ding{}` symbol
  `#3`=label `#4`=text): a `\marginnote{}` drops a small colored symbol
  in the margin at the call site, and a real `\footnote{}` carries the
  full labeled text at the bottom of the page. Adding another reviewer
  is just one more `\newcommand{\name}[1]{\notemarker{color}{\ding{n}}{Label}{#1}}`
  line — pick an unused color/`\ding` code so it stays visually distinct
  from the existing ones.
- **Hidden by default, shown via package options**: `showtodos`/
  `showcomments` are two independent `etoolbox` booleans
  (`\newbool`/`\ifbool`), each gating its own marker macro to either the
  real implementation or a no-op (`{}`). Declared via
  `\DeclareOption`/`\ProcessOptions` so `\usepackage{extracommands}`
  alone (no options) compiles a clean copy with zero visual trace, and
  `\usepackage[showcomments,showtodos]{extracommands}` (what `main.tex`
  currently has) shows everything. This is why the calls can stay in the
  source permanently instead of needing to be deleted before the final
  submission compile — just drop the two options.
- The no-op branch matters for more than just hiding text: when a
  marker is off, its `\footnote{}` call never happens either, so hidden
  TODOs/comments don't reserve a footnote number and can't shift the
  numbering of real footnotes around when toggled.
- `\step{n}` (small circled number, e.g. for numbering steps in a
  manual) is unrelated to the comment system — same file only because
  the user asked for both together, not because they share
  implementation.
- Demoed live in `chapters/ch01_general_description.tex` §1.1 (one
  `\TODO`, one `\augusto`, one `\student`, all at the same point in the
  text — that's why their three margin symbols render slightly
  overlapping there, not a bug).
