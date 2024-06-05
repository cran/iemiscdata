## Nuclear & Radiation Accidents and incidents (The Guardian)

library(data.table)

nuclear_accidents_ranked <- fread("./inst/extdata/Nuclear_accidents-and_how_theyre_ranked-Rankings.csv")

save(nuclear_accidents_ranked, file = "./data/nuclear_accidents_ranked.rda")




nuclear_accidents <- fread("./inst/extdata/Nuclear_accidents-and_how_theyre_ranked-Accidents.csv")

# change the column names
setnames(nuclear_accidents, c("Year", "INES level"), c("Date", "INES rating"))

save(nuclear_accidents, file = "./data/nuclear_accidents.rda")

# Data source
# https://www.theguardian.com/news/datablog/2011/mar/14/nuclear-power-plant-accidents-list-rank
# The Guardian: Nuclear power plant accidents: listed and ranked since 1952: How many nuclear power plants have had accidents and incidents? Get the full list and find out how they're ranked
# CSV files obtained from Nuclear_accidents_and_how_theyre_ranked.xlsx (which is not included in inst/extdata)




## Criticality Accidents in USAEC Facilities, 1945-1970 (Trinity Atomic Web Site)

install.load::load_package("rvest", "data.table")

url1 <- "https://www.abomb1.org/accident/crittabl.html"

# Source 1 begin
USAEC_facilities_nuclear_accidents <- read_html(url1)
USAEC_facilities_nuclear_accidents <- html_nodes(USAEC_facilities_nuclear_accidents, "table") %>% html_table(header = TRUE)
# Source 1 end


# combine the list into a single data.table
USAEC_facilities_nuclear_accidents <- rbindlist(USAEC_facilities_nuclear_accidents)


# change the Date column to a date class
change_class1 <- "Date"

for (col in change_class1)

set(USAEC_facilities_nuclear_accidents, j = col, value = anydate(USAEC_facilities_nuclear_accidents[[col]]))


save(USAEC_facilities_nuclear_accidents, file = "./data/USAEC_facilities_nuclear_accidents.rda")

# Data source
# https://www.abomb1.org/accident/crittabl.html
# Trinity Atomic Web Site: Criticality Accidents in USAEC Facilities, 1945-1970 (from "Operational Accidents and Radiation Exposure Experience Within the United States Atomic Energy Commission, 1943-1970," (WASH 1192), U. S. Government Printing Office, Washington, D.C., 1971.)
# Saved as crittabl.html in inst/extdata



## Nuclear and radiation accidents and incidents (Wikipedia)

install.load::load_package("rvest", "anytime", "data.table")

# the Source URL
url2 <- "https://en.wikipedia.org/wiki/Nuclear_and_radiation_accidents_and_incidents"
# Downloaded version is current as of 5 September 2023

# Source 1 begin
nuclear_accidents_wiki <- read_html(url2)
nuclear_accidents_wiki <- html_nodes(nuclear_accidents_wiki, "table.wikitable") %>% html_table(header = TRUE)
# Source 1 end

nuclear_accidents_wiki <- as.data.table(nuclear_accidents_wiki[[1]])


# change the Date column to a date class
change_class2 <- "Date"

for (col in change_class2)

set(nuclear_accidents_wiki, j = col, value = anydate(nuclear_accidents_wiki[[col]]))


# change the column names
setnames(nuclear_accidents_wiki, c("Location of accident", "Description of accident or incident", "Numbers of deaths", "Cost($USmillions2006)", "INES  level[32]"), c("Location", "Description", "Fatalities", "Cost (in millions 2006 US$)", "INES rating"))


save(nuclear_accidents_wiki, file = "./data/nuclear_accidents_wiki.rda")

# Data source
# https://en.wikipedia.org/wiki/Nuclear_and_radiation_accidents_and_incidents
# Nuclear and radiation accidents and incidents: From Wikipedia, the free encyclopedia
# Saved as Nuclear_and_radiation_accidents_and_incidents.html in inst/extdata





