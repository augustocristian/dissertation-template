<div align="center">

# Plantilla LaTeX de TFG/TFM — Universidad de Oviedo

Réplica en LaTeX de la plantilla Word del grupo de investigación
(Escuela Politécnica de Ingeniería de Gijón), ampliada con varias
funcionalidades propias: idioma conmutable, varias escuelas/titulaciones,
comentarios de revisión, fichas, bibliografía IEEE y PDF automático.

[![Build thesis PDF](https://github.com/augustocristian/dissertation-template/actions/workflows/build-thesis.yml/badge.svg)](https://github.com/augustocristian/dissertation-template/actions/workflows/build-thesis.yml)
[![Último PDF](https://img.shields.io/badge/%C3%9Altimo_PDF-descargar-008383)](https://github.com/augustocristian/dissertation-template/releases/tag/latest-pdf)
[![Último commit](https://img.shields.io/github/last-commit/augustocristian/dissertation-template?color=00A8A4&label=%C3%BAltimo%20commit)](https://github.com/augustocristian/dissertation-template/commits/main)
![XeLaTeX](https://img.shields.io/badge/compilador-XeLaTeX_%2B_biber-008383)
![Idiomas](https://img.shields.io/badge/idioma-ES_%7C_EN-00A8A4)
[![Overleaf](https://img.shields.io/badge/Overleaf-compatible-47A141?logo=overleaf&logoColor=white)](#compilar-en-overleaf)

</div>

---

## Índice

1. [Qué tienes que cambiar (empieza aquí)](#qué-tienes-que-cambiar-empieza-aquí)
2. [Qué incluye la plantilla](#qué-incluye-la-plantilla)
3. [Requisitos](#requisitos)
4. [Compilar](#compilar)
   - [Por línea de comandos](#por-línea-de-comandos)
   - [En Overleaf](#compilar-en-overleaf)
   - [En local con VSCode](#compilar-en-local-con-vscode)
5. [PDF automático con GitHub Actions](#pdf-automático-con-github-actions)
6. [Estructura del proyecto](#estructura-del-proyecto)
7. [Guía de personalización](#guía-de-personalización)
   - [Escuela y titulación](#escuela-y-titulación)
   - [Autor y tutores](#autor-y-tutores)
   - [Comentarios de revisión y TODOs](#comentarios-de-revisión-y-todos)
   - [Fichas ("sheets")](#fichas-sheets)
   - [Fragmentos de código en fichero aparte](#fragmentos-de-código-en-fichero-aparte)
   - [Bibliografía (IEEE)](#bibliografía-ieee)
   - [Tablas](#tablas)
   - [Conmutador de idioma](#conmutador-de-idioma)
8. [Problemas frecuentes](#problemas-frecuentes)

---

## Qué tienes que cambiar (empieza aquí)

Esta plantilla es un TFG de **ejemplo** completo. Para convertirla en el
tuyo solo tocas **tus** datos y **tus** textos; el diseño (`uniovitfg.cls`)
no hace falta tocarlo.
### 1. Crea tu propio repositorio emplando la plantilla.

Pulsa en `Use this Template` y crea tu repositorio **PRIVADO** siguiendo el convenio de nombre `{TFG|TFM}<AÑO(YY)>-{EII|EPI}-<APELLIDO><NOMBRE>`. Pon una descripción adecuada al mismo y compártelo con **TODOS** tus tutores.

### 2. Tus datos — `main.tex`

Todo está al principio del fichero, en la sección *"THESIS METADATA"*:

| Qué | Dónde en `main.tex` | Qué poner |
|---|---|---|
| Idioma | `\thesislanguage{spanish}` | `spanish` o `english` — cambia portada, títulos, pies de figura… |
| Título | `\title{...}` | El título de tu trabajo |
| Autor/a | `\author{...}` | **`Nombre Apellido1 Apellido2`** (ese orden; ver el aviso de abajo) |
| Tutores académicos | `\tutor{...}` | Uno por tutor; añade o borra líneas |
| Tutor de empresa | `\companytutor{...}` + `\companylogo{...}` | Solo si el TFG es en empresa. **Si no, borra las dos líneas** |
| Escuela y titulación | `\degreepreset{it}` | `it`, `datos`, `master` o `software` ([detalle](#escuela-y-titulación)) |
| Fecha de portada | `\thesisdate{...}` | Mes y año, p. ej. `julio de 2026` |
| Ciudad | `\city{...}` | Para la declaración de autoría |
| Curso | `\academicyear{...}` | p. ej. `2025--2026` |
| DNI | `\dni{...}` | Tu número de identificación |
| Comentarios de revisión | `\usepackage[showcomments,showtodos]{extracommands}` | **Antes de entregar**, quita las opciones `[showcomments,showtodos]` |

> **El nombre del PDF sale de estos datos.** El PDF que genera GitHub
> Actions se llama `{año}-{escuela}-{TFG|TFM}-{ApellidosNombre}-{rama}-{commit}.pdf`
> y se calcula a partir de `\thesisdate`, `\degreepreset` y `\author`. Escribe
> el autor como `Nombre Apellido1 Apellido2`: las **dos últimas palabras** se
> toman como apellidos y pasan delante (p. ej. `María José Pérez Gómez` →
> `PerezGomezMariaJose`). Detalles en
> [PDF automático](#pdf-automático-con-github-actions).

### 3. Tus textos

| Fichero | Qué hacer |
|---|---|
| `declaration.tex` | Revisa la declaración de autoría (usa tus datos de `main.tex`) |
| `acknowledgements.tex` | Escribe tus agradecimientos |
| `abstract.tex` | Escribe el resumen / abstract |
| `chapters/ch01_…ch09_*.tex` | Sustituye el texto de ejemplo por el tuyo. Mantén los `\chapter`/`\section` y borra lo que no necesites |
| `bibliography.bib` | Sustituye las 5 referencias de ejemplo por las tuyas (`\cite{clave}`) |

### 4. Limpieza del ejemplo (antes de entregar)

- Borra los marcadores de demostración `\TODO`, `\augusto`, `\student`… de
  `chapters/ch01_general_description.tex` (o quita las opciones del
  paquete, ver tabla anterior).
- Sustituye o borra los ejemplos: `sheets/risk_sheet_example.tex`
  (+ su `\input` en el capítulo 2), `snippets/Average.java` (+ su
  `\lstinputlisting` en el capítulo 6), la tabla y la figura de ejemplo.
- Sustituye `img/logos/company_logo_placeholder.png` por el logo real de la
  empresa, o bórralo si no hay tutor de empresa.

### 5. Compila y revisa

Mira [Compilar](#compilar) y comprueba el PDF completo: portada, índices,
numeración de páginas y bibliografía.

---

## Qué incluye la plantilla

- **Portada**: logotipo oficial de la Universidad de Oviedo, título, escuela,
  titulación, autor/a, tutores académicos y de empresa (cada uno con el logo
  de su institución a la izquierda), mes y año alineado a la derecha.
- **Cabecera** de todas las páginas: logo institucional (izquierda; se
  sustituye por el de la empresa si el trabajo es en colaboración con una),
  título del capítulo actual (centro, en teal, tipografía Aptos Display) y
  logo de la escuela (derecha), los tres a la misma altura.
- **Pie de página**: número de página a la derecha.
- **Colores corporativos**: teal `#008383` (capítulos), `#00A8A4`
  (secciones), `#00BCB8` (subsecciones); líneas de tablas en teal y
  cabeceras de tabla en teal oscuro.
- **Tipografías**: Aptos (texto) y Aptos Display (títulos), las de la
  plantilla Word (Microsoft 365). Si no las tienes, se usa automáticamente
  Calibri o, en su defecto, Carlito.
- **Estructura de capítulos**: "Capítulo N NOMBRE" en versalitas, negrita,
  teal y alineado a la derecha, como en el Word. Los títulos nunca parten una
  palabra con guion a final de línea.
- **Estilos extra del Word**: lista de requisitos `RQ n)`, pies de figura
  con "Ilustración", listados de código con "Código", declaración de autoría
  y agradecimientos.
- **Idioma conmutable**: una variable en `main.tex` pasa todo a español o inglés.
- **Escuela y titulación configurables**: `\degreepreset{...}` fija escuela,
  logo de cabecera y nombre de la titulación (Grado o Máster).
- **Autor y tutores**: cada tutor en su propia línea con el logo de su institución.
- **Comentarios de revisión y TODOs**: marcadores de color en el margen +
  nota al pie, ocultables con un interruptor antes de la entrega.
- **Fichas ("sheets")**: tarjetas con cabecera teal para riesgos, paquetes de trabajo…
- **Código en fichero aparte** (`snippets/`) con `\lstinputlisting`.
- **Bibliografía IEEE** (`[1]`, `[2]`…) con `biblatex` + `biber`.
- **PDF automático**: cada `push` compila el TFG en GitHub Actions y publica el PDF.

Los comentarios del código (`.cls`/`.tex`) y los nombres de los ficheros
están en inglés; el texto que se **renderiza** en el PDF es español por
defecto (o inglés con el conmutador de idioma).

---

## Requisitos

- **XeLaTeX** (necesario por `fontspec`/Aptos). No compila con `pdflatex`.
- **biber** para la bibliografía (`biblatex`).
- Una distribución con los paquetes: `fontspec`, `babel`, `geometry`,
  `xcolor` (opción `table`), `titlesec`, `fancyhdr`, `listings`, `enumitem`,
  `biblatex` + `biblatex-ieee`, `etoolbox`, `booktabs`, `array`, `ragged2e`,
  `hyperref`, `caption`, `csquotes`, `iftex`, `tikz`, `pifont`, `marginnote`
  (los dos últimos, para los comentarios de revisión). Con MiKTeX o TeX Live
  completos se instalan solos la primera vez que compiles.

---

## Compilar

### Por línea de comandos

```bash
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex
```

(o la receta "XeLaTeX ➜ Biber ➜ XeLaTeX ×2" de TeXstudio / Overleaf). Hacen
falta las dos pasadas finales de XeLaTeX para que índice, referencias
cruzadas y bibliografía queden consistentes.

### Compilar en Overleaf

1. **Crear el proyecto**: `New Project` → `Upload Project` y sube un `.zip`
   con el contenido de esta carpeta (o importa el repo desde `GitHub`).
   `main.tex`, `uniovitfg.cls`, `img/`, `chapters/`… deben quedar en la
   **raíz** del proyecto, no dentro de una subcarpeta.
2. **Compilador**: no hace falta tocar nada. La primera línea de `main.tex`
   (`% !TeX program = xelatex`) hace que Overleaf elija **XeLaTeX**. Si ves un
   error de `fontspec`, comprueba en el menú (icono de menú) que `Compiler` sea `XeLaTeX`.
3. **Bibliografía**: Overleaf detecta `biblatex` con `biber` y lo ejecuta solo;
   un clic en `Recompile` encadena las pasadas necesarias.
4. **Fuentes**: Overleaf no tiene Aptos ni Calibri, así que la plantilla cae
   sola a **Carlito** (muy parecida). Es normal, no un fallo.
5. **Documento principal**: si Overleaf no marca `main.tex` como raíz, fíjalo
   en el menú → `Main document`.

### Compilar en local con VSCode

1. **Distribución LaTeX**:
   - **Windows**: [MiKTeX](https://miktex.org/download) (XeLaTeX y biber
     incluidos; instala los paquetes que falten al compilar).
   - **macOS**: [MacTeX](https://www.tug.org/mactex/).
   - **Linux**: `texlive-full` (p. ej. `sudo apt install texlive-full`).
   - Comprueba `xelatex --version` y `biber --version` en una terminal nueva.
2. **Extensión**: [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)
   (`James-Yu.latex-workshop`).
3. **Receta**: por defecto usa `pdflatex` + `bibtex`, que **no** sirve aquí.
   Añádela en `Preferences: Open Workspace Settings (JSON)`
   (o en `.vscode/settings.json` de este proyecto):

   ```json
   {
     "latex-workshop.latex.tools": [
       {
         "name": "xelatex",
         "command": "xelatex",
         "args": [
           "-synctex=1",
           "-interaction=nonstopmode",
           "-file-line-error",
           "%DOC%"
         ]
       },
       {
         "name": "biber",
         "command": "biber",
         "args": ["%DOCFILE%"]
       }
     ],
     "latex-workshop.latex.recipes": [
       {
         "name": "xelatex ➜ biber ➜ xelatex ➜ xelatex",
         "tools": ["xelatex", "biber", "xelatex", "xelatex"]
       }
     ],
     "latex-workshop.latex.recipe.default": "first",
     "latex-workshop.latex.clean.fileExtensions": [
       "*.aux", "*.bbl", "*.bcf", "*.blg", "*.fdb_latexmk", "*.fls",
       "*.lof", "*.log", "*.lol", "*.lot", "*.out", "*.run.xml",
       "*.synctex.gz", "*.toc"
     ]
   }
   ```

   El repo ignora `.vscode/` en `.gitignore`: ese fichero se queda en tu
   máquina y no se sube a git.
4. **Compilar**: abre `main.tex` y pulsa ▶ ("Build LaTeX project") o
   `Ctrl+Alt+B`. El PDF se abre con el icono de vista previa o `Ctrl+Alt+V`; con SyncTeX
   (`Ctrl+clic` en el PDF, `Ctrl+Alt+J` desde el `.tex`) saltas entre
   código y PDF.
5. **Errores**: LaTeX Workshop los muestra en el panel "Problems". Los
   avisos `Underfull \hbox` en los títulos de capítulo son cosméticos.

---

## PDF automático con GitHub Actions

El workflow [`build-thesis.yml`](.github/workflows/build-thesis.yml) hace
una sola cosa: **compilar el TFG y dejar el PDF disponible**. Se ejecuta en
cada `push` (y a mano desde la pestaña *Actions* → *Run workflow*).

**Nombre del PDF**

```
{año}-{escuela}-{TFG|TFM}-{ApellidosNombre}-{rama}-{commit}.pdf
 2026-epigijon-TFG-PerezGomezMariaJose-main-56a922a.pdf
```

| Parte | De dónde sale |
|---|---|
| `año` | Último número de 4 cifras de `\thesisdate{...}` (si no hay, el año actual) |
| `escuela` | `epigijon` o `eii`, según `\degreepreset{}` / `\schoolpreset{}` |
| `TFG`/`TFM` | `TFM` solo con `\degreepreset{master}`; `TFG` en el resto |
| `ApellidosNombre` | `\author{...}` sin tildes; las dos últimas palabras son los apellidos y van primero |
| `rama` | Rama de git (las `/` pasan a `-`) |
| `commit` | Los 7 primeros caracteres del hash del commit |

Para probar el nombre en local: `bash .github/scripts/pdf-name.sh`.

**Dónde descargarlo**

- **Último PDF de `main`**: la release
  [`latest-pdf`](https://github.com/augustocristian/dissertation-template/releases/tag/latest-pdf)
  (la del badge de arriba). Se reemplaza en cada push a `main`, sin
  necesidad de iniciar sesión en GitHub.
- **Cualquier otra rama**: se compila el PDF pero **no se crea release**.
  Descárgalo desde la pestaña *Actions* → la ejecución de tu push →
  artefacto `thesis-pdf` (el enlace también aparece en el resumen de la
  ejecución; se conserva 30 días y requiere iniciar sesión en GitHub).

Si el PDF tiene errores de LaTeX o referencias sin resolver, el workflow
falla y **no** publica nada.

> **¿Has copiado la plantilla a tu propio repo?** Sustituye
> `augustocristian/dissertation-template` por `tu-usuario/tu-repo` en los
> badges de arriba. Las releases requieren que el repo permita al workflow
> escribir: *Settings → Actions → General → Workflow permissions →
> Read and write*.

---

## Estructura del proyecto

```
📁 .
├── 📄 main.tex                           ← datos del TFG/TFM + conmutador de idioma
├── 🎨 uniovitfg.cls                      ← la plantilla en sí (fuentes, colores, estilos)
├── 🧩 extracommands.sty                  ← \step, \TODO y comentarios de revisión (\augusto, ...)
├── 📝 declaration.tex                    ← Declaración de autoría / Statement of Authorship
├── 🙏 acknowledgements.tex               ← Agradecimientos / Acknowledgements
├── 📋 abstract.tex                       ← Resumen (portadilla, reinicia la página en 1)
├── 📚 chapters/
│   ├── 📖 ch01_general_description.tex
│   ├── 📖 ch02_planning_and_management.tex
│   ├── 📖 ch03_user_requirements.tex
│   ├── 📖 ch04_system_requirements.tex
│   ├── 📖 ch05_design.tex
│   ├── 📖 ch06_implementation.tex
│   ├── 📖 ch07_manuals.tex
│   ├── 📖 ch08_conclusions.tex
│   └── 📖 ch09_appendices.tex
├── 🗂️ sheets/
│   └── 📇 risk_sheet_example.tex         ← ejemplo de "ficha"
├── 💻 snippets/
│   └── ☕ Average.java                   ← ejemplo de código en fichero aparte
├── 🔖 bibliography.bib                   ← referencias (IEEE)
├── 🖼️ img/
│   └── 🏛️ logos/                         ← logotipos institucionales (PDF vectorial)
└── 🤖 .github/
    ├── ⚙️ workflows/build-thesis.yml     ← compila y publica el PDF
    └── 🏷️ scripts/pdf-name.sh            ← calcula el nombre del PDF
```

---

## Guía de personalización

### Escuela y titulación

`\degreepreset{...}` configura a la vez la escuela (texto de portada + logo
de cabecera) y la titulación (nombre del grado/máster, y si es TFG o TFM),
traducido según `\thesislanguage{}`:

| Preset | Titulación | Escuela | Tipo |
|---|---|---|---|
| `it` (por defecto) | Grado en Ingeniería Informática en Tecnologías de la Información | EPI Gijón | TFG |
| `datos` | Grado en Ciencia e Ingeniería de Datos | EPI Gijón | TFG |
| `master` | Máster en Ingeniería Informática | EPI Gijón | TFM |
| `software` | Grado en Ingeniería Informática del Software | Escuela de Ingeniería Informática | TFG |

```latex
\degreepreset{master}   % o: it, datos, software
```

Si tu titulación no está, o quieres cambiar solo una pieza, llama a los
comandos de más bajo nivel después de `\degreepreset{...}` (o en su lugar):

```latex
\school{...}             % texto de la portada (escuela)
\schoollogo{...}         % logo de la cabecera, arriba a la derecha
\degree{...}             % nombre de la titulación en la portada
\thesistype{...}         % "Trabajo Fin de Grado"/"Trabajo Fin de Máster"...
\thesistypeabbrev{...}   % "TFG"/"TFM"...
```

`\schoolpreset{epigijon}` / `\schoolpreset{eii}` hacen lo mismo pero solo
para escuela + logo (con el grado por defecto de esa escuela).

> ℹSi usas una titulación propia, el nombre del PDF seguirá la escuela del
> último `\degreepreset`/`\schoolpreset` de `main.tex` (o `epigijon` si no hay).

### Autor y tutores

El autor/a se identifica solo por su nombre. Cada tutor/a (académico o de
empresa) va en su propia línea, con el logo de su institución a la izquierda
y su rol encima del nombre:

```latex
\author{Nombre Apellido Apellido}

% Tutores académicos: una llamada por tutor, con el logo de la UNIOVI
\tutor{D. Cristian Augusto}
\tutor{Dña. Otra Persona}

% Tutores de empresa (solo TFG/TFM en empresa). \companylogo se usa a la
% izquierda de estos tutores y sustituye al logo de la UNIOVI en la
% cabecera de todas las páginas.
\companytutor{D./Dña. Nombre Apellido}
\companylogo{img/logos/logo_empresa.png}
```

- El autor sale en su propia línea, con letra algo mayor.
- Los tutores salen después, uno por línea, con etiqueta "Tutor
  académico"/"Tutor en empresa".
- Sin `\companylogo{...}`, la columna del logo de los tutores de empresa
  queda en blanco (no da error).

### Comentarios de revisión y TODOs

`extracommands.sty` añade marcadores para que tutores y autor/a dejen
comentarios sobre el borrador: un símbolo de color en el margen y el
comentario completo como nota al pie.

```latex
\TODO{queda por escribir la sección de resultados}
\augusto{...}     % comentario del tutor académico (rojo)
\tutortwo{...}    % comentario de un segundo tutor (azul)
\student{...}     % comentario del propio autor/a (naranja)
```

Están **ocultos por defecto**: un `\usepackage{extracommands}` a secas compila
una copia limpia aunque el código siga teniendo las llamadas. `main.tex` los
activa con:

```latex
\usepackage[showcomments,showtodos]{extracommands}
```

Quita esos corchetes antes de compilar la copia que vayas a entregar.
`extracommands.sty` también trae `\step{n}`, un número pequeño dentro de un
círculo (para numerar pasos en un manual).

### Fichas ("sheets")

Para documentar de forma homogénea cada riesgo, paquete de trabajo,
interesado, etc., usa el entorno `sheet` en un fichero de `sheets/` e
impórtalo con `\input`:

```latex
% sheets/mi_ficha.tex
\begin{sheet}{Título de la ficha}
  \sheetfield{Campo 1}{Valor 1}
  \sheetfield{Campo 2}{Valor 2}
\end{sheet}
```

```latex
% en el capítulo correspondiente
\input{sheets/mi_ficha}
```

Ejemplo completo: `sheets/risk_sheet_example.tex` (usado en
`chapters/ch02_planning_and_management.tex`).

### Fragmentos de código en fichero aparte

Guarda el código como fichero real en `snippets/` e impórtalo:

```latex
\lstinputlisting[language=Java, caption={Mi fragmento}, label={lst:mi-codigo}]{snippets/MiFichero.java}
```

Ejemplo: `snippets/Average.java`, usado en `chapters/ch06_implementation.tex`.

### Bibliografía (IEEE)

Añade tus referencias a `bibliography.bib` y cítalas con `\cite{clave}`.
`\printbibliography` (ya en `chapters/ch09_appendices.tex`, sección
"Referencias") genera el listado numerado en formato IEEE. Tras añadir o
cambiar citas, vuelve a ejecutar `biber main`.

### Tablas

Usa `booktabs` (`\toprule`, `\midrule`, `\bottomrule`) como en
`chapters/ch02_planning_and_management.tex`: las líneas salen en teal. Para
la fila de cabecera en negrita y teal oscuro, antepón `\tableheaderfont` a
la primera celda:

```latex
\toprule
\tableheaderfont Columna A & Columna B \\
\midrule
```

### Conmutador de idioma

Al principio de `main.tex`:

```latex
\thesislanguage{spanish}   % por defecto
\thesislanguage{english}   % cambia todo el "andamiaje" a inglés
```

Cambia el idioma de `babel` (separación silábica, `\today`), "Contenidos"/
"Contents", índices de figuras/tablas, "Capítulo"/"Chapter", pies de
figura/tabla/código, declaración de autoría, agradecimientos, resumen,
escuela y titulación (con `\degreepreset`), y los títulos de `chapters/*.tex`.

Cada título y párrafo de ejemplo usa:

```latex
\bilingual{texto en español}{texto en inglés}
```

En tus propios capítulos usa `\bilingual{...}{...}` igual, o escribe texto
fijo si solo vas a redactar en un idioma.

> **No uses `\bilingual` directamente dentro de un `\caption{...}`**
> (figura, tabla o listado): corrompe el `.aux` en la compilación siguiente.
> Envuelve todo el `\caption{...}` en `\ifthesisenglish ... \else ... \fi`
> (o, para `lstlisting`, resuélvelo antes en una macro con `\def`). Los
> capítulos de ejemplo con figuras/tablas/código ya muestran el patrón.

---

## Problemas frecuentes

| Síntoma | Causa y solución |
|---|---|
| Error de `fontspec` / "XeTeX required" | Compilas con `pdflatex`. Cambia el compilador a **XeLaTeX** |
| Citas como `[?]` o bibliografía vacía | Falta ejecutar `biber main` y dos pasadas más de XeLaTeX |
| Fallo por `.aux` corrupto tras añadir una figura | Usaste `\bilingual` dentro de `\caption` (ver [Conmutador de idioma](#conmutador-de-idioma)); borra los `.aux` y corrige |
| El PDF sale con Carlito en vez de Aptos | Normal si no tienes Microsoft 365 ([Overleaf](#compilar-en-overleaf)) |
| `Unable to load picture or PDF file` | Ruta incorrecta en `\companylogo{}`/`\schoollogo{}` |
| Aparecen símbolos y notas de colores en el PDF | Quita `[showcomments,showtodos]` de `extracommands` |
| El workflow no publica la release | Activa *Read and write permissions* en *Settings → Actions → General* |
