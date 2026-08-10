# Plantilla LaTeX de TFG/TFM — Universidad de Oviedo

Réplica en LaTeX de la plantilla Word `2026-TFG-Templatev2.docx` del grupo
de investigación (Escuela Politécnica de Ingeniería de Gijón), ampliada
con varias funcionalidades propias (ver más abajo). Reproduce:

- **Portada**: logotipo oficial de la Universidad de Oviedo, título, escuela,
  titulación, nombre del autor/a, tutores académicos y de empresa (cada uno
  con el logo de su institución a la izquierda), mes y año alineado a la
  derecha.
- **Cabecera** de todas las páginas: logo institucional (izquierda, se
  sustituye por el logo de la empresa si el TFG/TFM es en colaboración con
  una), título del capítulo actual (centro, en teal, tipografía Aptos
  Display), logo EPI Gijón (derecha) — los tres elementos a la misma
  altura y centrados verticalmente entre sí.
- **Pie de página**: número de página a la derecha.
- **Colores corporativos**: teal `#008383` (capítulos), `#00A8A4`
  (secciones), `#00BCB8` (subsecciones); líneas de tablas en teal y
  cabeceras de tabla en teal oscuro.
- **Tipografías**: Aptos (texto) y Aptos Display (títulos), las mismas que
  usa la plantilla Word (Microsoft 365). Si tu equipo no tiene Aptos
  instalada, la plantilla usa automáticamente Calibri/Carlito como
  alternativa.
- **Estructura de capítulos**: "Capítulo N NOMBRE", en versalitas, negrita,
  teal y alineado a la derecha, igual que en el Word. Los títulos de
  capítulo/sección/subsección/subsubsección nunca parten una palabra con un
  guion a final de línea (hyphenation desactivada solo en los títulos).
- Estilos adicionales calcados del Word: lista de requisitos `RQ n)`,
  pies de figura con la palabra "Ilustración", listados de código con la
  palabra "Código", declaración de autoría y agradecimientos.
- **Idioma conmutable**: una única variable en `main.tex` decide si todos
  los títulos, secciones, textos de portada, escuela y titulación se
  muestran en español o en inglés (ver "Conmutador de idioma").
- **Escuela y titulación configurables**: `\degreepreset{...}` fija a la
  vez la escuela, el logo de la cabecera y el nombre de la titulación
  (Grado o Máster) para varias titulaciones de la Universidad de Oviedo
  ya incluidas (ver "Escuela y titulación").