## Military nuclear accidents (Wikipedia)

install.load::load_package("rvest", "anytime", "data.table")

# the Source URL
url3 <- "https://en.wikipedia.org/wiki/List_of_military_nuclear_accidents"
# Downloaded version is current as of 3 January 2022

# Source 1 begin
military_nuclear_accidents_wiki <- read_html(url3)
military_nuclear_accidents_wiki <- html_nodes(military_nuclear_accidents_wiki, "table.wikitable") %>% html_table(header = TRUE)
# Source 1 end

# combine the list into a single data.table
military_nuclear_accidents_wiki <- rbindlist(military_nuclear_accidents_wiki)


# change the Date column to a date class
change_class3 <- "Date"

for (col in change_class3)

set(military_nuclear_accidents_wiki, j = col, value = anydate(military_nuclear_accidents_wiki[[col]]))


save(military_nuclear_accidents_wiki, file = "./data/military_nuclear_accidents_wiki.rda")


# Data source
# https://en.wikipedia.org/wiki/List_of_military_nuclear_accidents
# List of military nuclear accidents: From Wikipedia, the free encyclopedia
# Saved as List_of_military_nuclear_accidents.html in inst/extdata






## Civilian nuclear accidents (Wikipedia)

install.load::load_package("rvest", "anytime", "data.table")

# the Source URL
url4 <- "https://en.wikipedia.org/wiki/List_of_civilian_nuclear_accidents"
# Downloaded version is current as of 3 September 2023

# Source 1 begin
civilian_nuclear_accidents_wiki <- read_html(url4)
civilian_nuclear_accidents_wiki <- html_nodes(civilian_nuclear_accidents_wiki, "table.wikitable") %>% html_table(header = TRUE)
# Source 1 end

# combine the list into a single data.table
civilian_nuclear_accidents_wiki <- rbindlist(civilian_nuclear_accidents_wiki)


# change the Date column to a date class
change_class4 <- "Date"

for (col in change_class4)

set(civilian_nuclear_accidents_wiki, j = col, value = anydate(civilian_nuclear_accidents_wiki[[col]]))

save(civilian_nuclear_accidents_wiki, file = "./data/civilian_nuclear_accidents_wiki.rda")


# Data source
# https://en.wikipedia.org/wiki/List_of_civilian_nuclear_accidents
# List of civilian nuclear accidents: From Wikipedia, the free encyclopedia
# Saved as List_of_civilian_nuclear_accidents.html in inst/extdata



## Nuclear power accidents by country (Wikipedia)

install.load::load_package("rvest", "data.table")

# the Source URL
url5 <- "https://en.wikipedia.org/wiki/List_of_nuclear_power_accidents_by_country"
# Downloaded version is current as of 1 September 2023

# Source 1 begin
nuclear_power_accidents_country_wiki <- read_html(url5)
nuclear_power_accidents_country_wiki <- html_nodes(nuclear_power_accidents_country_wiki, "table.wikitable") %>% html_table(header = TRUE)
# Source 1 end


