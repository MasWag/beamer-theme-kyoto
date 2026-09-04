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

from the repository root builds `examples/demo.pdf` and
`examples/tikz-demo.pdf` with `latexmk` and LuaLaTeX
(`examples/latexmkrc` points `TEXINPUTS` at the theme files in the
repository root, so nothing needs installing into TEXMF first).
Equivalently, from the `examples/` directory: `latexmk demo.tex` or
`latexmk tikz-demo.tex`.

`make clean` removes the generated files.

## TikZ

The Beamer theme does not load TikZ itself -- `tikzlibrarykyoto.code.tex`
is an opt-in helper library. Load it explicitly:

```latex
\usepackage{tikz}
\usetikzlibrary{kyoto}
```

It is a thin styling layer over ordinary TikZ: it adds no drawing
commands, only named styles in the Kyoto palette that you apply to
plain TikZ nodes/paths, using TikZ's own geometry mechanisms
(`right=of`, `bend left`/`bend right`, explicit coordinates,
`positioning`, etc.).

| Style | Use |
|---|---|
| `kyoto/box` | A node with rounded corners, solid navy fill, light text (filled by default). |
| `kyoto/box alert` | Same geometry, solid red (alert) fill. |
| `kyoto/box secondary` | Same geometry, solid muted-gray fill. |
| `kyoto/box outline` | Same geometry, light fill, navy border, dark text. |
| `kyoto/box outline alert` | Same as `kyoto/box outline`, red (alert) border. |
| `kyoto/box outline secondary` | Same as `kyoto/box outline`, muted gray border. |
| `kyoto/label` | Unobtrusive colored text for labels on/near arrows. |
| `kyoto/arrow` | A navy arrow with a modern `arrows.meta` Stealth tip. |
| `kyoto/arrow alert` | Same geometry, red. |
| `kyoto/arrow secondary` | Same geometry, muted gray. |
| `kyoto/arrow dashed` | Same as `kyoto/arrow`, dashed. |
| `kyoto/callout` | A rounded rectangular callout (via `shapes.callouts`), same appearance as `kyoto/box` (filled by default). |
| `kyoto/callout alert` | Same geometry, red (alert) fill. |
| `kyoto/callout outline` | Same as `kyoto/callout`, but the `kyoto/box outline` appearance. |
| `kyoto/callout outline alert` | Same as `kyoto/callout outline`, red (alert) border. |

```latex
\begin{tikzpicture}
  \node[kyoto/box] (a) {Start};
  \node[kyoto/box, right=3cm of a] (b) {End};
  \draw[kyoto/arrow] (a) -- (b) node[kyoto/label, midway, above] {next};
\end{tikzpicture}
```

The callout styles reuse TikZ's standard `rectangle callout` shape from
`shapes.callouts` (loaded by the Kyoto library), styled with the same
rounded corners, border/fill/text colors, line width and inner padding
as the matching `kyoto/box` variant -- `kyoto/callout` inherits
`kyoto/box` (filled), `kyoto/callout outline` inherits `kyoto/box
outline`, and so on. Pointer direction, pointer target and node
placement stay ordinary TikZ -- the Kyoto style only sets appearance:

```latex
\node[
  kyoto/callout,
  callout absolute pointer={(target.north)}
] at (3,2) {Relevant state};
```

The library also works without the Kyoto Beamer theme loaded (e.g. in
a bare `standalone` document): it reuses the theme's colors if they
are already defined, and only falls back to its own copies of the same
values otherwise, so the visual result never depends on load order.

Standard TikZ libraries combine freely with Kyoto -- e.g.
`\usetikzlibrary{kyoto,automata}` to draw finite automata with TikZ's
own `state`/`initial`/`accepting` styles and annotate them with Kyoto
callouts; Kyoto deliberately does not redefine automata styles.

See `examples/tikz-demo.tex` for a fuller demo (box/arrow variants,
curved arrows, labels, dashed arrows, `positioning` usage, callouts,
and a standard TikZ automaton annotated with a Kyoto callout).

## License

LPPL 1.3c (or, at your option, any later version) -- see `LICENSE`.
