install.load::load_package("data.table", "stringi")

## TABLE 3. Clear and cloudy sky radiative forcing (W m-2) and the contribution of individual absorbers to this total. Cloudy sky results are in parentheses

# Greenhouse gases with cloudy sky

greenhouse_gas1 <- fread("./inst/extdata/greenhouse_gas1.csv")
greenhouse_gas1[, c("Individual contribution keep", "Individual contribution - Cloudy sky") := tstrsplit(c(`Individual contribution`), "(", fixed = TRUE)]
greenhouse_gas1[, c("Combined with overlap effects keep", "Combined with overlap effects - Cloudy sky") := tstrsplit(c(`Combined with overlap effects`), "(", fixed = TRUE)]

# remove parenthesis
change_class1 <- c("Individual contribution - Cloudy sky", "Combined with overlap effects - Cloudy sky")

for (col in change_class1)
set(greenhouse_gas1, j = col, value = stri_replace_all_fixed(greenhouse_gas1[[col]], ")", ""))


# remove blank spaces
change_class2 <- colnames(greenhouse_gas1)

for (col in change_class2)
set(greenhouse_gas1, j = col, value = stri_trim_both(greenhouse_gas1[[col]], pattern = "\\P{Wspace}"))



# check for & replace non-ASCII strings

if(any(unlist(lapply(greenhouse_gas1, stri_enc_isascii)) == FALSE)) { # Source 1

check_ascii <- names(greenhouse_gas1)

# Source 2 begin
for (col in check_ascii) {

idx1 <- which(!stri_enc_isascii(greenhouse_gas1[[col]]))

set(greenhouse_gas1, i = idx1, j = col, value = stri_escape_unicode(greenhouse_gas1[[col]][idx1]))
}
# Source 2 end
}




greenhouse_gas1_use <- copy(greenhouse_gas1)

greenhouse_gas1_use[, c("Individual contribution", "Combined with overlap effects") := NULL]

setcolorder(greenhouse_gas1_use, c(1, 3:4, 5:6, 2))

setnames(greenhouse_gas1_use, c("Individual contribution keep", "Individual contribution - Cloudy sky","Combined with overlap effects keep", "Combined with overlap effects - Cloudy sky", "Percent contribution clear sky"), c("Individual contribution (W m^-2)", "Individual contribution - Cloudy sky (W m^-2)", "Combined with overlap effects (W m^-2)", "Combined with overlap effects - Cloudy sky (W m^-2)", "Percent contribution clear sky (W m^-2)"))


# change columns to numeric
change_class3 <- c("Individual contribution (W m^-2)", "Individual contribution - Cloudy sky (W m^-2)", "Combined with overlap effects (W m^-2)", "Combined with overlap effects - Cloudy sky (W m^-2)", "Percent contribution clear sky (W m^-2)")

for (col in change_class3)
set(greenhouse_gas1_use, j = col, value = as.integer(greenhouse_gas1_use[[col]]))


# copy the data.table
greenhouse_gases_cloudy_sky <- copy(greenhouse_gas1_use)


save(greenhouse_gases_cloudy_sky, file = "./data/greenhouse_gases_cloudy_sky.rda")




# Greenhouse Gases -- Percent Contribution to Total Greenhouse Effect (Wikipedia)

greenhouse_gas2 <- fread("./inst/extdata/greenhouse_gas2.csv")

# copy the data.table
greenhouse_gases_cloudy_wikipedia <- copy(greenhouse_gas2)


save(greenhouse_gases_cloudy_wikipedia, file = "./data/greenhouse_gases_cloudy_wikipedia.rda")



# Greenhouse Gases -- Percent Contribution to Total Greenhouse Effect Notes (Wikipedia)

greenhouse_gas2_notes <- fread("./inst/extdata/greenhouse_gas2_notes.csv")

# copy the data.table
greenhouse_gases_cloudy_notes_wikipedia <- copy(greenhouse_gas2_notes)


save(greenhouse_gases_cloudy_notes_wikipedia, file = "./data/greenhouse_gases_cloudy_notes_wikipedia.rda")






# Greenhouse Gases -- Percent Contribution to Total Greenhouse Effect (NASA)

greenhouse_gas3 <- data.table(Gas_Name = c("Carbon dioxide", "Water vapor", "Clouds", "Remaining [Aerosols, minor greenhouse gases (ex., methane gas)]"), Gas_Formula = c("CO2", "H2O", NA_character_, NA_character_), `Greenhouse Gas Contributions (approximate percent values)` = c(20, 50, 25, 100 - sum(c(20, 50, 25))))


# copy the data.table
greenhouse_gases_contributions <- copy(greenhouse_gas3)


save(greenhouse_gases_contributions, file = "./data/greenhouse_gases_contributions.rda")





# References

# Reference 1
# https://web.archive.org/web/20060330013311/http://www.atmo.arizona.edu/students/courselinks/spring04/atmo451b/pdf/RadiationBudget.pdf | Earth's Annual Global Mean Energy Budget, J. T. Kiehl and Kevin E. Trenberth, Bulletin of the American Meteorological Society, Vol. 78, No. 2, February 1997, pages 197-208
# TABLE 3. Clear and cloudy sky radiative forcing (W m-2) and the contribution of individual absorbers to this total. Cloudy sky results are in parentheses. [Reference table]
# Recovered with the Internet Archive: Wayback Machine

# Reference 2
# https://web.archive.org/web/20240328160004/https://earthobservatory.nasa.gov/features/CarbonCycle/page5.php | Effects of Changing the Carbon Cycle, Published Jun 16, 2011, The Earth Observatory is part of the EOS Project Science Office at NASA Goddard Space Flight Center
# saved as TheCarbonCycle.html in inst/extdata
# [Recovered with the Internet Archive: Wayback Machine]

# Because scientists know which wavelengths of energy each greenhouse gas absorbs, and the concentration of the gases in the atmosphere, they can calculate how much each gas contributes to warming the planet. Carbon dioxide causes about 20 percent of Earth's greenhouse effect; water vapor accounts for about 50 percent; and clouds account for 25 percent. The rest is caused by small particles (aerosols) and minor greenhouse gases like methane.

# Reference 3
# Wikimedia Foundation, Inc. Wikipedia, 25 August 2023, Greenhouse gas. https://en.wikipedia.org/wiki/Greenhouse_gas
# saved as Greenhouse_gas.html in inst/extdata




# Sources

# Source 1
# https://stackoverflow.com/questions/29043932/how-to-handle-example-data-in-r-package-that-has-utf-8-marked-strings
# twitter - How to handle example data in R Package that has UTF-8 marked strings - Stack Overflow

# Source 2
# https://stackoverflow.com/questions/50361168/r-data-table-set-add-number-to-certain-j-values-only | r - data.table set add number to certain j values only - Stack Overflow; answered by chinsoon12 on May 16 2018.
