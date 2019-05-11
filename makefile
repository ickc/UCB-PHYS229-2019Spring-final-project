SHELL = /usr/bin/env bash

# configure engine
## LaTeX engine
### pandoc workflow: pdflatex; xelatex; lualatex
pandocEngine = xelatex
## PDF: latex, beamer
PDFVersion = latex

MD = $(wildcard */*.md) $(wildcard *.md)
MD2PDF = $(patsubst %.md,docs/%.pdf,$(MD))
MD2HTML = $(patsubst %.md,docs/%.html,$(MD))

IPYNB = $(wildcard notebook/*.ipynb)
IPYNB2HTML = $(patsubst %.ipynb,docs/%.html,$(IPYNB))

CSSURL=https://cdn.jsdelivr.net/gh/ickc/markdown-latex-css
# command line arguments
pandocArgCommon = -f markdown+autolink_bare_uris-fancy_lists -V linkcolorblue -V citecolor=blue -V urlcolor=blue -V toccolor=blue --pdf-engine=$(pandocEngine) --filter=pandoc-citeproc --bibliography=citation.bib --csl=the-astronomy-and-astrophysics-review.csl --toc --toc-depth=5 --filter pantable -V date="`potentialDate=$*; date -d"$${potentialDate:0:8}" '+%B %e, %Y' || date '+%B %e, %Y'`"
## MD
pandocArgFragment = $(pandocArgCommon)
### pandoc workflow
pandocArgStandalone = $(pandocArgFragment) -s -N
### PDF
pandocArgPDF = $(pandocArgStandalone) -t $(PDFVersion)
## HTML/ePub
pandocArgHTML = $(pandocArgFragment) -s -N --mathjax -c $(CSSURL)/css/common.min.css -c $(CSSURL)/fonts/fonts.min.css

####################################################################################################################################

html: $(MD2HTML) $(IPYNB2HTML)
pdf: $(MD2PDF)
all: html pdf
docs: all

clean:
	find . -type d -empty -delete

Clean: clean
	rm -f $(MD2PDF) $(MD2HTML)

####################################################################################################################################

docs/%.pdf: %.md
	mkdir -p $(@D)
	pandoc $(pandocArgPDF) -o $@ $^

### md to HTML: $(pandocHTML)
docs/%.html: %.md
	mkdir -p $(@D)
	pandoc $(pandocArgHTML) -o $@ $^

docs/%.html: %.ipynb
	mkdir -p $(@D)
	jupyter nbconvert $< --output=../$@

####################################################################################################################################

# check that report.md linked to all notebook
check-notebook:
	# find notebook -name '*.ipynb' | sort
	# find notebook -name '*.ipynb' -exec bash -c 'filename=$${0##*/}; grep -o $$filename report.md' {} \; | sort -u
	find notebook -name '*.ipynb' -exec bash -c 'filename=$${0##*/}; filename_wo_ext=$${filename%.*}; printf "%s\t" $$filename; grep -q $$filename report.md || printf "%s\t" "no ipynb"; grep -q $$filename_wo_ext.html report.md || printf "no html"; echo' {} \;
