# Build the Kyoto Beamer theme examples (examples/demo.pdf and
# examples/tikz-demo.pdf) with LuaLaTeX via latexmk, without installing
# the theme into TEXMF first.
#
# Usage:
#   make        # build both example PDFs
#   make clean  # remove generated files

.PHONY: all clean

all:
	cd examples && latexmk demo.tex tikz-demo.tex

clean:
	cd examples && latexmk -C demo.tex tikz-demo.tex