- **Autor y tutores**: cada tutor académico o de empresa se lista en su
  propia línea con el logo de su institución a la izquierda (ver "Autor y
  tutores").
- **Comentarios de revisión y TODOs**: marcadores de color en el margen +
  nota a pie de página para que tutores y autor/a dejen comentarios sobre
  el borrador, ocultables con un interruptor antes de la entrega final
  (ver "Comentarios de revisión y TODOs").
- **Fichas ("sheets")**: tarjetas con cabecera en teal para describir
  riesgos, paquetes de trabajo, etc. (carpeta `sheets/`).
- **Fragmentos de código en fichero aparte** (`snippets/`), incluidos con
  `\lstinputlisting` en vez de escribirlos dentro del `.tex`.
- **Bibliografía en formato IEEE** (citas `[1]`, `[2]`...) con `biblatex` +
  `biber`.

Los comentarios del código (`.cls`/`.tex`) y los nombres de los ficheros
están en inglés; el texto que se **renderiza** en el PDF es español por
defecto (o inglés si activas el conmutador de idioma).

## Requisitos

- **XeLaTeX** (necesario por `fontspec`/Aptos). No compila con `pdflatex`.
- **biber** para la bibliografía (`biblatex`).
- Distribución con los paquetes: `fontspec`, `babel`, `geometry`, `xcolor`
  (opción `table`), `titlesec`, `fancyhdr`, `listings`, `enumitem`,
  `biblatex` + `biblatex-ieee`, `etoolbox`, `booktabs`, `array`,
  `ragged2e`, `hyperref`, `caption`, `csquotes`, `iftex`, `tikz`,
  `pifont`, `marginnote` (los dos últimos, para los comentarios de
  revisión de `extracommands.sty`). Con MiKTeX o TeX Live completos se
  instalan automáticamente la primera vez que compiles.

## Compilar

```bash
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex
```

(o el equivalente "Recipe: XeLaTeX ➜ Biber ➜ XeLaTeX ×2" en TeXstudio /
Overleaf, seleccionando **XeLaTeX** como compilador). Hacen falta las dos
pasadas finales de XeLaTeX para que el índice, las referencias cruzadas y
la bibliografía queden consistentes.

## Compilar en Overleaf

1. **Crear el proyecto**: `New Project` → `Upload Project` y sube un
   `.zip` con todo el contenido de esta carpeta (o usa `Git` /
   `GitHub` si el repo está en un remoto accesible). El proyecto debe
   quedar con `main.tex`, `uniovitfg.cls`, `img/`, `chapters/`, etc.
   todos en la raíz — no metas la carpeta `augustotemplate/` un nivel
   más adentro dentro del zip.
2. **Compilador**: no hace falta tocar nada a mano. La primera línea de
   `main.tex` (`% !TeX program = xelatex`) hace que Overleaf seleccione
   **XeLaTeX** automáticamente. Si por lo que sea el PDF no se genera o
   ves un error de `fontspec`, comprueba en el menú del proyecto
   (icono ☰) que `Compiler` esté en `XeLaTeX` (no `pdfLaTeX`).
3. **Bibliografía**: tampoco hace falta configurarla — Overleaf detecta
   solo que el documento usa `biblatex` con `backend=biber` y ejecuta
   `biber` automáticamente entre pasadas. Un solo clic en `Recompile`
   ya encadena las pasadas de XeLaTeX/Biber que hagan falta (el
   `xelatex ➜ biber ➜ xelatex ➜ xelatex` de más arriba es solo para
   compilar a mano por línea de comandos).
4. **Fuentes Aptos/Calibri**: los servidores de Overleaf no tienen
   Microsoft 365 instalado, así que ni Aptos ni Calibri están
   disponibles — la plantilla lo detecta sola y cae automáticamente a
   **Carlito** (incluida en cualquier TeX Live completo, incluido el
   de Overleaf). Es el comportamiento esperado, no un fallo: el PDF
   sale con Carlito en vez de Aptos, visualmente muy parecidas.
5. **Documento principal**: si Overleaf no marca `main.tex` como raíz
   automáticamente (pasa si hay ambigüedad), fíjalo a mano en el menú
   del proyecto → `Main document`.

## Compilar en local con VSCode

Si prefieres compilar en tu máquina en vez de Overleaf, esto es lo que
necesitas instalar y configurar una sola vez:

1. **Distribución LaTeX** (si no tienes ninguna instalada todavía):
   - **Windows**: [MiKTeX](https://miktex.org/download). Instala variante
     completa; XeLaTeX y biber vienen incluidos. MiKTeX instala los
     paquetes que falten automáticamente la primera vez que compiles
     (puede tardar un poco esa primera vez).
   - **macOS**: [MacTeX](https://www.tug.org/mactex/) (incluye XeLaTeX y
     biber).
   - **Linux**: el paquete `texlive-full` de tu distribución (por
     ejemplo `sudo apt install texlive-full`), o una instalación de TeX
     Live vía `tlmgr` que incluya los esquemas `xetex` y `biber`.
   - Comprueba que quedaron en el `PATH` abriendo una terminal nueva y
     ejecutando `xelatex --version` y `biber --version`; si el sistema no
     los encuentra, reinicia la terminal/el equipo tras instalar.
2. **Extensión de VSCode**: instala
   [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)
   (`James-Yu.latex-workshop`) desde el Marketplace.
3. **Receta de compilación**: por defecto, LaTeX Workshop compila con
   `pdflatex` + `bibtex`, que **no** sirve para esta plantilla (necesita
   XeLaTeX y biber, ver "Requisitos" más arriba). Añade esto a la
   configuración — paleta de comandos (`Ctrl+Shift+P`) → `Preferences:
   Open Workspace Settings (JSON)` — para que reproduzca exactamente la
   secuencia `xelatex ➜ biber ➜ xelatex ➜ xelatex` de la sección
   "Compilar":

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

   Si guardas ese fichero como `.vscode/settings.json` dentro de
   `augustotemplate/`, la receta se aplica solo a este proyecto sin
   tocar tu configuración global de VSCode (el repo ignora `.vscode/` en
   `.gitignore`, así que ese fichero se queda en tu máquina y no se sube
   a git).
4. **Compilar**: abre `main.tex` y pulsa el icono ▶ ("Build LaTeX
   project") de la barra lateral de LaTeX Workshop, o usa el atajo
   `Ctrl+Alt+B`. El PDF aparece en una pestaña junto al editor (icono 🔍
   de la misma barra lateral, o `Ctrl+Alt+V`); con SyncTeX activado
   (`Ctrl+clic` en el PDF, o `Ctrl+Alt+J` desde el `.tex`) puedes saltar
   entre el código fuente y su posición exacta en el PDF en ambos
   sentidos.
5. **Errores de compilación**: LaTeX Workshop resalta los errores reales
   (`^!` en el log) en el panel "Problems" de VSCode; los avisos de
   `Underfull \hbox` en los títulos de capítulo son cosméticos y
   esperados (ver la nota en `CLAUDE.md`), no indican un fallo.

## Estructura del proyecto

```
main.tex                       ← datos del TFG/TFM + conmutador de idioma
uniovitfg.cls                  ← la plantilla en sí (fuentes, colores, estilos)
extracommands.sty              ← \step, \TODO y comentarios de revisión (\augusto, ...)
declaration.tex                ← Declaración de autoría / Statement of Authorship
acknowledgements.tex           ← Agradecimientos / Acknowledgements
abstract.tex                   ← Resumen (portadilla, reinicia la página en 1)
chapters/
  ch01_general_description.tex
  ch02_planning_and_management.tex
  ch03_user_requirements.tex
  ch04_system_requirements.tex
  ch05_design.tex
  ch06_implementation.tex
  ch07_manuals.tex
  ch08_conclusions.tex
  ch09_appendices.tex
sheets/
  risk_sheet_example.tex       ← ejemplo de "ficha" (ver más abajo)
snippets/
  Average.java                 ← ejemplo de código en fichero aparte
bibliography.bib
img/
  logos/                       ← logotipos institucionales (PDF vectorial)
```

## Cómo personalizar

Todos los datos del trabajo se editan al principio de `main.tex`:

```latex
\title{...}
\author{...}
\thesisdate{...}   % mes y año de la portada
\city{...}
\academicyear{...}
\dni{...}
```

Escuela, titulación y si es TFG o TFM se configuran con `\degreepreset{...}`
(ver "Escuela y titulación" justo debajo) en lugar de `\school{}`/
`\degree{}`/`\thesistype{}` sueltos.

### Escuela y titulación

`\degreepreset{...}` es la forma recomendada de configurar a la vez la
escuela (texto de portada + logo de la cabecera) y la titulación (nombre
del grado/máster, y si es TFG o TFM), todo ya traducido según
`\thesislanguage{}`. Ahora mismo trae 4 titulaciones:

| Preset | Titulación | Escuela | Tipo |
|---|---|---|---|
| `it` (por defecto) | Grado en Ingeniería Informática en Tecnologías de la Información | EPI Gijón | TFG |
| `datos` | Grado en Ciencia e Ingeniería de Datos | EPI Gijón | TFG |
| `master` | Máster en Ingeniería Informática | EPI Gijón | TFM |
| `software` | Grado en Ingeniería Informática del Software | Escuela de Ingeniería Informática | TFG |

```latex
\degreepreset{master}   % o: it, datos, software
```

Si tu titulación no está en la lista, o quieres cambiar solo una pieza
(por ejemplo, el mismo grado pero con un título de TFG distinto), llama a
los comandos de más bajo nivel por separado, en el orden que quieras,
después de `\degreepreset{...}` (o en su lugar):

```latex
\school{...}             % texto de la portada (escuela)
\schoollogo{...}         % logo de la cabecera, arriba a la derecha
\degree{...}             % nombre de la titulación en la portada
\thesistype{...}         % "Trabajo Fin de Grado"/"Trabajo Fin de Máster"...
\thesistypeabbrev{...}   % "TFG"/"TFM"...
```

`\schoolpreset{epigijon}` / `\schoolpreset{eii}` hacen lo mismo que
`\degreepreset{}` pero solo para escuela + logo (con el grado por
defecto de esa escuela) sin tocar `\thesistype{}`; es lo que usan
internamente `datos`/`master`/`software` antes de fijar su propio
`\degree{}`.

### Autor y tutores

El autor/a se identifica solo por su nombre. Cada tutor/a (académico o de
empresa) va en su propia línea, con el logo de su institución a la
izquierda y su etiqueta de rol encima del nombre:

```latex
\author{Nombre Apellido}

% Tutores académicos (universidad) -- llama a \tutor tantas veces como
% tutores académicos haya. Cada uno sale en su propia línea con el logo
% de la UNIOVI a la izquierda.
\tutor{D. Cristian Augusto}
\tutor{Dña. Otra Persona}

% Tutores de empresa (solo en TFG/TFM en empresa) -- además de
% \companytutor, define \companylogo con el logo de la empresa: se usa a
% la izquierda de estos tutores y también sustituye el logo de la UNIOVI
% en la cabecera de todas las páginas.
\companytutor{D./Dña. Nombre Apellido}
\companylogo{img/logos/logo_empresa.png}
```

- El autor se muestra siempre en su propia línea, con letra algo mayor
  para destacarlo.
- Los tutores (académicos y de empresa) se muestran después, uno por
  línea, cada uno con su etiqueta de rol ("Tutor académico"/"Tutor en
  empresa") encima del nombre y el logo de su institución a la izquierda.
- Si no se ha definido `\companylogo{...}`, la columna del logo para los
  tutores de empresa sale simplemente en blanco (no da error).

### Comentarios de revisión y TODOs

`extracommands.sty` añade marcadores para que tutores y autor/a dejen
comentarios sobre el borrador sin tocar el texto: cada llamada deja un
símbolo de color en el margen y el comentario completo como nota a pie
de página.

```latex
\TODO{queda por escribir la sección de resultados}
\augusto{...}     % comentario del tutor académico (rojo)
\tutortwo{...}    % comentario de un segundo tutor (azul)
\student{...}     % comentario del propio autor/a (naranja)
```

Están **ocultos por defecto** (para que un `\usepackage{extracommands}`
a secas compile una copia limpia aunque el código fuente siga teniendo
llamadas a `\TODO`/`\augusto`/...). `main.tex` los activa con:

```latex
\usepackage[showcomments,showtodos]{extracommands}
```

Quita esos dos corchetes (o toda la línea) antes de compilar la copia
que vayas a entregar. `extracommands.sty` también trae `\step{n}`, un
número pequeño dentro de un círculo (por ejemplo para numerar pasos en
un manual): `\step{1}`, `\step{2}`...

### Fichas ("sheets")

Para documentar de forma homogénea cada riesgo, paquete de trabajo,
interesado, etc. del capítulo de planificación, usa el entorno `sheet` en
un fichero propio dentro de `sheets/` y luego impórtalo con `\input`:

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

Mira `sheets/risk_sheet_example.tex` (usado en
`chapters/ch02_planning_and_management.tex`) como ejemplo completo.

### Fragmentos de código en fichero aparte

En vez de escribir el código dentro del `.tex`, puedes guardarlo como
fichero de código real en `snippets/` (con resaltado de sintaxis correcto
para ese lenguaje en tu editor) e importarlo con `\lstinputlisting`:

```latex
\lstinputlisting[language=Java, caption={Mi fragmento}, label={lst:mi-codigo}]{snippets/MiFichero.java}
```

Mira `snippets/Average.java`, usado en
`chapters/ch06_implementation.tex`, como ejemplo.

### Bibliografía (IEEE)

Añade tus referencias a `bibliography.bib` y cítalas con `\cite{clave}`
en cualquier capítulo; `\printbibliography` (ya colocado en
`chapters/ch09_appendices.tex`, sección "Referencias") genera el listado
numerado en formato IEEE. Recuerda que tras añadir o cambiar citas hace
falta volver a ejecutar `biber main` (ver "Compilar" más arriba).

### Tablas

Usa `booktabs` (`\toprule`, `\midrule`, `\bottomrule`) como en el ejemplo
de `chapters/ch02_planning_and_management.tex`: las líneas ya salen en
teal automáticamente. Para que la fila de cabecera salga en negrita y
teal oscuro, antepón `\tableheaderfont` a la primera celda de esa fila:

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

Esto cambia automáticamente: el idioma de `babel` (y por tanto la
separación silábica y `\today`), "Contenidos"/"Contents", "Índice de
figuras/tablas"/"List of Figures/Tables", "Capítulo"/"Chapter", los pies
de figura/tabla/código, la declaración de autoría, los agradecimientos, el
resumen, el nombre de la escuela y la titulación si usas `\degreepreset{...}`
(ver "Escuela y titulación"), y el título de cada capítulo y sección en
`chapters/*.tex`.

Cada título y cada párrafo de ejemplo en `chapters/*.tex` usa el comando

```latex
\bilingual{texto en español}{texto en inglés}
```

Si añades tus propios capítulos, usa `\bilingual{...}{...}` de la misma
forma para que también respeten el conmutador (o simplemente escribe texto
fijo si tu TFG/TFM solo se va a redactar en un idioma). **Importante**:
no uses `\bilingual` directamente dentro de un `\caption{...}` (de una
figura, tabla o listado) — corrompe el fichero `.aux` en la siguiente
compilación. En su lugar, elige el texto completo con un `\ifthesisenglish
... \else ... \fi` alrededor de todo el `\caption{...}` (o, para
`lstlisting`, resuélvelo antes en una macro con `\def`). Los tres
capítulos de ejemplo que llevan figuras/tablas/código ya muestran el
patrón correcto — cópialo tal cual.

