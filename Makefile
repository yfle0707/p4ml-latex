#
# $Id: Makefile,v 1.1 2006/06/27 21:10:04 shafer Exp $
#
# Makefile for converting tex files to PDF
#

all: p4ml-latex.pdf

#
# We want our main "pdf" to depend on all the "tex" and "bib" source
#

#p4ml-latex.pdf: sig-alternate-10pt.cls *.tex *.bib figures/*
#p4ml-latex.pdf: acmart.cls *.tex *.bib figures/*

p4ml-latex.pdf: *.tex *.bib  
#
# Now provide the rules for building the various targets and
# intermediate targets
#

%.pdf : %.tex
	pdflatex $<
	bibtex --min-crossrefs=1000 $*
	pdflatex $<
	pdflatex $<

%.ps : %.dvi
	dvips -Ppdf -Pcmz -Pamz -t letter -D 600 -G0 -j0 -o $@ $<

# %.pdf : %.ps
# 	ps2pdf14 -dPDFSETTINGS=/prepress -dEmbedAllFonts=true -dCompatibilityLevel=1.2 -dProcessColorModel=/DeviceGray -dSubsetFonts=true -dMaxSubsetPct=100 $< $@

clean:
	-rm -f *.dvi *.log *.aux *.bbl *.blg *.ent *.out p4ml-latex.pdf

#
# Run "make balance" after adding balance columns at the right place
#

balance:
	latex p4ml-latex
	latex p4ml-latex
	dvips -o p4ml-latex.ps p4ml-latex.dvi
	ps2pdf p4ml-latex.ps p4ml-latex.pdf
