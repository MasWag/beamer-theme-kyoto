# Build the Kyoto Beamer theme examples (presentation, poster,
# TikZ demo, and standalone TikZ) with
# LuaLaTeX via latexmk, without installing the theme into TEXMF first.
#
# Usage:
#   make        # build all three example PDFs
#   make clean  # remove generated files

.PHONY: all clean

all:
	cd examples && latexmk demo.tex poster-demo.tex tikz-demo.tex tikz-standalone.tex

clean:
	cd examples && latexmk -C demo.tex poster-demo.tex tikz-demo.tex tikz-standalone.tex
