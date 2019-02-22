all: letter.pdf slides.pdf poster.pdf clean

uibklatex.zip: README.pdf letter.pdf slides.pdf poster.pdf clean
	zip -r uibklatex.zip uibklttr.cls beamerthemeuibk.sty beamerthemeuibkposter.sty README.pdf LICENSE _images letter.tex letter.pdf slides.tex slides.pdf poster.tex poster.pdf qrcode.pdf

README.pdf: README.md
	pandoc -o README.pdf README.md

letter.pdf: uibklttr.cls uibklttr.cfg letter.tex
	pdflatex letter.tex
	pdflatex letter.tex

slides.pdf: beamerthemeuibk.sty slides.tex
	pdflatex slides.tex
	pdflatex slides.tex

poster.pdf: beamerthemeuibk.sty beamerthemeuibkposter.sty poster.tex
	pdflatex poster.tex
	pdflatex poster.tex

clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.vrb
	rm -f *~

distclean: clean
	rm -f letter.pdf slides.pdf poster.pdf README.pdf uibklatex.zip
