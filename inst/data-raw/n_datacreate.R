# Manning's n values

library(data.table)

mann <- fread("./inst/extdata/Manningsn.csv")
setnames(mann, as.character(mann[1]))
setnames(mann, 2:ncol(mann), c("Minimum n", "Normal n", "Maximum n"))
mann <- mann[-1]

# changing column to numeric class
# obtain the name of the column based on the column number
change_class <- names(mann[, 2:ncol(mann), with = FALSE])
for (col in change_class) set(mann, j = col, value = as.numeric(mann[[col]]))


# 1. Manning's n for Channels (Chow, 1959)
nchannel <- mann[1:(which(grepl("Manning's n for Closed Conduits Flowing Partly Full", mann[, 1, with = FALSE][[1]]))-1L)]

# change the first column name
setnames(nchannel, "Manning's n for Channels (Chow, 1959).", "Type of Channel and Description")

nchannel <- nchannel[-c(1, 99:100)]

save(nchannel, file = "./data/nchannel.rda")



# 2. Manning's n for Closed Conduits Flowing Partly Full (Chow, 1959)
npartfull <- mann[which(grepl("Manning's n for Closed Conduits Flowing Partly Full", mann[, 1, with = FALSE][[1]])):(which(grepl("Manning's n for Corrugated Metal Pipe", mann[, 1, with = FALSE][[1]]))-1L)]
npartfull <- npartfull[-c(1, 41:42)]
setnames(npartfull, 1, npartfull[[1]][1])
npartfull <- npartfull[-1]

save(npartfull, file = "./data/npartfull.rda")



# 3. Manning's n for Corrugated Metal Pipe (AISI, 1980)
nmetalpipe <- mann[which(grepl("Manning's n for Corrugated Metal Pipe", mann[, 1, with = FALSE][[1]])):nrow(mann)]
nmetalpipe <- nmetalpipe[-c(1:2), -c(3:4), with = FALSE]
setnames(nmetalpipe, c("Type of Pipe and Diameter and Corrugation Dimension", "n"))

save(nmetalpipe, file = "./data/nmetalpipe.rda")


# Data source 
# https://www.fsl.orst.edu/geowater/FX3/help/8_Hydraulic_Reference/Mannings_n_Tables.htm
# Manning's n Values
# Reference tables for Manning's n values for Channels, Closed Conduits Flowing Partially Full, and Corrugated Metal Pipes.




## Table 3-1: Roughness coefficients (Manning's n) for sheet flow

library(data.table)

# read in the data
nsheetflow <- fread("./inst/extdata/Mannings_n_sheet-flow.csv")

# save the data
save(nsheetflow, file = "./data/nsheetflow.rda")



# read in the notes
nsheetflow_notes <- fread("./inst/extdata/Mannings_n_sheet-flow_notes.csv")

# save the notes
save(nsheetflow_notes, file = "./data/nsheetflow_notes.rda")



# Notes for the table metadata:
# *1 The n values are a composite of information compiled by Engman (1986).

# *2 Includes species such as weeping lovegrass, bluegrass, buffalo grass, blue grama grass, and native grass mixtures.

# *3 When selecting n, consider cover to a height of about 0.1 ft. This is the only part of the plant cover that will obstruct sheet flow.


# Data source
# https://directives.sc.egov.usda.gov/OpenNonWebContent.aspx?content=22162.wba
# Urban Hydrology for Small Watersheds, TR-55
# page 3-3
