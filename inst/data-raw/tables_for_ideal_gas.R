# Period Table of the Elements (PubChem)

library(data.table)

# read in the CSV file
elements_pubchem <- fread("./inst/extdata/PubChemElements_all.csv", colClasses = "character")

# set all of the column names
setnames(elements_pubchem, c("Atomic Number (Z)", "Formula", "Name", "Atomic Mass (u)", "CPK Hex Color", "Electron Configuration", "Electronegativity", "Atomic Radius (pm)", "Ionization Energy (eV)", "Electron Affinity (eV)", "Oxidation States", "Standard State", "Melting Point (K)", "Boiling Point (K)", "Density (g/cm^3)", "Group Name", "Year Discovered"))

# change the column order
setcolorder(elements_pubchem, c("Name", "Atomic Number (Z)", "Formula", "Atomic Mass (u)", "CPK Hex Color", "Electron Configuration", "Electronegativity", "Atomic Radius (pm)", "Ionization Energy (eV)", "Electron Affinity (eV)", "Oxidation States", "Standard State", "Melting Point (K)", "Boiling Point (K)", "Density (g/cm^3)", "Group Name", "Year Discovered"))


# character to integer

colsts <- "Atomic Number (Z)"

for (col in colsts) {

set(elements_pubchem, j = col, value = as.integer(elements_pubchem[[col]]))

}


# character to numeric

colssr <- c("Atomic Mass (u)", "Electronegativity", "Atomic Radius (pm)", "Ionization Energy (eV)", "Electron Affinity (eV)", "Melting Point (K)", "Boiling Point (K)", "Density (g/cm^3)")

for (col in colssr) {

set(elements_pubchem, j = col, value = as.numeric(elements_pubchem[[col]]))

}


save(elements_pubchem, file = "./data/elements_pubchem.rda")



# Data source
# PubChem [Internet]. Bethesda (MD): National Library of Medicine (US), National Center for Biotechnology Information; 2004-. Periodic Table of Elements; [cited 2023 May 12]. Available from: https://pubchem.ncbi.nlm.nih.gov/periodic-table/





# Period Table of the Elements (Wikipedia)

install.load::load_package("rvest", "data.table", "stringi", "mgsub")


# the Source URL
url <- "https://en.wikipedia.org/wiki/List_of_chemical_elements"
# Downloaded version is current as of 3 January 2022
# saved as Chemical_elements.html in inst/extdata

# Source 1 begin
elements_wiki <- read_html(url)
elements_wiki <- html_nodes(elements_wiki, "table.wikitable") %>% html_table(header = FALSE)
# Source 1 end

# combine the list into a single data.table
elements_wiki <- rbindlist(elements_wiki)

# remove the numbered rows
elements_wiki <- elements_wiki[-c(1:4), ]


# set all of the column names
setnames(elements_wiki, c("Atomic Number (Z)", "Formula", "Name", "Origin of name", "Group", "Period", "Group Block", "Standard Atomic weight (Da)", "Density (g/cm^3)", "Melting Point (K)", "Boiling Point (K)", "Specific Heat Capacity (J/g K)", "Electronegativity", "Abundance in Earth's crust (mg/kg)", "Origin", "Standard State at Room Temperature"))

setcolorder(elements_wiki, c("Name", "Atomic Number (Z)", "Formula", "Standard Atomic weight (Da)", "Origin of name", "Group", "Group Block", "Period", "Density (g/cm^3)", "Melting Point (K)", "Boiling Point (K)", "Specific Heat Capacity (J/g K)", "Electronegativity", "Abundance in Earth's crust (mg/kg)", "Origin", "Standard State at Room Temperature"))



# Replace – with -
cols <- names(elements_wiki)

for (col in cols) {

idx <- which(stri_detect_fixed(elements_wiki[[col]], "–"))

set(elements_wiki, i = idx, j = col, value = mgsub(elements_wiki[[col]][idx], "–", "-"))

}


# Replace - with "" if no other characters present

for (col in cols) {

idx <- which(stri_detect_regex(elements_wiki[[col]], "^-$"))

set(elements_wiki, i = idx, j = col, value = mgsub(elements_wiki[[col]][idx], "-", ""))

}


# character to integer

colss <- c("Atomic Number (Z)", "Period")

for (col in colss) {

set(elements_wiki, j = col, value = as.integer(elements_wiki[[col]]))

}


# character to numeric

colsst <- "Specific Heat Capacity (J/g K)"

for (col in colsst) {

set(elements_wiki, j = col, value = as.numeric(elements_wiki[[col]]))

}


# to capitalize word

coldsm <- "Standard State at Room Temperature"