# unlist the tibbles and convert them to data.tables
nuclear_power_accidents_country_wiki1 <- as.data.table(nuclear_power_accidents_country_wiki[[1]])
nuclear_power_accidents_country_wiki2 <- as.data.table(nuclear_power_accidents_country_wiki[[2]])
nuclear_power_accidents_country_wiki3 <- as.data.table(nuclear_power_accidents_country_wiki[[3]])
nuclear_power_accidents_country_wiki4 <- as.data.table(nuclear_power_accidents_country_wiki[[4]])
nuclear_power_accidents_country_wiki5 <- as.data.table(nuclear_power_accidents_country_wiki[[5]])
nuclear_power_accidents_country_wiki6 <- as.data.table(nuclear_power_accidents_country_wiki[[6]])
nuclear_power_accidents_country_wiki7 <- as.data.table(nuclear_power_accidents_country_wiki[[7]])
nuclear_power_accidents_country_wiki8 <- as.data.table(nuclear_power_accidents_country_wiki[[8]])
nuclear_power_accidents_country_wiki9 <- as.data.table(nuclear_power_accidents_country_wiki[[9]])
nuclear_power_accidents_country_wiki10 <- as.data.table(nuclear_power_accidents_country_wiki[[10]])
nuclear_power_accidents_country_wiki11 <- as.data.table(nuclear_power_accidents_country_wiki[[11]])
nuclear_power_accidents_country_wiki12 <- as.data.table(nuclear_power_accidents_country_wiki[[12]])
nuclear_power_accidents_country_wiki13 <- as.data.table(nuclear_power_accidents_country_wiki[[13]])
nuclear_power_accidents_country_wiki14 <- as.data.table(nuclear_power_accidents_country_wiki[[14]])
nuclear_power_accidents_country_wiki15 <- as.data.table(nuclear_power_accidents_country_wiki[[15]])
nuclear_power_accidents_country_wiki16 <- as.data.table(nuclear_power_accidents_country_wiki[[16]])

# add in the Country column
nuclear_power_accidents_country_wiki1[, Country := rep("Belgium", nrow(nuclear_power_accidents_country_wiki1))]
nuclear_power_accidents_country_wiki2[, Country := rep("Canada", nrow(nuclear_power_accidents_country_wiki2))]
nuclear_power_accidents_country_wiki3[, Country := rep("France", nrow(nuclear_power_accidents_country_wiki3))]
nuclear_power_accidents_country_wiki4[, Country := rep("Germany", nrow(nuclear_power_accidents_country_wiki4))]
nuclear_power_accidents_country_wiki5[, Country := rep("India", nrow(nuclear_power_accidents_country_wiki5))]
nuclear_power_accidents_country_wiki6[, Country := rep("Japan", nrow(nuclear_power_accidents_country_wiki6))]
nuclear_power_accidents_country_wiki7[, Country := rep("Pakistan", nrow(nuclear_power_accidents_country_wiki7))]
nuclear_power_accidents_country_wiki8[, Country := rep("Russia", nrow(nuclear_power_accidents_country_wiki8))]
nuclear_power_accidents_country_wiki9[, Country := rep("South Korea", nrow(nuclear_power_accidents_country_wiki9))]
nuclear_power_accidents_country_wiki10[, Country := rep("Serbia", nrow(nuclear_power_accidents_country_wiki10))]
nuclear_power_accidents_country_wiki11[, Country := rep("Switzerland", nrow(nuclear_power_accidents_country_wiki11))]
nuclear_power_accidents_country_wiki12[, Country := rep("Sweden", nrow(nuclear_power_accidents_country_wiki12))]
nuclear_power_accidents_country_wiki13[, Country := rep("Switzerland", nrow(nuclear_power_accidents_country_wiki13))]
nuclear_power_accidents_country_wiki14[, Country := rep("Ukraine", nrow(nuclear_power_accidents_country_wiki14))]
nuclear_power_accidents_country_wiki15[, Country := rep("United Kingdom", nrow(nuclear_power_accidents_country_wiki15))]
nuclear_power_accidents_country_wiki16[, Country := rep("United States", nrow(nuclear_power_accidents_country_wiki16))]


