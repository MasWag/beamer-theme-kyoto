# Build the Kyoto Beamer theme example (examples/demo.pdf) with LuaLaTeX
# via latexmk, without installing the theme into TEXMF first.
#
# Usage:
#   make        # build examples/demo.pdf
#   make clean  # remove generated files

.PHONY: all clean

all:
	cd examples && latexmk demo.tex

clean:
	cd examples && latexmk -C demo.tex