for (col in coldsm) {

set(elements_wiki, j = col, value = stri_trans_totitle(elements_wiki[[col]]))

}


save(elements_wiki, file = "./data/elements_wiki.rda")



# Data source
# Wikimedia Foundation, Inc. Wikipedia, 18 September 2023, List of chemical elements. https://en.wikipedia.org/wiki/List_of_chemical_elements


# Source 1
# Wikipedia Data Scraping with R: rvest in Action: Scraping list of people on bank notes for exploratory data analysis using rvest functions By Korkrid Kyle Akepanidtaworn, Jul 21, 2018. https://medium.com/@kyleake/wikipedia-data-scraping-with-r-rvest-in-action-3c419db9af2d




# Period Table of the Elements (PubChem & Wikipedia)

# set the key to Atomic Number (Z)
setkey(elements_pubchem, `Atomic Number (Z)`)

# set the key to Atomic Number (Z)
setkey(elements_wiki, `Atomic Number (Z)`)

# join the data.tabless
elements <- elements_wiki[elements_pubchem, on="Atomic Number (Z)"]


# replace duplicate Name values with ""
elements$"i.Name" <- fcase(
elements$"Name" == elements$"i.Name", "",
elements$"Name" != elements$"i.Name", elements$"i.Name"
)


# replace NA values with "" in i.Name
elements$"i.Name" <- fcase(
is.na(elements$"Name"), "",
!is.na(elements$"Name"), elements$"i.Name"
)

# replace NA values with "" in Name
elements$"Name" <- fcase(
is.na(elements$"Name"), "",
!is.na(elements$"Name"), elements$"Name"
)

elements[, NewName := paste0(`Name`, `i.Name`)]

elements[, c("Name", "i.Name") := NULL]



# replace duplicate Formula values with ""
elements$"i.Formula" <- fcase(
elements$"Formula" == elements$"i.Formula", "",
elements$"Formula" != elements$"i.Formula", elements$"i.Formula"
)


# replace NA values with "" in i.Formula
elements$"i.Formula" <- fcase(
is.na(elements$"Formula"), "",
!is.na(elements$"Formula"), elements$"i.Formula"
)

# replace NA values with "" in Formula
elements$"Formula" <- fcase(
is.na(elements$"Formula"), "",
!is.na(elements$"Formula"), elements$"Formula"
)


elements[, NewFormula := paste0(`Formula`, `i.Formula`)]


elements[, c("Formula", "i.Formula") := NULL]


# change the column names
setnames(elements, c("NewFormula", "NewName", "i.Melting Point (K)", "i.Boiling Point (K)", "i.Density (g/cm^3)", "i.Electronegativity", "Standard State at Room Temperature"), c("Formula", "Name", "Melting Point (K) {PubChem}", "Boiling Point (K) {PubChem}", "Density (g/cm^3) {PubChem}", "Electronegativity {PubChem}", "Standard State at Room Temperature (Wikipedia)"))

setcolorder(elements, c("Name", "Atomic Number (Z)", "Formula", "Standard Atomic weight (Da)", "Atomic Mass (u)", "Atomic Radius (pm)", "Electron Configuration", "Electronegativity", "Electronegativity {PubChem}", "Electron Affinity (eV)", "Ionization Energy (eV)", "Oxidation States", "Period", "Group", "Group Name", "Group Block", "Standard State at Room Temperature (Wikipedia)", "Standard State", "Density (g/cm^3)", "Density (g/cm^3) {PubChem}", "Melting Point (K)", "Melting Point (K) {PubChem}", "Boiling Point (K)", "Boiling Point (K) {PubChem}", "Specific Heat Capacity (J/g K)", "Abundance in Earth's crust (mg/kg)", "CPK Hex Color", "Origin", "Origin of name", "Year Discovered"))

save(elements, file = "./data/elements.rda")






# Gases at Standard Temperature and Pressure (STP) -- Wikipedia

install.load::load_package("rvest", "data.table", "stringi", "mgsub")


# the Source URL
url <- "https://en.wikipedia.org/wiki/List_of_gases"
# Downloaded version is current as of 26 August 2023

# Source 1 begin
gases <- read_html(url)
gases <- html_nodes(gases, "table.wikitable") %>% html_table(header = FALSE)
# Source 1 end

# combine the list into a single data.table
gases <- rbindlist(gases)

# set the first row as the column names
setnames(gases, names(gases), as.character(gases[1, ]))

# remove the 1st row
gases <- gases[-1, ]


# Replace − with -
cols <- names(gases)

for (col in cols) {

idx <- which(stri_detect_fixed(gases[[col]], "−"))

set(gases, i = idx, j = col, value = mgsub(gases[[col]][idx], "−", "-"))

}