# change the column names
setnames(nuclear_power_accidents_country_wiki1, "Cost  (in millions  2006 US$)", "Cost (in millions 2006 US$)")
setnames(nuclear_power_accidents_country_wiki2, "Cost  (in millions  2006 US$)", "Cost (in millions 2006 US$)")
setnames(nuclear_power_accidents_country_wiki3, "Cost  (in millions  2006 US$)", "Cost (in millions 2006 US$)")
setnames(nuclear_power_accidents_country_wiki4, c("Cost  (in millions  2006 US$ million)", "INES"), c("Cost (in millions 2006 US$)", "INES rating"))
setnames(nuclear_power_accidents_country_wiki5, "Cost  (in millions  2006 US$)", "Cost (in millions 2006 US$)")
setnames(nuclear_power_accidents_country_wiki6, "Cost  (in millions  2006 US$)", "Cost (in millions 2006 US$)")
setnames(nuclear_power_accidents_country_wiki7, "Cost  (in millions  2006 US$)", "Cost (in millions 2006 US$)")
setnames(nuclear_power_accidents_country_wiki8, c("Cost  (in millions  2006 US$)", "INES"), c("Cost (in millions 2006 US$)", "INES rating"))
setnames(nuclear_power_accidents_country_wiki9, "Cost  (in millions  2006 US$)", "Cost (in millions 2006 US$)")
setnames(nuclear_power_accidents_country_wiki10, "INES", "INES rating")
setnames(nuclear_power_accidents_country_wiki11, "INES", "INES rating")
setnames(nuclear_power_accidents_country_wiki12, "INES", "INES rating")
setnames(nuclear_power_accidents_country_wiki13, c("Cost 130,000,000 Million Dollars", "INES"), c("Cost 130,000,000 million dollars", "INES rating"))
setnames(nuclear_power_accidents_country_wiki14, c("Cost  (in millions  2006 US$)", "INES"), c("Cost (in millions 2006 US$)", "INES rating"))
setnames(nuclear_power_accidents_country_wiki15, "Cost(in millions2006 US$)", "Cost (in millions 2006 US$)")
setnames(nuclear_power_accidents_country_wiki16, c("Cost  (in millions  2006 US$)", "INES"), c("Cost (in millions 2006 US$)", "INES rating"))

nuclear_power_accidents_country_wiki_list <- list(nuclear_power_accidents_country_wiki1, nuclear_power_accidents_country_wiki2, nuclear_power_accidents_country_wiki3, nuclear_power_accidents_country_wiki4, nuclear_power_accidents_country_wiki5, nuclear_power_accidents_country_wiki6, nuclear_power_accidents_country_wiki7, nuclear_power_accidents_country_wiki8, nuclear_power_accidents_country_wiki9, nuclear_power_accidents_country_wiki10, nuclear_power_accidents_country_wiki11, nuclear_power_accidents_country_wiki12, nuclear_power_accidents_country_wiki13, nuclear_power_accidents_country_wiki14, nuclear_power_accidents_country_wiki15, nuclear_power_accidents_country_wiki16)


# combine the list into a single data.table
nuclear_power_accidents_country_wiki <- rbindlist(nuclear_power_accidents_country_wiki_list, fill = TRUE)


# change the column order  
setcolorder(nuclear_power_accidents_country_wiki, c("Date", "Country", "Location", "Description", "INES rating", "Fatalities", "Fatalities 180", "Victims", "Cost (in millions 2006 US$)", "Cost 130,000,000 million dollars", "Cost"))

# set the key to Country so that the separate Switzerland rows will be in the same Country section
setkey(nuclear_power_accidents_country_wiki, Country)

save(nuclear_power_accidents_country_wiki, file = "./data/nuclear_power_accidents_country_wiki.rda")


# Data source
# https://en.wikipedia.org/wiki/List_of_nuclear_power_accidents_by_country
# List of nuclear power accidents by country: From Wikipedia, the free encyclopedia
# Saved as List_of_nuclear_power_accidents_by_country.html in inst/extdata







# Source 1
# Wikipedia Data Scraping with R: rvest in Action: Scraping list of people on bank notes for exploratory data analysis using rvest functions By Korkrid Kyle Akepanidtaworn, Jul 21, 2018. https://medium.com/@kyleake/wikipedia-data-scraping-with-r-rvest-in-action-3c419db9af2d
