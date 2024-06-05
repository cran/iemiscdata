install.load::load_package("data.table", "units", "round")


# TDOT Machined riprap Table (inches)

riprap_table <- data.table(V1 = c("Class A-1 ", "Class A-3", "Class B", "Class C", "Class IX"), V2 = c(2, 2, 3, 5, 0), V3 = c(15, 6, 27, 36, 72))

riprap_table[, V4 := mean(V2:V3), by = V1]



# riprap table in inches
riprap_table_in <- copy(riprap_table)

setnames(riprap_table_in, c("Machined riprap Class", "Minimum Diameter Size", "Maximum Diameter Size", "Average Diameter Size"))

change_class <- c("Minimum Diameter Size", "Maximum Diameter Size", "Average Diameter Size")

# convert units to inches
for (col in change_class) set(riprap_table_in, j = col, value = set_units(riprap_table_in[[col]], inch))
# Source 1

# riprap table in feet (prior to change in column order)
riprap_table_mm <- copy(riprap_table_in)

# riprap table in feet (prior to change in column order)
riprap_table_ft <- copy(riprap_table_in)

# riprap table in yards (prior to change in column order)
riprap_table_yd <- copy(riprap_table_in)


# drop the units expression
for (col in change_class) set(riprap_table_in, j = col, value = drop_units(riprap_table_in[[col]]))
# Source 1

setnames(riprap_table_in, 2:4, c("Minimum Diameter Size [in]", "Maximum Diameter Size [in]", "Average Diameter Size [in]"))

setcolorder(riprap_table_in, c(1, 2, 4, 3))

save(riprap_table_in, file = "./data/riprap_table_in.rda")




# TDOT Machined riprap Table (millimeters)

# The decision to also include millimeter (mm) was done after reading about an ehancement to the U.S. Department of Transportation (DOT) Federal Highway Administration (FHWA) Hydraulic Toolbox Version 5.1.1 (https://www.fhwa.dot.gov/engineering/hydraulics/software/toolbox404.cfm)

# convert units to millimeter
for (col in change_class) set(riprap_table_mm, j = col, value = set_units(riprap_table_mm[[col]], mm))
# Source 1

# drop the units expression
for (col in change_class) set(riprap_table_mm, j = col, value = drop_units(riprap_table_mm[[col]]))
# Source 1

# round numbers to 2 decimal places
for (col in change_class) set(riprap_table_mm, j = col, value = round_r3(riprap_table_mm[[col]], d = 2))
# Source 1

setnames(riprap_table_mm, 2:4, c("Minimum Diameter Size [mm]", "Maximum Diameter Size [mm]", "Average Diameter Size [mm]"))

setcolorder(riprap_table_mm, c(1, 2, 4, 3))

save(riprap_table_mm, file = "./data/riprap_table_mm.rda")





# TDOT Machined riprap Table (feet)

# convert units to feet
for (col in change_class) set(riprap_table_ft, j = col, value = set_units(riprap_table_ft[[col]], ft))
# Source 1

# drop the units expression
for (col in change_class) set(riprap_table_ft, j = col, value = drop_units(riprap_table_ft[[col]]))
# Source 1

# round numbers to 2 decimal places
for (col in change_class) set(riprap_table_ft, j = col, value = round_r3(riprap_table_ft[[col]], d = 2))
# Source 1

setnames(riprap_table_ft, 2:4, c("Minimum Diameter Size [ft]", "Maximum Diameter Size [ft]", "Average Diameter Size [ft]"))

setcolorder(riprap_table_ft, c(1, 2, 4, 3))

save(riprap_table_ft, file = "./data/riprap_table_ft.rda")





# TDOT Machined riprap Table (yards)

# convert units to yards
for (col in change_class) set(riprap_table_yd, j = col, value = set_units(riprap_table_yd[[col]], yd))
# Source 1

# drop the units expression
for (col in change_class) set(riprap_table_yd, j = col, value = drop_units(riprap_table_yd[[col]]))
# Source 1

# round numbers to 2 decimal places
for (col in change_class) set(riprap_table_yd, j = col, value = round_r3(riprap_table_yd[[col]], d = 2))
# Source 1

setnames(riprap_table_yd, 2:4, c("Minimum Diameter Size [yd]", "Maximum Diameter Size [yd]", "Average Diameter Size [yd]"))

setcolorder(riprap_table_yd, c(1, 2, 4, 3))

save(riprap_table_yd, file = "./data/riprap_table_yd.rda")





# Source

# r - Convert column classes in data.table - Stack Overflow answered by Matt Dowle on Dec 27 2013. See https://stackoverflow.com//questions/7813578/convert-column-classes-in-data-table.




# References

# Reference 1
# https://www.tn.gov/content/tn/tdot/tdot-construction-division/transportation-construction-division-resources/transportation-construction-2015-standard-specifications.html
# Tennessee Department of Transportation (TDOT) 2015 Standard Specifications

# Reference 2
# https://www.tn.gov/content/dam/tn/tdot/construction/old_web_page/TDOT_2015_Spec_Book_FINAL_pdf.pdf
# Tennessee Department of Transportation Standard Specifications for Road and Bridge Construction, January 1, 2015

# Reference 3
# https://cdnsm5-hosted.civiclive.com/UserFiles/Servers/Server_109478/File/Engineering/BMPManual/ES-23.pdf
# City of Knoxville BMP Manual Erosion & Sediment -- ACTIVITY: Riprap ES–23, May 2003
