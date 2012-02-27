docdir = $(pkgdatadir)/doc
TEX =  ipadic-ja.tex  
PDF =  ipadic-ja.pdf
EXTRA_DIST = $(TEX) $(PDF)
SUFFIXES= .tex .dvi .pdf

.tex.dvi:
	platex $<
	platex $<

.dvi.pdf:
	dvipdfm $<