# Replace N/A with NA
cols <- names(gases)

for (col in cols) {

idx <- which(stri_detect_fixed(gases[[col]], "N/A"))

set(gases, i = idx, j = col, value = mgsub(gases[[col]][idx], "N/A", NA_character_))

}



# character to numeric

colsstr <- "Molecular weight"

for (col in colsstr) {

set(gases, j = col, value = as.numeric(gases[[col]]))

}



# change CAS No to CAS
setnames(gases, "CAS No", "CAS")


# copy gases to remove the brackets and make a plain table
gases_plain <- copy(gases)

# remove all parentheses and square brackets, including the interior text from the columns in columns_choose
columns_choose <- "Name"

for (col in columns_choose) set(gases_plain, j = col, value = qdap::bracketX(gases_plain[[col]]))


save(gases_plain, file = "./data/gases_plain.rda")

save(gases, file = "./data/gases.rda")




# Data source
# Wikimedia Foundation, Inc. Wikipedia, 26 August 2023, List of gases. https://en.wikipedia.org/wiki/List_of_gases


# Source 1
# Wikipedia Data Scraping with R: rvest in Action: Scraping list of people on bank notes for exploratory data analysis using rvest functions By Korkrid Kyle Akepanidtaworn, Jul 21, 2018. https://medium.com/@kyleake/wikipedia-data-scraping-with-r-rvest-in-action-3c419db9af2d





# Chemical Element and Chemical Compound Gases

install.load::load_package("data.table", "stringi", "snakecase")

# Data Source 1
# Gaseous composition of dry air

# read in the CSV file
dry_air <- fread("./inst/extdata/air.csv", colClasses = "character")

# change the column names
setnames(dry_air, c("Constituent", "Chemical symbol"), c("Name", "Formula"))

# remove the text, remove the white space, make numeric
dry_air$"Mole percent" <- as.numeric(stri_trim_both(stri_replace_all_regex(dry_air$"Mole percent", "[A-Za-z]", ""), pattern = "\\P{Wspace}"))


# Change the Names to sentence case
coll <- "Name"

for (col in coll)

set(dry_air, j = col, value = to_sentence_case(dry_air[[col]]))


save(dry_air, file = "./data/dry_air.rda")




# Data Source 2
# Gaseous Elements and Compounds
# Common Gases

# read in the CSV file
common_gases <- fread("./inst/extdata/common-gases.csv", sep = ",")


# change the column names
setnames(common_gases, c("Element Symbol", "Element Name", "Compound Symbol", "Compound Name"), c("Element_Formula", "Element_Name", "Compound_Formula", "Compound_Name"))


# trim the white space
Colnus <- names(common_gases)

for (col in Colnus)

set(common_gases, j = col, value = stri_trim_both(common_gases[[col]], pattern = "\\P{Wspace}"))


# split the strings
common_gases[, c("Element_Formula", "Element_Name") := tstrsplit(Element_Formula, " ", fixed = TRUE)][]

# split the strings
common_gases[, c("Compound_Formula", "Compound_Name") := tstrsplit(Compound_Formula, "(", fixed = TRUE)][]


# remove the parentheses
# remove the white space
for (col in Colnus) {

set(common_gases, j = col, value = stri_replace_all_fixed(common_gases[[col]], "(", ""))
set(common_gases, j = col, value = stri_replace_all_fixed(common_gases[[col]], ")", ""))
set(common_gases, j = col, value = stri_trim_both(common_gases[[col]], pattern = "\\P{Wspace}"))
}


coll <- c("Element_Name", "Compound_Name")

# Change the Names to sentence case
for (col in coll)

set(common_gases, j = col, value = to_sentence_case(common_gases[[col]]))


save(common_gases, file = "./data/common_gases.rda")




# Data Source 2
# Gaseous Elements and Compounds
# Common Gases Simplified

# read in the CSV file
common_gases_simp <- fread("./inst/extdata/common-gases-simplified.csv")


# trim the white space
Colnuss <- names(common_gases_simp)

for (col in Colnuss)

set(common_gases_simp, j = col, value = stri_trim_both(common_gases_simp[[col]], pattern = "\\P{Wspace}"))


common_gases_simp[, c("Symbol", "Name") := tstrsplit(Symbol, "(", fixed = TRUE)][]


# remove the parentheses
# remove the white space
for (col in Colnuss) {

set(common_gases_simp, j = col, value = stri_replace_all_fixed(common_gases_simp[[col]], ")", ""))
set(common_gases_simp, j = col, value = stri_trim_both(common_gases_simp[[col]], pattern = "\\P{Wspace}"))
}


