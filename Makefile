export TEXINPUTS:=./src:${TEXINPUTS}

##
## Makefile for the document, based on:
##
## https://tex.stackexchange.com/questions/40738/how-to-properly-make-a-latex-project
##

# Document name
DOCNAME = my-doc

# You want latexmk to *always* run, because make does not have all the info.
# Also, include non-file targets in .PHONY so they are run regardless of any
# file of the given name existing.
.PHONY: build/$(DOCNAME).pdf all clean

# The first rule in a Makefile is the one executed by default ("make"). It
# should always be the "all" rule, so that "make" and "make all" are identical.
all: build/$(DOCNAME).pdf

##
## CUSTOM BUILD RULES
##

##
## MAIN LATEXMK RULE
##

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interaction=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

build/$(DOCNAME).pdf: build/Main.tex src/references.bib
	latexmk -quiet -pdf -jobname=$(DOCNAME) -cd build/Main.tex

build/Main.tex: src/Main.lhs src/format.fmt build
	lhs2TeX -P src src/Main.lhs > build/Main.tex

build:
	mkdir build

clean:
	rm -rf build
