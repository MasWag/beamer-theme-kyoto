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
| `kyoto/box` | A node with rounded corners, solid navy fill, light text, subtle drop shadow (filled by default). |
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
| `kyoto/callout` | A rounded rectangular callout (via `shapes.callouts`), same appearance as `kyoto/box` (filled by default, drop shadow included). |
| `kyoto/callout alert` | Same geometry, red (alert) fill. |
| `kyoto/callout outline` | Same as `kyoto/callout`, but the `kyoto/box outline` appearance. |
| `kyoto/callout outline alert` | Same as `kyoto/callout outline`, red (alert) border. |
| `kyoto/highlight` | A generic translucent navy region (rounded corners, light fill, solid border) for highlighting a group of existing nodes via `fit=`. |
| `kyoto/highlight alert` | Same geometry, red (alert) border/fill. |

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

### Highlighting node groups

`kyoto/highlight` and `kyoto/highlight alert` are generic, translucent
regions for calling out an existing group of nodes -- they impose no
table, automaton, or observation-table API. The library loads TikZ's
`fit` and `backgrounds` libraries for this; *which* nodes are enclosed
is chosen entirely by TikZ's own `fit=(...)` option, and *which layer*
the highlight is drawn on is chosen explicitly by the caller (the style
does not force the background layer itself):

```latex
\node[kyoto/box] (a) {A};
\node[kyoto/box, right=of a] (b) {B};

\begin{scope}[on background layer]
  \node[kyoto/highlight, fit=(a)(b)] {};
\end{scope}
```

Because `fit` works on any TikZ node, the same styles highlight a row
or region of a `matrix of nodes` (e.g. an observation-table-like
diagram) or a group of automaton states -- see
`examples/tikz-demo.tex` for both. `matrix` is not loaded by the Kyoto
library itself; load it yourself (`\usetikzlibrary{matrix}`) where
needed.

### Beamer overlays

Kyoto does not implement its own overlay API -- no `visible on`,
`alert on`, or similar -- because standard Beamer overlay commands
already compose with the `kyoto/...` styles with nothing extra needed.
`\only`, `\visible`, `\uncover`, `\onslide`, and `\alt` all work
normally on nodes and paths built from Kyoto styles:

```latex
\visible<2->{%
  \draw[kyoto/arrow] (a) -- (b);
}
\visible<3->{%
  \node[kyoto/highlight alert, fit=(a)(b)] {};
}
```

`\visible`/`\uncover` keep the wrapped material's space and geometry
on every overlay (only its ink is hidden outside the given range), so
node positions and later `fit=(...)` references stay valid throughout
-- prefer them whenever a diagram's layout must not move between
overlays. `\only` instead omits its argument entirely outside the
given range: the wrapped node is never created there, which can shift
the `tikzpicture`'s bounding box (and anything positioned relative to
that node) between overlays, and referencing that node's name outside
its range is an error. `\only` is fine for material nothing else
depends on positionally.

One caveat worth knowing: TikZ's `on background layer` (from the
`backgrounds` library, used by the highlight styles above) defers its
content into a box that is only flushed to the page at the end of the
`tikzpicture` -- after `\visible`'s invisibility span has already
closed -- so a highlight wrapped in both `\visible<...>` and
`on background layer` would ignore the overlay range and show on
every slide. When a `kyoto/highlight` needs to appear on a later
overlay, draw it in the foreground (no `on background layer`) instead;
its low fill opacity keeps it legible over the content it encloses.
See `examples/tikz-demo.tex` for progressive-reveal, highlight-appears-
later, and `\only`-vs-`\visible` geometry examples, no extra overlay
TikZ library required.

The library also works without the Kyoto Beamer theme loaded (e.g. in
a bare `standalone` document): it reuses the theme's colors if they
are already defined, and only falls back to its own copies of the same
values otherwise, so the visual result never depends on load order.

Standard TikZ libraries combine freely with Kyoto -- e.g.
`\usetikzlibrary{kyoto,automata}` to draw finite automata with TikZ's
own `state`/`initial`/`accepting` styles and annotate them with Kyoto
callouts; Kyoto deliberately does not redefine automata styles.

See `examples/tikz-demo.tex` for a fuller demo (box/arrow variants,
curved arrows, labels, dashed arrows, `positioning` usage, callouts, a
standard TikZ automaton annotated with a Kyoto callout,
`kyoto/highlight`/`kyoto/highlight alert` used on a node group, a
`matrix of nodes`, and an automaton, and standard Beamer overlays --
`\visible`/`\uncover`/`\alt` -- composed with Kyoto styles for a
progressive reveal, a highlight appearing on a later overlay, and a
side-by-side `\only`-vs-`\visible` geometry comparison).

## License

LPPL 1.3c (or, at your option, any later version) -- see `LICENSE`.
