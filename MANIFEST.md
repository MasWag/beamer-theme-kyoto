# Manifest

This file lists the files that make up the Kyoto Beamer theme (the LPPL
"Work"; see `LICENSE`). Each `.sty` file's header points here instead of
repeating this list. When adding a new theme, TikZ, or example file,
add it to the appropriate section below.

## Theme source

- `beamerthemeKyoto.sty`
- `beamercolorthemeKyoto.sty`
- `beamerfontthemeKyoto.sty`
- `beamerinnerthemeKyoto.sty`
- `beamerouterthemeKyoto.sty`

## TikZ library

- `tikzlibrarykyoto.code.tex`

## Example

- `examples/demo.tex`
- `examples/tikz-demo.tex`
- `examples/tikz-standalone.tex`
- `examples/latexmkrc`
- `examples/images/dummy-university-logo.pdf`

## Build and CI

- `Makefile`
- `.github/workflows/build-example.yml`

## Project documentation

- `README.md`
- `MANIFEST.md`
- `LICENSE`

## Not part of the Work

Generated build output -- e.g. `examples/demo.pdf` and other LaTeX
auxiliary files produced by compiling the example -- is not part of the
Work. These are git-ignored (see `.gitignore`) and are regenerated with
`make`.
