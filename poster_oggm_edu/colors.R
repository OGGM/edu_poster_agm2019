# -------------------------------------------------------------------
# - NAME:        colors.R
# - AUTHOR:      Reto Stauffer
# - DATE:        2017-06-28
# -------------------------------------------------------------------
# - DESCRIPTION: Reading 'colors.txt' containing the faculty colors
#                of all faculties at the university of innsbruck and
#                creates a light version of the color.
#
#                The output of this script is what is used in the
#                beamerclass 'uibk' to define the two colors 'uibkcol'
#                and 'uibkcoll'.
# -------------------------------------------------------------------
# - EDITORIAL:   2017-06-28, RS: Created file on thinkreto.
# -------------------------------------------------------------------
# - L@ST MODIFIED: 2017-07-18 19:07 on thinkreto
# -------------------------------------------------------------------


# -------------------------------------------------------------------
# Loading the required package to perform the color manipulation
# -------------------------------------------------------------------
   library('colorspace')

# -------------------------------------------------------------------
# Reading color definition.
# -------------------------------------------------------------------
   # Reading raw data
   raw <- read.table("colors.txt",header=TRUE)

   # Convert hexcolors to rgb and hcl
   rgb <- hex2RGB(sprintf("#%s",raw$hexcolor))
   hcl <- as(rgb,"polarLUV")

   # For the light version: setting luminance to 95%
   # and recude chroma for high chromatic colors.
   hcl@coords[,"L"] <- rep(95,nrow(raw))
   hcl@coords[,"C"] <- ifelse(hcl@coords[,"C"] > 50, 50, hcl@coords[,"C"])

   # Convert the new light version of the colors into hex and rgb
   lighthex <- hex(hcl,fixup=TRUE)
   lightrgb <- hex2RGB( lighthex )

   # Demo plot
   par(mfrow=c(2,1))
   image( matrix(seq(1,nrow(raw)),ncol=1), col = sprintf("#%s",raw$hex))
   image( matrix(seq(1,nrow(raw)),ncol=1), col = lighthex )

# -------------------------------------------------------------------
# Create output for LaTeX beamer theme 
# -------------------------------------------------------------------
   cat("   % Depending on the input in function \\setfaculty:\n")
   cat("   % define the two colors 'uibkcol' and 'uibkcoll'.\n")
   cat("   \\IfStrEqCase{#1}{%\n")
   for ( i in 1:nrow(raw) ) {
      if ( i == 1 ) { xtra = "" } else { xtra = "}" }
      cat(sprintf("      %s{%s}{",xtra,raw$faculty[i]))
      cat("%\n") # end line with %
      # Official faculty color
      cat(sprintf("         \\definecolor{uibkcol}{rgb}{%.2f,%.2f,%.2f}",
         rgb@coords[i,'R'],rgb@coords[i,'G'],rgb@coords[i,'B']))
      cat("%\n") # end line with %
      # Light faculty color
      cat(sprintf("         \\definecolor{uibkcoll}{rgb}{%.2f,%.2f,%.2f}",
         lightrgb@coords[i,'R'],lightrgb@coords[i,'G'],lightrgb@coords[i,'B']))
      cat("%\n") # end line with %
   }
   # Default color
   idx <- which(raw$faculty == "none")
   cat("      }}[%\n")
   # Official uibk blue (dark)
   cat(sprintf("         \\definecolor{uibkcol}{rgb}{%.2f,%.2f,%.2f}",
      rgb@coords[idx,'R'],rgb@coords[idx,'G'],rgb@coords[idx,'B']))
   cat("%\n") # end line with %
   # Light version of the uibk blue
   cat(sprintf("         \\definecolor{uibkcoll}{rgb}{%.2f,%.2f,%.2f}",
      lightrgb@coords[idx,'R'],lightrgb@coords[idx,'G'],lightrgb@coords[idx,'B']))
   cat("%\n") # end line with %
   cat("      ]\n")
   

## Markdown explanation (from old README.md)

## Setfacultycolors
## ----------------
## 
## The ``\setfacultycolors{slug}`` command in beamerthemeuibk and beamerthemeuibkposter
## is used to specify the faculty specific colors (namely  ``\uibkcol`` and ``\uibkcoll``)
## which are used in some of the commands provided by the beamertheme.
## PLEASE NOTE that this option should only be used in very special situations and not
## for your day-by-day work!
## 
## The following `slug`'s are currently implemented:
## 
## * `architektur`:  Fakultaet fuer Architektur
## * `betriebswirtschaft`: F. f. Betriebswirtschaft
## * `bildungswissenschaften`: F. f. Bildungswissenschaften
## * `biologie`: F. f. Biologie
## * `chemieundpharmazie`: F. f. Chemie und Pharmazie
## * `geoundatmosphaerenwissenschaften`: F. f. Geo- und Atmosphaerenwissenschaften
## * `mip`: F. f. Mathematik, Informatik und Physik
## * `socialandpoliticalsciences`: F. f. Soziale und Politische Wissenschaften
## * `psychologieundsportwissenschaften`: F. f. Psychologie und Sportwissenschaften
## * `technischewissenschaften`: F. f. Technische Wissenschaften
## * `volkswirtschaftundstatistik`: F. f. Volkswirtschaft und Statistik
## * `theol`: Katholisch-Theologische F.
## * `philologisch`: Philologisch-Kulturwissenschaftliche F.
## * `philosophisch`: Philosophisch-Historische F.
## * `law`: Rechtswissenschaftliche F.
## * `soe`: School of Education -- F. f. LehrerInnenbildung
## * `none`: Uses the color 'uibkblue' and a light version of it.
## 
## * These two colors could also be overruled manually (please dont).
## * `\definecolor{uibkcol}{cmyk}{.80,0,0,.20}`: defines the darker of the two colors.
## * `\definecolor{uibkcoll}{cmyk}{.24,.07,.06,0}`: defines the lighter of the two colors.
