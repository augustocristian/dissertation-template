%% ============================================================================
%% uniovitfg.cls
%% Unofficial LaTeX template for BSc/MSc theses (TFG/TFM)
%% Escuela Politécnica de Ingeniería de Gijón - Universidad de Oviedo
%%
%% Replicates the visual identity of the research group's Word template:
%% same fonts (Aptos / Aptos Display), same corporate colors, same header
%% with the two logos, same cover page and same chapter/section style
%% ("Capítulo N NOMBRE" in teal, right-aligned).
%%
%% The rendered document text (chapter names, "Contents", figure/table
%% captions...) defaults to Spanish, but can be switched to English from
%% main.tex with \thesislanguage{english}. See the \bilingual command below.
%% ============================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uniovitfg}[2026/07/29 v1.2 Universidad de Oviedo BSc/MSc thesis template]

\LoadClass[a4paper,11pt,twoside]{report}

%% ---------------------------------------------------------------------------
%% This template uses the "Aptos"/"Aptos Display" fonts (Microsoft 365's
%% default fonts since 2024) through fontspec, so it must be compiled with
%% XeLaTeX or LuaLaTeX.
%% ---------------------------------------------------------------------------
\RequirePackage{iftex}
\ifPDFTeX
  \ClassError{uniovitfg}%
    {This template requires XeLaTeX or LuaLaTeX}%
    {Compile with "xelatex" or "lualatex" (fontspec is needed for the Aptos fonts). pdflatex is not supported.}
\fi

%% ---------------------------------------------------------------------------
%% Languages: both Spanish and English are loaded so the document language
%% can be switched at runtime with \thesislanguage (see below). Spanish is
%% the default/main language, matching the original template.
%% ---------------------------------------------------------------------------
\RequirePackage[english,spanish,es-noshorthands,es-lcroman]{babel}

%% ---------------------------------------------------------------------------
%% Page geometry (same as the Word template: A4, 2.5/3 cm margins)
%% ---------------------------------------------------------------------------
\RequirePackage[a4paper,top=2.5cm,bottom=2.5cm,left=3cm,right=3cm,%
  headheight=2.2cm,headsep=8mm,footskip=1.1cm]{geometry}

%% ---------------------------------------------------------------------------
%% Corporate colors (sampled from the Word template)
%% ---------------------------------------------------------------------------
\RequirePackage[table]{xcolor}
\definecolor{uoTeal}{HTML}{008383}      % Chapter title / cover accent
\definecolor{uoTealMedium}{HTML}{00A8A4} % Section title (X.Y)
\definecolor{uoTealLight}{HTML}{00BCB8}  % Subsection / subsubsection title
\definecolor{uoGray}{HTML}{595959}       % Cover subtitle lines
\definecolor{uoDarkTeal}{HTML}{005250}   % Emphasis / code accents

%% ---------------------------------------------------------------------------
%% Fonts: Aptos (body text) / Aptos Display (headings), with automatic
%% fallback if the machine does not have Office 365 / Aptos installed.
%% ---------------------------------------------------------------------------
\RequirePackage{fontspec}

%% Last-resort Carlito fallback: loaded by FILE NAME + extension
%% (Carlito-Regular.ttf, not just "Carlito"). \IfFontExistsTF / a bare
%% \setmainfont{Carlito} resolve font *names* through the OS's font
%% manager (fontconfig on Linux, Core Text on macOS) -- Overleaf's compile
%% containers don't register the "carlito" TeX package's bundled font
%% files as OS fonts, so `\setmainfont{Carlito}` hard-errors there
%% ("Font ... not loadable") even though the files are very much present.
%% Giving fontspec a filename with a recognized extension instead makes
%% XeTeX/LuaTeX resolve it via kpathsea (TeX's own file search across all
%% texmf trees), independent of OS font registration -- this works
%% anywhere the "carlito" package is installed, which is effectively every
%% TeX Live/MiKTeX (it ships in collection-fontsrecommended). Don't
%% simplify this back to `\setmainfont{Carlito}`: it compiles fine on a
%% machine with Carlito installed as an OS font, then fails on Overleaf.
\IfFontExistsTF{Aptos}
  {\setmainfont{Aptos}}
  {\IfFontExistsTF{Calibri}
    {\setmainfont{Calibri}}
    {\setmainfont{Carlito-Regular.ttf}[
       BoldFont       = Carlito-Bold.ttf,
       ItalicFont     = Carlito-Italic.ttf,
       BoldItalicFont = Carlito-BoldItalic.ttf,
     ]}}