# change the column name
setnames(common_gases_simp, "Symbol", "Formula")

# change the order of the columns
setcolorder(common_gases_simp, c("Name", "Formula"))


colls <- "Name"

# Change the Names to sentence case
for (col in colls)

set(common_gases_simp, j = col, value = to_sentence_case(common_gases_simp[[col]]))


save(common_gases_simp, file = "./data/common_gases_simp.rda")






# combine Periodic Table names and chemical formulas with dry_air gas names and chemical symbols, common gas names and chemical symbols, and gas names and chemical symbols
elements_gas <- elements[, c("Name", "Formula", "Standard State")]

setnames(elements_gas, "Standard State", "State")

elements_gas <- elements_gas[State == "Gas"]

gases_table1 <- dry_air[gases_plain, on="Name"]


# replace duplicate Formula values with ""
gases_table1$"Formula" <- fcase(
gases_table1$"i.Formula" == gases_table1$"Formula", "",
gases_table1$"i.Formula" != gases_table1$"Formula", gases_table1$"Formula"
)


# replace NA values with "" in i.Formula
gases_table1$"Formula" <- fcase(
is.na(gases_table1$"i.Formula"), "",
!is.na(gases_table1$"i.Formula"), gases_table1$"Formula"
)

# replace NA values with "" in Formula
gases_table1$"Formula" <- fcase(
is.na(gases_table1$"Formula"), "",
!is.na(gases_table1$"Formula"), gases_table1$"Formula"
)


gases_table1[, NewFormula := paste0(`Formula`, `i.Formula`)]


gases_table1[, c("Formula", "i.Formula") := NULL]

setnames(gases_table1, "NewFormula", "Formula")



gases_table2 <- common_gases_simp[gases_table1, on="Name"]


# replace duplicate Formula values with ""
gases_table2$"Formula" <- fcase(
gases_table2$"i.Formula" == gases_table2$"Formula", "",
gases_table2$"i.Formula" != gases_table2$"Formula", gases_table2$"Formula"
)


# replace NA values with "" in i.Formula
gases_table2$"Formula" <- fcase(
is.na(gases_table2$"i.Formula"), "",
!is.na(gases_table2$"i.Formula"), gases_table2$"Formula"
)

# replace NA values with "" in Formula
gases_table2$"Formula" <- fcase(
is.na(gases_table2$"Formula"), "",
!is.na(gases_table2$"Formula"), gases_table2$"Formula"
)


gases_table2[, NewFormula := paste0(`Formula`, `i.Formula`)]


gases_table2[, c("Formula", "i.Formula") := NULL]

setnames(gases_table2, "NewFormula", "Formula")




gases_table3 <- elements_gas[gases_table2, on="Name"]


# replace duplicate Formula values with ""
gases_table3$"Formula" <- fcase(
gases_table3$"i.Formula" == gases_table3$"Formula", "",
gases_table3$"i.Formula" != gases_table3$"Formula", gases_table3$"Formula"
)


# replace NA values with "" in i.Formula
gases_table3$"Formula" <- fcase(
is.na(gases_table3$"i.Formula"), "",
!is.na(gases_table3$"i.Formula"), gases_table3$"Formula"
)

# replace NA values with "" in Formula
gases_table3$"Formula" <- fcase(
is.na(gases_table3$"Formula"), "",
!is.na(gases_table3$"Formula"), gases_table3$"Formula"
)


gases_table3[, c("Formula", "State", "Mole percent", "Boiling pt (°C)", "Melting pt (°C)") := NULL]

setnames(gases_table3, "i.Formula", "Formula")

setcolorder(gases_table3, c("Name", "Formula", "CAS", "Molecular weight"))

gases_table <- unique(gases_table3)

setorder(gases_table, Name)

gases_table <- gases_table[-which(duplicated(gases_table$Name))]

save(gases_table, file = "./data/gases_table.rda")




# Data Sources

# Data Source 1
# https://web.archive.org/web/20161222023409/https://eesc.columbia.edu/courses/ees/slides/climate/table_1.html
# Gaseous composition of dry air.

# Original Source:
# Mackenzie, F.T. and J.A. Mackenzie (1995) Our changing planet. Prentice-Hall, Upper Saddle River, NJ, p 288-307. (After Warneck, 1988; Anderson, 1989; Wayne, 1991.)

# Data Source 2
# https://chem.libretexts.org/LibreTexts/Howard_University/General_Chemistry%3A_An_Atoms_First_Approach/Unit_4%3A__Thermochemistry/Chapter_10%3A_Gases/Chapter_10.1%3A_Gaseous_Elements_and_Compounds | Chemistry LibreTexts: Chapter 10.1: Gaseous Elements and Compounds
