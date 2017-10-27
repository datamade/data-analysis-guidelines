report.pdf : report.tex
	cd examples/analyses && pdflatex $<

report.tex : report.ptexw pandas.tex
	pweave -f tex $<

pandas.tex : pandas.pmd
	pweave -f tex -i noweb $<