\IfFontExistsTF{Aptos Display}
  {\newfontfamily\thesisdisplayfont{Aptos Display}}
  {\IfFontExistsTF{Calibri Light}
    {\newfontfamily\thesisdisplayfont{Calibri Light}[BoldFont={Calibri}]}
    {\newfontfamily\thesisdisplayfont{Carlito-Regular.ttf}[
       BoldFont       = Carlito-Bold.ttf,
       ItalicFont     = Carlito-Italic.ttf,
       BoldItalicFont = Carlito-BoldItalic.ttf,
     ]}}

%% ---------------------------------------------------------------------------
%% Supporting packages
%% ---------------------------------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{etoolbox}
\RequirePackage{enumitem}
\RequirePackage{booktabs}
\RequirePackage{array}

%% All table rules (\hline, \toprule/\midrule/\bottomrule from booktabs)
%% are teal, matching the rest of the corporate identity; use
%% \tableheaderfont at the start of a header row to color/bold it in the
%% darker teal, e.g.:
%%   \toprule
%%   \tableheaderfont Column A & Column B \\
%%   \midrule
\arrayrulecolor{uoTeal}
\newcommand{\tableheaderfont}{\bfseries\color{uoDarkTeal}}
\RequirePackage{ragged2e}
\RequirePackage{caption}
\RequirePackage{listings}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{csquotes}
% IEEE-style bibliography: numbered entries, in-text citations as "[1]".
\RequirePackage[backend=biber,style=ieee,sorting=none]{biblatex}
\RequirePackage{hyperref}

%% ---------------------------------------------------------------------------
%% Logo file paths (extracted from the original Word template)
%% ---------------------------------------------------------------------------
\newcommand{\coverlogo}{img/logos/logouniovi-header.pdf}
\newcommand{\headerlogoleft}{img/logos/logouniovi.pdf}
% Default school logo shown top-right in the header (EPI Gijón). Override
% with \schoollogo{...} for a different school -- see below.
\newcommand{\headerlogoright}{img/logos/logoepigijon.pdf}

