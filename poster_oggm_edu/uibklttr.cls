%
% UIBK Letter Class for LaTeX2e
% (replaces Stephen Cobeldick's "uibkletter" class)
%
% License: GPL-2 | GPL-3
% Copyright: (C) 2017 Christian Sternagel, Reto Stauffer, Achim Zeileis
% Please report errors to: Christian.Sternagel@uibk.ac.at or Achim.Zeileis@uibk.ac.at
%
\newcommand*{\uibkclass}{uibklttr}
\newcommand*{\uibkversion}{0.2}
\newcommand*{\uibkreleased}{2017/08/16}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{\uibkclass}[\uibkreleased\space v\uibkversion\space UIBK Letter]
\RequirePackage{xkeyval}
\RequirePackage{xcolor}

%% UIBK corporate design colors
\definecolor{uibkblue}{cmyk}{1,0.6,0,0.65}%
\definecolor{uibkbluel}{rgb}{0.89,0.94,1.00}%

\definecolor{uibkorange}{cmyk}{0,0.5,1,0}%
\definecolor{uibkorangel}{rgb}{1.00,0.90,0.76}%

\definecolor{uibkgray}{cmyk}{0,0,0,0.9}%
\definecolor{uibkgraym}{cmyk}{0,0,0,0.6}%
\definecolor{uibkgrayl}{cmyk}{0,0,0,0.2}%
\definecolor{gray80}{cmyk}{0,0,0,.8}%

% the 2 main colors of a letter document
\colorlet{uibklttrdefault}{uibkgray}
\colorlet{uibklttrlighter}{uibkgraym}

% optionally ignore configuration file
\newif\if@uibknoconfig
\DeclareOption{noconfig}{\@uibknoconfigtrue}

% optionally omit header/footer
\newif\if@uibknoheader
\DeclareOption{noheader}{\@uibknoheadertrue}

\DeclareOption{darker}{%
  \colorlet{uibklttrdefault}{black}%
  \colorlet{uibklttrlighter}{uibkgray}%
}

% default options (may be overwritten in \documentclass[...]{...})
\PassOptionsToClass{
  DIV=14,%
  fontsize=10pt,%
  firstfoot=false, % Disable firstfoot
  refline=nodate,% date is produced in non-standard way
  foldmarks=pb,% deactivate punch-mark and bottom-foldmark
  enlargefirstpage,% bigger text area on first page
  parskip=full% use vertical space instead of paragraph indentation
}{scrlttr2}

\DeclareOptionX*{%
  \PassOptionsToClass{\CurrentOption}{scrlttr2}%
}
\ProcessOptionsX\relax

\LoadClass{scrlttr2}

\RequirePackage{graphicx}
\RequirePackage{iflang}
\RequirePackage{babel}

% Text font: carlito, a font-metric compatible replacement for Calibri
\RequirePackage{eurosym}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\DeclareUnicodeCharacter{20AC}{\euro}
\usepackage[sfdefault,lf]{carlito}

\RequirePackage{microtype}
\RequirePackage{lastpage}
\RequirePackage{ifthen}
\RequirePackage{scrlayer-scrpage}
\@setplength{firstfootwidth}{\textwidth}
\KOMAoptions{footwidth=\useplength{firstfootwidth}}
%% change koma font for the footer and the whole block including fromname
%% to fvs: Bera Sans, a Frutiger descendant
\addtokomafont{pagefoot}{\normalfont\fontfamily{fvs}\selectfont\footnotesize\color{uibklttrlighter}}
\addtokomafont{fromname}{\fontfamily{fvs}\selectfont\footnotesize}

\ForEachLayerOfPageStyle*{plain.scrheadings}{%
  \ifstrstart{#1}{plain.scrheadings.foot}{%
    \ModifyLayer[
      voffset=\useplength{firstfootvpos},
      hoffset=\useplength{firstfoothpos}
    ]{#1}
  }{}
}% shift the footer down

%% Changes Reto, 2017-08-16
\pagestyle{plain}
\usepackage{xpatch}
\xapptocmd\opening{\thispagestyle{plain}}{}{}% <- first pages will have pagestyle plain too
\cfoot*{\usekomavar{firstfoot}} % Sets footer for follow-up pages identical to firstfoot

% make signature left aligned
\renewcommand\raggedsignature{}
% print pagenumber if more than one page
\IfLanguageName{english}{%
  \def\pagename{Page}%
}{%
  \def\pagename{Seite}%
}
%\newcommand\pagenumberformat[1]{\pagename~#1}
\newcommand\pagenumberformat[1]{#1}
\newcommand\pagenumber{%
  \ifthenelse{\equal{\pageref{LastPage}}{1}}{}{%
    \usekomafont{pagefoot}\pagenumberformat{\thepage}}}


% set KOMA variables
% text below of the logo
\newkomavar{subtext}
\@newplength{subtextwidth}
\@setplength{subtextwidth}{5cm}

% text to the right of the subtext
\newkomavar{institute}
\@newplength{institutewidth}
\@setplength{institutewidth}{8cm}

% mobile phone name
\defcaptionname{ngerman}{\mobilephonename}{Mobil}

% reference number
\providecaptionname{english}{\refnumname}{Reference number}
\providecaptionname{ngerman}{\refnumname}{Gesch\"aftszahl}
\newkomavar{refnum}
\setkomavar*{refnum}{\refnumname}

% text of logo should be aligned with left margin
\graphicspath{{_images/}}
\setkomavar{fromlogo}{\kern-13.5mm\includegraphics[width=55mm]{uibk_logo_4c_cmyk}}
\setkomavar{firsthead}{\usekomavar{fromlogo}%
  \\[-6mm]
  \parbox[t][][b]{\useplength{subtextwidth}}{\fontfamily{fvs}\selectfont\footnotesize\usekomavar{subtext}}
  \hfill
  \parbox[t][][b]{\useplength{institutewidth}}{\fontfamily{fvs}\selectfont\footnotesize\color{uibklttrlighter}\usekomavar{institute}}}
% no back address
\setkomavar{backaddress}{}
\setkomavar{fromaddress}{%
  Universit\"at Innsbruck, Innrain 52, 6020 Innsbruck}
\setkomavar{firstfoot}{\usebox{\uibklttrfooterbox}}
  %\usekomafont{pagefoot}\usekomavar{fromaddress}\hfill\pagenumber}
\setkomavar{emailseparator}{}
\setkomavar{phoneseparator}{}
\setkomavar{faxseparator}{}
\setkomavar{yourref}[]{\usekomafont{fromname}%
  \begin{tabular}[t]{@{}l@{\qquad}l@{\qquad\qquad}l}
  \strut\bfseries
  \ifkomavarempty{fromname}{}{\usekomavar*{fromname}}
  \ifkomavarempty{fromemail}{}{/ \usekomavar*{fromemail}} &
  \bfseries
  \ifkomavarempty{fromphone}{}{\usekomavar*{fromphone}}
  \ifkomavarempty{fromfax}{}{/ \usekomavar*{fromfax}} &
  \bfseries
  \ifkomavarempty{refnum}{}{\usekomavar*{refnum}} \\
  \usekomavar{fromname} & \usekomavar{fromphone} & \usekomavar{refnum} \\
  \usekomavar{fromemail} & \usekomavar{fromfax}
  \end{tabular}}
\setkomavar{invoice}[]{%
  \fontfamily{fvs}\selectfont\footnotesize
  \begin{tabular}[t]{l}
  \strut\bfseries\usekomavar*{date}\\
  \usekomavar{date}
  \end{tabular}}
\@setplength{refvpos}{85mm}
\@setplength{tfoldmarklength}{5mm}
\@setplength{foldmarkhpos}{0mm}

% align horizontal position of left margin and address/firsthead/firstfoot
\@setplength{firstheadhpos}{\dimexpr 1in + \oddsidemargin\relax}
\@setplength{firstfoothpos}{\useplength{firstheadhpos}}
\@setplength{toaddrhpos}{\useplength{firstheadhpos}}

% read user configuration file (if any)
\if@uibknoconfig%
\else%
  \InputIfFileExists{uibklttr.cfg}{\typeout{Importing sender configuration file...}}{}
\fi%

% omit header/footer if desired
\if@uibknoheader%
  \setkomavar{firsthead}{}%
  \setkomavar{firstfoot}{}%
\else%
\fi%

% page foot
\newcommand\makefooter{%
  \newsavebox\uibklttrfooterbox%
  \begin{lrbox}{\uibklttrfooterbox}%
  \begin{minipage}[b]{\textwidth}%
  \usekomafont{pagefoot}\usekomavar{fromaddress}\hfill\pagenumber%
  \ifkomavarempty{fromphone}{}{%
    \\\usekomavar*{fromphone}: \usekomavar{fromphone}}
  \ifkomavarempty{frommobilephone}{}{%
    | \usekomavar*{frommobilephone}: \usekomavar{frommobilephone}}
  \ifkomavarempty{fromfax}{}{%
    | \usekomavar*{fromfax}: \usekomavar{fromfax}}
  \ifkomavarempty{fromemail}{}{%
    \\\usekomavar*{fromemail}: \usekomavar{fromemail}}
  \end{minipage}
  \end{lrbox}%
}%

\AtBeginDocument{%
  % default font color
  \color{uibklttrdefault}
  % avoid text of first page to run into foot of page
  \setlength{\footskip}{20mm}
}

\AtBeginLetter{%
  \makefooter%
  \@addtoplength{firstfootvpos}{-\ht\uibklttrfooterbox}%
  \@addtoplength{firstfootvpos}{1ex}%
}

\pagestyle{plain}

