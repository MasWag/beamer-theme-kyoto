# Kyoto Beamer Theme

A [Beamer](https://ctan.org/pkg/beamer) theme with a light background, a
navy top/bottom band, bold centered titles, and support for mixed
Japanese/English text. It is a Beamer port / counterpart of the
[SLyDIFi Kyoto theme](https://github.com/MasWag/slydifi-kyoto-demo)
(a theme for the [SLyDIFi](https://github.com/na-o-ys/slydifi) class),
reimplemented independently for Beamer.

## Requirements

- **LuaLaTeX** is the reference engine (not pdfLaTeX/XeLaTeX).
- `fontspec` and `luatexja-fontspec` (for Japanese text), `kvoptions`,
  `etoolbox` -- all commonly available in a standard TeX Live install.
- Fonts, each with a fallback if not installed (see
  `beamerfontthemeKyoto.sty`):
  - **Noto Sans** -- Latin body/UI text (falls back to Helvetica
    Neue/Arial).
  - **Noto Sans CJK JP** -- Japanese text (falls back to Hiragino Kaku
    Gothic).
  - **Latin Modern Mono** -- monospace/code (falls back to Menlo/Courier
    New).
  - **Roboto Condensed Bold** -- titles (falls back to the main body
    font if not installed).

  A full TeX Live install already bundles Noto Sans, Roboto Condensed and
  Latin Modern Mono as plain font files (found by LuaTeX without any
  system/OS font installation); Noto Sans CJK JP is not bundled by TeX
  Live and, if you want it rather than the Hiragino fallback, needs
  installing separately (e.g. the `fonts-noto-cjk` package on
  Debian/Ubuntu).

This theme is not published on CTAN; use it by cloning this repository
(see below).

## Usage

```latex
\documentclass[aspectratio=169]{beamer}
\usetheme{Kyoto}
```

Put `beamerthemeKyoto.sty`, `beamercolorthemeKyoto.sty`,
`beamerfontthemeKyoto.sty`, `beamerinnerthemeKyoto.sty` and
`beamerouterthemeKyoto.sty` (all in the repository root) somewhere LaTeX
can find them -- either alongside your `.tex` file, on `TEXINPUTS`, or
installed into your local TEXMF tree. There is no packaged/CTAN
installation.

### Theme options

Passed as `\usetheme[<options>]{Kyoto}`:

| Option | Default | Effect |
|---|---|---|
| `totalpagenum` | `true` | Footer shows `frame/total` when `true`, or just `frame` when `false`. |
| `rightfooter` | `\insertshortauthor` | Text shown at the right edge of the footer. For text containing spaces, prefer `\kyotofooter{...}` (below) over this option. |

```latex
\usetheme[totalpagenum=false, rightfooter=My Talk]{Kyoto}
```

### Runtime commands

Usable anywhere in the document body (typically inside a `frame`) to
override the theme options above after the fact:

- `\kyotototalpagenum{true|false}` -- toggle the `frame/total` footer.
- `\kyotofooter{<text>}` -- set the right-hand footer text.

### Title page

```latex
\title{My Talk}
\author{My Name}
\institute{My Institute}
\date{\today}
\titlegraphic{\includegraphics[height=\kyototitlegraphicheight]{logo.pdf}}

\begin{frame}[noframenumbering]
  \titlepage
\end{frame}
```

`\titlegraphic` is optional; when given, `\kyototitlegraphicheight` is a
theme-provided length sized to nearly fill the title page's top navy
band. The `[noframenumbering]` frame option excludes the title page from
the frame count shown in the footer.

### Section pages

Beamer does not insert section pages automatically; add one explicitly
after each `\section`:

```latex
\section{My Section}
\begin{frame}[noframenumbering]
  \sectionpage
\end{frame}
```

As with the title page, `[noframenumbering]` keeps section pages out of
the frame count.

### Appendix and bibliography

Beamer's own `\appendix` and `thebibliography`/`\bibitem` work as usual
and are styled by this theme (navy accents, Beamer's standard "rounded"
block style for `theorem`/`definition`/etc., and a navy triangle marker
for bibliography items). See `examples/demo.tex` for a full example of
both, along with theorem/definition blocks, nested lists, and mixed
Japanese/English text.

## Building the example

```
make
```

from the repository root builds `examples/demo.pdf` with `latexmk` and
LuaLaTeX (`examples/latexmkrc` points `TEXINPUTS` at the theme files in
the repository root, so nothing needs installing into TEXMF first).
Equivalently, from the `examples/` directory: `latexmk demo.tex`.

`make clean` removes the generated files.

## License

LPPL 1.3c (or, at your option, any later version) -- see `LICENSE`.
