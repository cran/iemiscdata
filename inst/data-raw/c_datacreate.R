# Table 1: Values of Runoff Coefficient C in Urban Areas

library(data.table)

# read in the csv
c_urban <- fread("./inst/extdata/c_urban.csv")


# split on  - to create 2 new columns
c_urban[, c("Minimum Runoff Coefficient C", "Maximum Runoff Coefficient C") := tstrsplit(`Runoff coefficient C`, " - ", fixed = TRUE)]


# change the new columns to numeric
change_class <- c("Minimum Runoff Coefficient C", "Maximum Runoff Coefficient C")

for (col in change_class)

set(c_urban, j = col, value = as.numeric(c_urban[[col]]))


# make the average column
c_urban[, `Average Runoff Coefficient C` := apply(c_urban[, 3:4], 1, mean)]
# Source 1

# set the column order
setcolorder(c_urban, c("Type of drainage area", "Minimum Runoff Coefficient C", "Average Runoff Coefficient C", "Maximum Runoff Coefficient C", "Runoff coefficient C"))

# save the data
save(c_urban, file = "./data/c_urban.rda")






# Table 2: Values of Runoff Coefficient C in Agricultural Areas

library(data.table)

# read in the csv
c_agricultural <- fread("./inst/extdata/c_agricultural.csv")


# change the new columns to numeric
change_class <- c("Open Sandy Loam -  Runoff Coefficient C", "Clay and Silt Loam -  Runoff Coefficient C", "Tight Clay – Runoff Coefficient C")

for (col in change_class)

set(c_agricultural, j = col, value = as.numeric(c_agricultural[[col]]))


# save the data
save(c_agricultural, file = "./data/c_agricultural.rda")





# Data source 
# https://web.archive.org/web/20211018222532/https://www.nrcs.usda.gov/Internet/FSE_DOCUMENTS/stelprdb1083019.pdf
# Hydrology Training Series: Module 206 D - Peak Discharge (Other Methods) Study Guide
# page 16 of the PDF document

# R help source
# https://www.tutorialspoint.com/how-to-create-a-new-column-with-means-of-row-values-for-each-or-some-of-the-columns-in-an-r-data-frame
# How to create a new column with means of row values for each or some of the columns in an R data frame?
# By Nizamuddin Siddiqui, Updated on 21-Aug-2020 
