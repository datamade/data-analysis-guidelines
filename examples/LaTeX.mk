report.pdf : report.tex
	cd examples/analyses && pdflatex $<

report.tex : report.ptexw pandas.tex
	pweave $<

pandas.tex : pandas.mdw data
	pweave -f tex $<
