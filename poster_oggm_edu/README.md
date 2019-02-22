UIBK corporate design: LaTeX style files
========================================

#### _Description_

* Summary: LaTeX style files for the new [corporate design](https://www.uibk.ac.at/public-relations/intranet/)
  of Universität Innsbruck, with feedback from the BfÖ, providing `beamer`-based slides and posters as well
  as `scrlttr2`-based letters.
* Authors: Reto Stauffer (`Reto.Stauffer@uibk.ac.at`), Christian Sternagel (`Christian.Sternagel@uibk.ac.at`), Achim Zeileis (`Achim.Zeileis@uibk.ac.at`).
* Copyright: Reto Stauffer, Christian Sternagel, Achim Zeileis (style files), Universität Innsbruck (logos/images).
* License: GPL-2 | GPL-3
* URL: [https://git.uibk.ac.at/uibklatex/beamer_letter/](https://git.uibk.ac.at/uibklatex/beamer_letter/)
* Documentation: Some hands-on comments and basic documentation is contained in the LaTeX sources of
  `slides.tex`, `poster.tex`, and `letter.tex`, respectively.


#### _Files_

* `beamerthemeuibk.sty`: Main beamer theme style file.
* `beamerthemeuibkposter.sty`: Additional styles for posters (based on `beamerthemeuibk.sty`).
* `uibklttr.cls`: LaTeX letter class.
* `uibklttr.cfg`: Personal configuration file for letters.
* `letter.tex`: Example LaTeX file for letters.
* `slides.tex`: Example LaTeX file for presentation slides (16:9 and 4:3 option available).
* `poster.tex`: Example LaTeX file for conference posters (portrait and landscape option available). 
* `qrcode.pdf`: Example of a QR code for a poster with more information or poster download.
*  `_/images/` contains the images used by the `beamerthemeuibk` and `beamerthemeuibkposter`. Namely:
   * `_/images/uibk_logo_4c_cmyk.pdf`: UIBK logo (2016 version).
   * `_/images/uibk_header1.png`: UIBK header image 1 for slides
   * `_/images/uibk_header2.png`: UIBK header image 2 for slides
   * `_/images/uibk_header3.png`: UIBK header image 3 for slides
   * `_/images/uibk_header4.png`: UIBK header image 4 for slides 
   * `_/images/uibk_header1p.png`: UIBK header image 1 for posters 
   * `_/images/uibk_header2p.png`: UIBK header image 2 for posters
   * `_/images/uibk_header3p.png`: UIBK header image 3 for posters
   * `_/images/uibk_header4p.png`: UIBK header image 4 for posters
   * `_/images/license_ccby.pdf`: CC-BY license logo.


#### _Installation_

* All-inclusive (_recommended_): Copy all files/folders to your TEXMF tree, e.g., `texmf/tex/latex/uibklatex/`.
* Letter-only: Copy the file `uibklttr.cls` (and optionally `uibklttr.cfg`) along with `uibk_logo_4c_cmyk.pdf` to your working directory.
* Beamer-only: Copy the file `beamerthemeuibk.sty` and the entire folder `_images` to your local working directory.
* Poster-only: Copy `beamerthemeuibkposter.sty` in addtion to the beamer-only files.
* Templates: Start with the example LaTeX file (`letter.tex`, `slides.tex`, or `poster.tex`),
  containing the sources for a demo along with many useful hints and comments in the source code.
* Compile with pdfLaTeX.


#### _Implementation details_

_Colors:_ The corporate design colors are pre-defined: `uibkblue` and `uibkorange`. Furthermore,
light versions of these colors (e.g., for backgrounds or shadings of images) are provided
(`uibkbluel` and `uibkorangel`). Moreover, three levels of gray are provided: `uibkgray`
(used for the regular text), a medium `uibkgraym` (e.g., used for frame titles), and a light
`uibkgrayl` (for backgrounds and shadings).

_Fonts:_ The corporate design employs the fonts Frutiger and Calibri which are not easily available
across systems in LaTeX. Therefore, the font "Carlito" from the LaTeX package `{carlito}`
is used as a font-metric compatible replacement for Calibri and the font "Bera Sans"
from the LaTeX package `{berasans}` is employed as a Frutiger descendant.

_KOMA-Script:_ The `uibklttr.cls` class depends on the KOMA-Script class
`scrlttr2.cls` (see also below), necessitating a recent version of KOMA-Script. Older LaTeX
distributions may ship with outdated versions, though, leading to an error during compilation
(error in: `\ifstrstart{#1}{plain.scrheadings.foot}`). If you encounter this problem please
update KOMA-Script on your system, e.g.:

* Visit [https://www.ctan.org/pkg/koma-script](https://www.ctan.org/pkg/koma-script).
* Download the latest `koma-script.tds.zip` and unzip the archive.
* Copy the folder `tex/latex/koma-script/` into your TEXMF tree, e.g., `~/texmf/tex/latex/koma-script/`.
* Tested with: LaTeX 3.14159265-2.6-1.40.16 and KOMA-Script 2017/04/13 v3.23.


Presentation slides and posters
===============================

#### _Features_

* Based on the general LaTeX class `beamer`,
  thus providing the corresponding usual formatting options.
* Aspect ratio: 16:9 or 4:3.
* Header images: One of four images from the corporate design.
* Colors: Predefined colors from the corporate design in different shadings (see above).
* Footer options: Formatting, page numbering, Creative Commons license.

**Example:** 16:9 slides with footer, university logo, and no total frame count.

    \documentclass[11pt,t,usepdftitle=false,aspectratio=169]{beamer}
    \usetheme[nototalframenumber,foot,logo]{uibk}
    \headerimage{3}


#### _Additional poster features_

* Also based on the UIBK `beamer` class plus some further formatting.
* Orientation: Landscape or portrait.
* Size: A0 or A1.
* Color themes: Default theme (using `uibkblue` and `uibkgraym`) or
  alternatively `orangetheme` (using `uibkorange` for titles etc.).
* Flexible specification of the number of columns.

**Example:** A0 landscape poster with 3 columns using the orange theme

    \documentclass[final]{beamer}
    \usepackage[orientation=landscape,size=a0,scale=1.30]{beamerposter}
    \usetheme[ncols=3,orangetheme]{uibkposter}
    \headerimage{3}


#### _Verbatim commands_

The beamer theme provides a set of useful functions such as `\email`, `\doi`,
`\file` and `\dataset` (among others) which produce verbatim output. By default
they use the text color (dark gray) but could be changed manually, e.g., to `uibkblue`.

    \setbeamercolor{verbcolor}{fg=uibkblue}


Letters
=======

#### _Features_

* Based on the general LaTeX class `scrlttr2` (using KOMA-Script), thus providing the corresponding usual formatting options.
* Flexible configuration of header (faculty/department/name), footer (address), and reference lines (telephone/fax/etc.).
* Colors: Predefined colors from the corporate design in different shadings (see above).
* Footer options: Formatting, page numbering, Creative Commons license.

#### _KOMA variables_

_Header:_

* `subtext`: Additional text (faculty) beneath the logo.
* `institute`: Additional text (department/name) "top right".

_Footer:_

* `fromaddress`: Address line.

_Reference line:_

* `fromname`: Name/title.
* `fromemail`: E-mail.
* `fromphone`: Telephone number.
* `fromfax`: Fax number.
* `refnum`: Reference number (Geschäftszahl).

_Formatting:_

* `backaddress`: Empty.
* `firstfoot`: Positioning `fromaddress`.
* `firsthead`: Positioning `fromlogo`, `subtext` and `institute`.
* `fromlogo`: UIBK logo.
* `invoice`: Positioning `date`.
* `yourref`: Positioning reference line (`fromname`/`fromemail`/...).

The personal configuration for letters (name, address, faculty, department, ...)
can be stored in `uibklttr.cfg`. This is then loaded automatically by `uibklttr`
(unless suppressed by the `noconfig` option as in the `letter.tex` template).

To omit the entire header (including the logo) for pre-printed letter paper
the `noheader` option, e.g., `\documentclass[ngerman,noheader]{uibklttr}`.
