# iemiscdata

R data package with miscellaneous data sets [Engineering Economics, Environmental/Water Resources Engineering, Nuclear Accidents, US Environmental Protection Agency (EPA) RadNet readings before and after the Fukushima Daiichi & Daini nuclear power plant accidents/explosions, US Presidential Elections, etc.]. Look for all of these data sets and more in future releases.


# Installation

```R
install.packages("iemiscdata")
```


# Package Contents
This package currently contains three datasets:

* `nchannel`: Manning's n for Channels (Chow, 1959)
* `npartfull`: Manning's n for Closed Conduits Flowing Partly Full (Chow, 1959)
* `nmetalpipe`: Manning's n for Corrugated Metal Pipe (AISI, 1980)

The Manning's n data sets are from [FishXing Version 3.0 Beta (2006)](http://www.fsl.orst.edu/geowater/FX3/help/8_Hydraulic_Reference/Mannings_n_Tables.htm). The html tables are also present in PDF format in this package.


# View PDF version of the tables
If you would like to view the PDF tables, then use the code below that matches your operating system:

Source: [Show me the pdf already | R-bloggers By Will](http://www.r-bloggers.com/show-me-the-pdf-already/)
```R
# under Unix type operating sytem
pdf <- getOption("pdfviewer", default = "")
f <- system.file("pdf", "Mannings_n_Values.pdf", package = "iemiscdata")
system2(pdf, args = f)
```


Source: [Show me the pdf already | R-bloggers By Will](http://www.r-bloggers.com/show-me-the-pdf-already/)
```R
# under MS Windows
f <- system.file("pdf", "Mannings_n_Values.pdf", package = "iemiscdata")
shell.exec(normalizePath(f))
```


Source: [Opening PDF within R studio using file.show - Stack Overflow -- rensa](http://stackoverflow.com/questions/33791493/opening-pdf-within-r-studio-using-file-show/33791818)
```R
# under OS X
f <- system.file("pdf", "Mannings_n_Values.pdf", package = "iemiscdata")
system2("open", args = f, wait = FALSE)
```


# Examples
```R
library(iemiscdata)

# Use grep to find the row number matching the given description
# Use nchannel$"Type of Channel and Description" to select the column to search
# through
# Use nchannel[nlocation, 4] to select the row number from nlocation and
# column 4
# Similar steps are performed for each of these examples

# Example 1
# What is the maximum Manning's n value for 1) Natural streams - minor streams
# (top width at floodstage < 100 ft), 2) Mountain streams, no vegetation
# in channel, banks usually steep, trees and brush along banks submerged at
# high stages and 3) bottom: gravels, cobbles, and few boulders?
data(nchannel)

nlocation <- grep("bottom: gravels, cobbles, and few boulders",
nchannel$"Type of Channel and Description")
n <- nchannel[nlocation, 4] # 4 for column 4 - Maximum n


# Example 2
# What is the minimum Manning's n value for 1) Closed Conduits Flowing Partly
# Full, 2) Wood and 3) Stave?
data(npartfull)

nlocation <- grep("Stave",
npartfull$"Type of Conduit and Description")
n <- npartfull[nlocation, 2] # 2 for column 2 - Minimum n


# Example 3
# What is the Manning's n value for 1) Corrugated Metal Pipe,
# 2) Corrugations 6x2 inches and 3) 60" diameter?
data(nmetalpipe)
nnear <- grep("Corrugations 6x2 inches",
nmetalpipe$"Type of Pipe, Diameter and Corrugation Dimension")
# nnear is the row number matching the description
nlocation <- nlocation[which(grep("60\"\" diameter",
nmetalpipe$"Type of Pipe, Diameter and Corrugation Dimension") > nnear)]
# which provides all locations matching the description
# > nnear gives the row number(s) greater than nnear since the requested
# diameter is in the section located after nnear
n <- nmetalpipe[nlocation, 2] # 2 for column 2 - n


# Example 4
# Example to compute the "gradually-varied flow profile of a prismatic
# channel" with these channel conditions used to find Manning's n (normal):
# 1) Natural streams - minor streams (top width at floodstage < 100 ft),
# 2) Excavated or Dredged Channels, 3) Earth, straight, and uniform, &
# 4) clean, recently completed.
# Quote source: rivr's compute_profile

# Using the data for the M1 profile example in rivr's compute_profile, except
# for the value of n

library(rivr)
# to find the channel condition
nlocation <- grep("clean, recently completed",
nchannel$"Type of Channel and Description")
# use grep to find the n's row number
n <- nchannel[nlocation, 3] # 3 for column 3 - Normal n

compute_profile(0.001, n, 250, 2.7, 1.486, 32.2, 100, 0, stepdist = 50,
totaldist = 3000)
```