% \schoollogo{path} switches the school logo shown top-right in the
% header of every page (e.g. for the Escuela de Ingeniería Informática
% instead of the default EPI Gijón). Call it together with \school{...}
% in main.tex so the header logo and the cover's school-name text stay in
% sync -- they are independent commands, not a single "school preset",
% matching how \companylogo{}/\school{} already work.
\newcommand{\schoollogo}[1]{\renewcommand{\headerlogoright}{#1}}

%% If the thesis was done in collaboration with a company, \companylogo{}
%% replaces the top-left UNIOVI logo in the header with the company's own
%% logo. Leave unset to keep the default UNIOVI logo.
\newcommand{\@companylogopath}{}
\newcommand{\companylogo}[1]{\renewcommand{\@companylogopath}{#1}}
% Resolved at every use (not at class-load time) so it picks up whatever
% \companylogo{} main.tex sets, however late in the preamble that happens.
\newcommand{\headerlogoleftimage}{%
  \ifdefempty{\@companylogopath}%
    {\includegraphics[height=1cm]{\headerlogoleft}}%
    {\includegraphics[height=1cm]{\@companylogopath}}%
}

%% ---------------------------------------------------------------------------
%% Document language toggle
%%
%% Usage in main.tex:
%%   \thesislanguage{spanish}   (default: chapter/section titles, front
%%                               matter and running chrome in Spanish)
%%   \thesislanguage{english}   (same structure, but in English)
%%
%% Chapter/section files use \bilingual{<spanish text>}{<english text>}
%% for every heading (and, where provided, every placeholder paragraph) so
%% a single source file serves both languages.
%% ---------------------------------------------------------------------------
\newif\ifthesisenglish
\thesisenglishfalse

\newcommand{\thesislanguage}[1]{%
  \ifstrequal{#1}{english}{\thesisenglishtrue}{%
  \ifstrequal{#1}{spanish}{\thesisenglishfalse}{%
    \ClassError{uniovitfg}{Unknown thesis language '#1'}%
      {Use \string\thesislanguage{spanish} or \string\thesislanguage{english}.}%
  }}%
}

\newcommand{\bilingual}[2]{\ifthesisenglish #2\else #1\fi}

%% ---------------------------------------------------------------------------
%% Thesis metadata (set from main.tex)
%% ---------------------------------------------------------------------------
%% Supervisors: there can be several, of two kinds -- academic supervisors
%% (from the university) and company/industry supervisors (for
%% internship-based theses). Call \tutor{Name} / \companytutor{Name} once
%% per person; the cover page shows each one on its own line: the
%% institution logo on the left (university logo, or \companylogo{} for
%% company tutors), then a role label and the name. No personal photo.
%%
%% Implementation note: each \tutor/\companytutor call just appends one
%% self-contained row to an accumulator macro (\gappto, from etoolbox,
%% appends WITHOUT expanding, so \bilingual/\headerlogoleft stay untouched
%% until \maketitle actually typesets them).
\newcounter{academictutorcount}
\newcounter{companytutorcount}
\newcommand{\@academiccreditrows}{}
\newcommand{\@companycreditrows}{}

% Institution (university/company) logo shown to the left of each tutor
% row. #1 arrives as a macro token (\headerlogoleft or \@companylogopath,
% see \tutor/\companytutor below) rather than already-substituted literal
% text, so \ifdefempty/\ifblank (which test the argument's raw tokens --
% a macro NAME -- not what it expands to) won't reliably detect
% emptiness here. \edef first (forces full expansion either way), then
% the plain kernel \ifx...\@empty idiom: \@companylogopath is legitimately
% empty whenever \companylogo{} was never called, and \includegraphics{}
% on an empty path would error.
\newcommand{\tutorlogocell}[1]{%
  \edef\@tutorlogopath{#1}%
  \ifx\@tutorlogopath\@empty\else
    \includegraphics[height=0.7cm]{\@tutorlogopath}%
  \fi
}

% One tutor row: institution logo (left), then role + name. No personal
% photo avatar. Tutors are listed one per line (not paired), so each row
% just closes itself with "\\".
%
% Vertical centering note: a plain \includegraphics box has all of its
% height above the baseline and zero depth below, while the role+name
% \parbox has the opposite kind of lopsided height/depth (concentrated
% around its own first/last line). Relying on the tabular "m{}" column
% type to center both against each other does NOT produce a visually
% centered logo (confirmed by rendering: it comes out sitting high) --
% array's "m" centers by box height+depth, and the two boxes' height/depth
% splits don't match. Instead the text block is measured into \@tutortextbox
% once, and the logo is \raisebox-ed by exactly half of that box's
% (height-depth), which puts the logo's own visual center on the same
% baseline as the text block's visual center regardless of either box's
% internal height/depth convention.
% \sbox below is a local assignment, but each tabular cell is typeset in
% its own group (\halign), so it must be \global to still hold the right
% content once we reach the \usebox in the *next* cell.
\newsavebox{\@tutortextbox}
\newcommand{\tutorcell}[3]{% #1=institution logo #2=role #3=name
  \global\sbox{\@tutortextbox}{\parbox{6.2cm}{\raggedright
    {\fontsize{8}{10}\selectfont\color{uoGray}#2}\\[1pt]
    {\fontsize{11}{13}\selectfont\color{uoGray}\bfseries #3}}}%
  \raisebox{\dimexpr 0.5\ht\@tutortextbox-0.5\dp\@tutortextbox-0.5\height\relax}{\tutorlogocell{#1}} &
  \usebox{\@tutortextbox}\\[8pt]%
}

\newcommand{\tutor}[1]{%
  \stepcounter{academictutorcount}%
  \gappto{\@academiccreditrows}{\tutorcell{\headerlogoleft}{\bilingual{Tutor académico}{Academic Supervisor}}{#1}}%
}
\newcommand{\companytutor}[1]{%
  \stepcounter{companytutorcount}%
  \gappto{\@companycreditrows}{\tutorcell{\@companylogopath}{\bilingual{Tutor en empresa}{Company Supervisor}}{#1}}%
}

\newcommand{\@thesisschool}{}
\newcommand{\school}[1]{\renewcommand{\@thesisschool}{#1}}

\newcommand{\@thesisdegree}{}
\newcommand{\degree}[1]{\renewcommand{\@thesisdegree}{#1}}

% Convenience shortcut for a school this template ships defaults for:
% sets \school, \schoollogo and \degree together in one call. The degree
% text is picked based on \ifthesisenglish, so call \schoolpreset{} (like
% \degreepreset{} below) AFTER \thesislanguage{} in main.tex -- resolved
% immediately, not deferred to \AtBeginDocument, since by then
% \thesislanguage{}'s choice is already final. Call
% \school{}/\schoollogo{}/\degree{} again afterward to override just one
% of the three (e.g. a different degree at the same school), or ignore
% this entirely and call all three by hand for a school not listed here.
\newcommand{\schoolpreset}[1]{%
  \ifstrequal{#1}{epigijon}{%
    \school{Escuela Politécnica de Ingeniería de Gijón}%
    \schoollogo{img/logos/logoepigijon.pdf}%
    \ifthesisenglish
      \degree{Bachelor's Degree in Informatics Engineering in Information Technology}%
    \else
      \degree{Grado en Ingeniería Informática en Tecnologías de la Información}%
    \fi
  }{%
  \ifstrequal{#1}{eii}{%
    \school{Escuela de Ingeniería Informática}%
    \schoollogo{img/logos/logoeii.pdf}%
    \ifthesisenglish
      \degree{Bachelor's Degree in Software Engineering}%
    \else
      \degree{Grado en Ingeniería Informática del Software}%
    \fi
  }{%
    \ClassError{uniovitfg}{Unknown school preset '#1'}%
      {Use \string\schoolpreset{epigijon} or \string\schoolpreset{eii}, or set \string\school{}/\string\schoollogo{}/\string\degree{} by hand.}%
  }}%
}

\newcommand{\@thesistype}{}
\newcommand{\thesistype}[1]{\renewcommand{\@thesistype}{#1}}

\newcommand{\@thesistypeabbrev}{}
\newcommand{\thesistypeabbrev}[1]{\renewcommand{\@thesistypeabbrev}{#1}}

% Public (no \makeatletter needed) read accessors, for use in content
% files such as chapters/*.tex or abstract.tex.
\newcommand{\thesistypevalue}{\@thesistype}
\newcommand{\thesistypeabbrevvalue}{\@thesistypeabbrev}

% Convenience shortcut for a specific degree ("titulación") this template
% ships defaults for: picks the school (via \schoolpreset{}) and the
% degree name, and, for a Máster, \thesistype{}/\thesistypeabbrev{} too
% (Trabajo Fin de Máster/TFM instead of the Grado/TFG default). Same
% immediate-resolution rule as \schoolpreset{}: call it AFTER
% \thesislanguage{} in main.tex. Call \degree{}/\thesistype{}/
% \thesistypeabbrev{} again afterward to override just one of them, e.g.
% for a degree this template doesn't list here.
\newcommand{\degreepreset}[1]{%
  \ifstrequal{#1}{it}{%
    \schoolpreset{epigijon}% already the EPI Gijón default degree
  }{%
  \ifstrequal{#1}{datos}{%
    \schoolpreset{epigijon}%
    \ifthesisenglish
      \degree{Bachelor's Degree in Data Science and Engineering}%
    \else
      \degree{Grado en Ciencia e Ingeniería de Datos}%
    \fi
  }{%
  \ifstrequal{#1}{master}{%
    \schoolpreset{epigijon}%
    \ifthesisenglish
      \degree{Master's Degree in Informatics Engineering}%
      \thesistype{Master's Thesis}%
      \thesistypeabbrev{MSc Thesis}%
    \else
      \degree{Máster en Ingeniería Informática}%
      \thesistype{Trabajo Fin de Máster}%
      \thesistypeabbrev{TFM}%
    \fi
  }{%
  \ifstrequal{#1}{software}{%
    \schoolpreset{eii}% already the EII default degree
  }{%
    \ClassError{uniovitfg}{Unknown degree preset '#1'}%
      {Use one of: it, datos, master, software; or set \string\school{}/\string\schoollogo{}/\string\degree{} by hand.}%
  }}}}%
}

\newcommand{\@thesisdate}{}
\newcommand{\thesisdate}[1]{\renewcommand{\@thesisdate}{#1}}

\newcommand{\@thesisdni}{}
\newcommand{\dni}[1]{\renewcommand{\@thesisdni}{#1}}

\newcommand{\@thesisyear}{}
\newcommand{\academicyear}[1]{\renewcommand{\@thesisyear}{#1}}

\newcommand{\@thesiscity}{Gijón}
\newcommand{\city}[1]{\renewcommand{\@thesiscity}{#1}}

%% ---------------------------------------------------------------------------
%% Language-dependent chrome: fixed here after babel has loaded, and
%% re-evaluated for whichever language \thesislanguage selected. Also
%% provides sensible defaults for \thesistype / \thesistypeabbrev if the
%% user did not set them explicitly in main.tex.
%% ---------------------------------------------------------------------------
\AtBeginDocument{%
  \ifthesisenglish
    \selectlanguage{english}%
    \renewcommand{\contentsname}{Contents}%
    \renewcommand{\listfigurename}{List of Figures}%
    \renewcommand{\listtablename}{List of Tables}%
    \renewcommand{\figurename}{Figure}%
    \renewcommand{\tablename}{Table}%
    \renewcommand{\chaptername}{Chapter}%
    \renewcommand{\lstlistingname}{Listing}%
    \renewcommand{\lstlistlistingname}{List of Listings}%
    \renewcommand{\bibname}{References}%
    \ifdefempty{\@thesistype}{\renewcommand{\@thesistype}{Bachelor's Thesis}}{}%
    \ifdefempty{\@thesistypeabbrev}{\renewcommand{\@thesistypeabbrev}{BSc Thesis}}{}%
  \else
    \selectlanguage{spanish}%
    \renewcommand{\contentsname}{Contenidos}%
    \renewcommand{\listfigurename}{Índice de figuras}%
    \renewcommand{\listtablename}{Índice de tablas}%
    \renewcommand{\figurename}{Ilustración}%
    \renewcommand{\tablename}{Tabla}%
    \renewcommand{\chaptername}{Capítulo}%
    \renewcommand{\lstlistingname}{Código}%
    \renewcommand{\lstlistlistingname}{Índice de fragmentos de código}%
    \renewcommand{\bibname}{Bibliografía}%
    \ifdefempty{\@thesistype}{\renewcommand{\@thesistype}{Trabajo Fin de Grado}}{}%
    \ifdefempty{\@thesistypeabbrev}{\renewcommand{\@thesistypeabbrev}{TFG}}{}%
  \fi
}

%% ---------------------------------------------------------------------------
%% Fake small caps for chapter titles
%% ---------------------------------------------------------------------------
%% \scshape only produces real small-caps glyphs when the active font has an
%% OpenType "smcp" table. Aptos/Aptos Display and Calibri/Calibri Light do;
%% the last-resort Carlito fallback does not -- confirmed empirically: XeTeX
%% just substitutes the regular upright shape and warns "Font shape .../sc
%% undefined". So a chapter title styled with plain \scshape looked
%% completely different (no small caps at all) depending on which of the
%% three font tiers resolved on the compiling machine -- this is exactly
%% why a PDF built by GitHub Actions (whose container has none of
%% Aptos/Calibri installed, so it always lands on the Carlito tier) looked
%% different from a PDF built locally on a machine with Calibri or Aptos.
%%
%% \fakesmallcaps{<small size>}{<text>} sidesteps the font-feature
%% dependency entirely: it walks <text> character by character and
%% re-typesets every character \MakeUppercase would change (i.e. every
%% originally-lowercase letter) in uppercase at <small size>, leaving
%% already-uppercase characters (and spaces/digits/punctuation) at whatever
%% size was already active. Since this never relies on the font actually
%% having small-caps glyphs, it looks identical on all three fallback
%% tiers -- that's the whole point.
%%
%% Two implementation details below were only found by rendering and
%% inspecting the output, not by reading the expl3 docs -- don't
%% "simplify" either one back out:
%%   - Must map with \str_map_inline:Nn (string mapping), not
%%     \tl_map_inline:nn (token-list mapping): tl mapping silently drops
%%     space tokens between words, which runs every word in a title
%%     together with no error, just wrong output.
%%   - <text> is expanded ("x") into a string BEFORE mapping, so a
%%     fully-expandable macro like \thechapter (a bare arabic numeral)
%%     resolves to its digit(s) first. Skipping this prints the literal
%%     control-sequence name ("\thechapter") as text instead of "1".
%% Consequence: <text> must be plain text plus fully-expandable macros
%% (numeral counters etc.) -- NOT arbitrary formatting commands like
%% \textbf{...}, which are not expandable and would print literally
%% instead of being executed. Chapter titles in this template are plain
%% text, so this isn't a real-world limitation here.
\RequirePackage{xparse}
\ExplSyntaxOn
\NewDocumentCommand{\fakesmallcaps}{mm}{%
  \group_begin:
  \str_set:Nx \l_tmpa_str { #2 }
  \str_map_inline:Nn \l_tmpa_str
    {
      \tl_if_eq:eeTF { \tl_upper_case:n {##1} } { ##1 }
        { ##1 }
        { {\fontsize{#1}{#1}\selectfont \tl_upper_case:n {##1}} }
    }
  \group_end:
}
\ExplSyntaxOff

%% ---------------------------------------------------------------------------
%% Chapter / section style
%% (same size/color hierarchy as "Heading 1..4" in the Word template)
%% ---------------------------------------------------------------------------
% Chapter: "Chapter N NAME", fake small caps (see above), bold, teal,
% right-aligned (matches the Word "Heading 1" style). The chapter number
% and the "~" tying it to the label are deliberately kept OUTSIDE
% \fakesmallcaps: a digit is already case-invariant (no need to run it
% through the character-by-character machinery), and "~" is babel's active
% non-breaking-space character, which \fakesmallcaps's string-expansion
% step should not be trusted to pass through unchanged.
% \hyphenpenalty/\exhyphenpenalty=10000 on every heading level below
% disables both normal and explicit (hard-hyphen) word breaks in titles,
% so a long word never splits across two lines -- it overflows or wraps
% whole instead.
\titleformat{\chapter}[block]
  {\normalfont\RaggedLeft\bfseries\thesisdisplayfont\fontsize{24}{28}\selectfont\color{uoTeal}\hyphenpenalty=10000\exhyphenpenalty=10000}
  {\fakesmallcaps{17}{\chaptertitlename}~\thechapter}
  {0.6em}
  {\fakesmallcaps{17}}
\titlespacing*{\chapter}{0pt}{10pt}{40pt}

% Section: "N.M. Name", small caps, medium teal (Word "Heading 2")
\titleformat{\section}
  {\normalfont\scshape\thesisdisplayfont\fontsize{16}{19}\selectfont\color{uoTealMedium}\hyphenpenalty=10000\exhyphenpenalty=10000}
  {\thesection.}
  {0.5em}
  {}
\titlespacing*{\section}{0pt}{18pt}{8pt}

% Subsection: "N.M.P. name", no small caps, light teal (Word "Heading 3")
\titleformat{\subsection}
  {\normalfont\fontsize{14}{17}\selectfont\color{uoTealLight}\hyphenpenalty=10000\exhyphenpenalty=10000}
  {\thesubsection.}
  {0.5em}
  {}
\titlespacing*{\subsection}{0pt}{14pt}{6pt}

% Subsubsection (Word "Heading 4")
\titleformat{\subsubsection}
  {\normalfont\color{uoTealLight}\hyphenpenalty=10000\exhyphenpenalty=10000}
  {\thesubsubsection.}
  {0.5em}
  {}
\titlespacing*{\subsubsection}{0pt}{10pt}{4pt}

% In the Word template, chapter opening pages do NOT switch to a bare
% "plain" style: both header logos still show up on the first page of
% every chapter, so we patch that away.
\patchcmd{\chapter}{\thispagestyle{plain}}{\thispagestyle{fancy}}{}{}

%% ---------------------------------------------------------------------------
%% Header / footer (logos + running chapter title + page number)
%% ---------------------------------------------------------------------------
\pagestyle{fancy}
\fancyhf{}
% "-0.5\height" on every header zone centers each one on the same
% baseline, so the two (differently-shaped) logos and the running
% chapter title all line up vertically no matter their own size.
\fancyhead[L]{\raisebox{-0.5\height}{\headerlogoleftimage}}
\fancyhead[R]{\raisebox{-0.5\height}{\includegraphics[height=1cm]{\headerlogoright}}}
% \leftmark itself can't be fed to \fakesmallcaps: babel wraps whatever
% \markboth stores in \protect\foreignlanguage{...}{...} (so the running
% head keeps the right hyphenation/language context even if read back on a
% page where the "current" babel language has since changed) -- and
% \protect exists specifically to survive expansion, so \str_set:Nx can't
% strip it, and mapping over it character-by-character prints that
% wrapper's control-sequence names as literal text instead of the title.
% \@currentchaptertitle sidesteps this by capturing the same raw #1 text
% \chaptermark receives, in parallel with (not instead of) the normal
% \markboth call that hyperref/bookmarks still need.
\newcommand{\@currentchaptertitle}{}
\fancyhead[C]{\raisebox{-0.5\height}{\thesisdisplayfont\normalsize\bfseries\color{uoTeal}\fakesmallcaps{7.9}{\@currentchaptertitle}}}
\fancyfoot[R]{\thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
% Word's STYLEREF field only ever pulled the chapter name (no "Chapter N"
% prefix), so the running head mark should only store the title text.
\renewcommand{\chaptermark}[1]{\gdef\@currentchaptertitle{#1}\markboth{#1}{}}

% Style for preliminary pages that show the header logos but no footer
% (Statement of Authorship, Acknowledgements), just like in the Word file.
\fancypagestyle{nofooter}{%
  \fancyhf{}
  \fancyhead[L]{\raisebox{-0.5\height}{\headerlogoleftimage}}
  \fancyhead[R]{\raisebox{-0.5\height}{\includegraphics[height=1cm]{\headerlogoright}}}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

%% ---------------------------------------------------------------------------
%% Small preliminary-page titles (Contents, List of Figures, List of
%% Tables, List of Listings...): in Word these use the "Subtitle" style in
%% uppercase teal text, much smaller than an actual chapter title.
%% \tableofcontents, \listoffigures, \listoftables and \lstlistoflistings
%% all call \chapter* internally, so we redefine \chapter* locally right
%% before invoking them.
%% ---------------------------------------------------------------------------
\newcommand{\frontmatterlist}[1]{%
  \begingroup
    \titleformat{\chapter}[block]
      {\normalfont\fontsize{14}{17}\selectfont\color{uoTeal}\hyphenpenalty=10000\exhyphenpenalty=10000}
      {}{0pt}{}
    \titlespacing*{\chapter}{0pt}{0pt}{10pt}
    #1
  \endgroup
}

%% ---------------------------------------------------------------------------
%% Code listings ("Código"/"Listing" -> List of Listings)
%% ---------------------------------------------------------------------------
\lstdefinestyle{thesiscode}{
  basicstyle=\ttfamily\small,
  backgroundcolor=\color{black!4},
  frame=single,
  rulecolor=\color{black!35},
  breaklines=true,
  breakatwhitespace=false,
  showstringspaces=false,
  tabsize=2,
  captionpos=b,
  numbers=left,
  numberstyle=\tiny\color{black!50},
  keywordstyle=\bfseries\color{uoTeal},
  commentstyle=\itshape\color{black!50},
  stringstyle=\color{uoDarkTeal},
}
\lstset{style=thesiscode}

%% ---------------------------------------------------------------------------
%% "RQ n)" requirement lists (as in the User Requirements chapter)
%% ---------------------------------------------------------------------------
\newlist{requirements}{enumerate}{3}
\setlist[requirements,1]{
  label=\textbf{\textcolor{uoTealMedium}{RQ \arabic*)}},
  ref=RQ~\arabic*, leftmargin=2.4em
}
\setlist[requirements,2]{
  label=\textbf{\textcolor{uoTealMedium}{RQ \arabic{requirementsi}.\arabic*)}},
  ref=RQ~\arabic{requirementsi}.\arabic*, leftmargin=3.6em
}
\setlist[requirements,3]{
  label=\textbf{\textcolor{uoTealMedium}{RQ \arabic{requirementsi}.\arabic{requirementsii}.\arabic*)}},
  ref=RQ~\arabic{requirementsi}.\arabic{requirementsii}.\arabic*, leftmargin=4.8em
}

%% ---------------------------------------------------------------------------
%% "Sheet" (ficha): a small two-column fact card used in the planning
%% chapter to describe one risk, WBS work package, stakeholder, etc. --
%% a teal title bar followed by field/value rows. Sheets are meant to
%% live in their own files under sheets/ and be pulled in with \input,
%% see sheets/risk_sheet_example.tex.
%% ---------------------------------------------------------------------------
\newenvironment{sheet}[1]{%
  \begingroup
  \renewcommand{\arraystretch}{1.4}
  \begin{center}
  \begin{tabular}{|>{\bfseries\color{uoTealMedium}\centering\arraybackslash}m{3.6cm}|>{\centering\arraybackslash}m{8.6cm}|}
    \hline
    \multicolumn{2}{|c|}{\cellcolor{uoTeal}\textcolor{white}{\bfseries #1}} \\
    \hline
}{%
    \hline
  \end{tabular}
  \end{center}
  \endgroup
}
\newcommand{\sheetfield}[2]{#1 & #2 \\ \hline}

%% ---------------------------------------------------------------------------
%% Page-number reset at the start of the main body.
%% In the Word template, the cover and the preliminary pages consume
%% "hidden" page numbers, and the numbering restarts at page 1 right
%% before the Abstract/Chapter 1. Call \startmainmatter right before that.
%% ---------------------------------------------------------------------------
\newcommand{\startmainmatter}{%
  \cleardoublepage
  \pagenumbering{arabic}
  \setcounter{page}{1}
}

%% ---------------------------------------------------------------------------
%% Cover page (replica of the Word template's title page)
%% ---------------------------------------------------------------------------
\newcommand{\covertitle}[1]{%
  {\thesisdisplayfont\fontsize{30}{34}\selectfont\centering #1\par}%
}
\newcommand{\coversubtitle}[1]{%
  {\fontsize{15}{18}\selectfont\color{uoGray}\centering #1\par}%
}
\newcommand{\coversubtitlebold}[1]{%
  {\fontsize{15}{18}\selectfont\color{uoGray}\bfseries\centering #1\par}%
}

% A group of supervisor cells, one per line: institution logo, role +
% name (see \tutorcell). #1 = accumulated \tutorcell{...} calls
% (\@academiccreditrows or \@companycreditrows). Each cell already shows
% its own role label ("Tutor académico"...) above the name, so the group
% itself has no separate heading.
\newcommand{\creditgroup}[1]{%
  \par\vspace{12pt}
  \begin{flushleft}
  \setlength{\tabcolsep}{6pt}
  \begin{tabular}{%
    @{}>{\centering\arraybackslash}m{1.6cm}%
    >{\raggedright\arraybackslash}m{6.2cm}@{}}
    #1
  \end{tabular}
  \end{flushleft}
}

\renewcommand{\maketitle}{%
  \begin{titlepage}
  \thispagestyle{empty}
  \setlength{\parindent}{0pt}
  \begin{center}
    \vspace*{0.06\textheight}
    \includegraphics[width=10.2cm]{\coverlogo}\\[2.2em]
    \covertitle{\@title}
    \vspace{1.4em}
    \coversubtitle{\@thesisschool}
    \coversubtitle{\@thesisdegree}
  \end{center}
  \vfill
  \begin{center}
    {\fontsize{11}{13}\selectfont\color{uoGray}\bilingual{Autor}{Author}}\\[5pt]
    {\fontsize{17}{20}\selectfont\color{uoGray}\bfseries \@author}
  \end{center}
  \vspace{2em}
  \ifnum\value{academictutorcount}>0
    \creditgroup{\@academiccreditrows}
  \fi
  \ifnum\value{companytutorcount}>0
    \creditgroup{\@companycreditrows}
  \fi
  \vfill
  \begin{flushright}
    {\fontsize{15}{18}\selectfont\color{uoGray}\@thesisdate\par}
  \end{flushright}
  \end{titlepage}
}

%% ---------------------------------------------------------------------------
%% Title for free-text preliminary pages (Statement of Authorship,
%% Acknowledgements): teal "Subtitle" style, no small caps because the
%% text is already written in uppercase, exactly as in the Word template.
%% ---------------------------------------------------------------------------
\newcommand{\frontpagetitle}[1]{%
  {\fontsize{14}{17}\selectfont\color{uoTeal}#1\par}
  \vspace{12pt}
}

\endinput
