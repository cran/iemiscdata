## United States EPA Radiation Readings from 1 March 2011 to 22 April 2011 (after the Radiation leaks from the nuclear power plants in Japan)

install.load::load_package("data.table", "lubridate")

raddata_usa <- fread("./inst/extdata/Radiation_Data_from_EPA_RadNet_Radiation_Alert_Network_03_01_2011_-_04_22_2011.csv")
# Data Source 1

# change the columns to POSIX dates
change_class1 <- c("Collection Start Date", "Collection Ending Date", "Result Date", "Run Start")

for (col in change_class1)
set(raddata_usa, j = col, value = dmy(raddata_usa[[col]]))


# copy the data.table
raddata_usa_territories_Fukushima_2011 <- copy(raddata_usa)


save(raddata_usa_territories_Fukushima_2011, file = "./data/raddata_usa_territories_Fukushima_2011.rda")






## US EPA Envirofacts RadNet (Radiation in the US) [after the Radiation leaks from the nuclear power plants in Japan]

install.load::load_package("data.table", "lubridate", "snakecase", "stringi")

raddata_US <- fread("./inst/extdata/Radiation_in_the_USA.csv")
# Data Source 2

# change the column names
setnames(raddata_US, to_title_case(names(raddata_US)))

setnames(raddata_US, "Analyte Id", "Analyte ID")


# split at the \n to create a new column
raddata_US[, c("Location 1", "Location 1 (Latitude)") := tstrsplit(`Location 1`, c("\n"), fixed = TRUE)][]

# split at the , to create a new column
raddata_US[, c("Location 1 (Latitude)", "Location 1 (Longitude)") := tstrsplit(`Location 1 (Latitude)`, c(","), fixed = TRUE)][]

# split at the , to create a new column
raddata_US[, c("Location 1 (City)", "Location 1 (State)") := tstrsplit(`Location 1`, c(","), fixed = TRUE)][]


# Change the Names to sentence case
coll <- "Location 1 (City)"

for (col in coll)

set(raddata_US, j = col, value = to_sentence_case(raddata_US[[col]]))



change_class2 <- c("Location 1 (Latitude)", "Location 1 (Longitude)")

# remove the parentheses
# remove the white space
for (col in change_class2) {

set(raddata_US, j = col, value = stri_replace_all_fixed(raddata_US[[col]], ")", ""))
set(raddata_US, j = col, value = stri_replace_all_fixed(raddata_US[[col]], "(", ""))
set(raddata_US, j = col, value = stri_trim_both(raddata_US[[col]], pattern = "\\P{Wspace}"))
set(raddata_US, j = col, value = as.numeric(raddata_US[[col]]))
}




# change the columns to POSIX dates
change_class3 <- c("Collect End", "Result Date")

for (col in change_class3)
set(raddata_US, j = col, value = dmy(raddata_US[[col]]))


# remove the Location 1 column
raddata_US[, "Location 1" := NULL]


# set the column order
setcolorder(raddata_US, c("Analyte ID", "Analyte Name", "Result Amount", "Result Unit", "Collect End", "Result Date", "Mat Desc", "Samp Size", "Samp Unit", "Location 1 (City)", "Location 1 (State)", "Location 1 (Latitude)", "Location 1 (Longitude)"))


# copy the data.table
raddata_US_Fukushima_2011 <- copy(raddata_US)


save(raddata_US_Fukushima_2011, file = "./data/raddata_US_Fukushima_2011.rda")





## US DOE/NNSA Response to 2011 Fukushima Incident: Instrument Samples (InSitu Measurements)

library(data.table)

Fukushima_2011_FieldSampleInstrumentResults <- fread("./inst/extdata/FieldSampleInstrumentResults.csv")
# Data Source 3


change_class3 <- "Collection Date"

for (col in change_class3)
set(Fukushima_2011_FieldSampleInstrumentResults, j = col, value = lubridate::parse_date_time(Fukushima_2011_FieldSampleInstrumentResults[[col]], "%m/%d/%Y %I:%M:%S %p"))

save(Fukushima_2011_FieldSampleInstrumentResults, file = "./data/Fukushima_2011_FieldSampleInstrumentResults.rda")



Fukushima_2011_FieldSampleInstrumentResults_Metadata <- jsonlite::fromJSON("./inst/extdata/FieldSampleInstrumentResults_Metadata.json")

save(Fukushima_2011_FieldSampleInstrumentResults_Metadata, file = "./data/Fukushima_2011_FieldSampleInstrumentResults_Metadata.rda")







## US DOE/NNSA and DoD Response to 2011 Fukushima Incident: Radiological Air Samples

library(data.table)

Fukushima_2011_FieldSampleAirResults_2 <- fread("./inst/extdata/FieldSampleAirResults_2.csv")
# Data Source 4


change_class4 <- "Collection Date"

for (col in change_class4)
set(Fukushima_2011_FieldSampleAirResults_2, j = col, value = lubridate::parse_date_time(Fukushima_2011_FieldSampleAirResults_2[[col]], "%m/%d/%Y %I:%M:%S %p"))

save(Fukushima_2011_FieldSampleAirResults_2, file = "./data/Fukushima_2011_FieldSampleAirResults_2.rda")



Fukushima_2011_FieldSampleAirResults_2_Metadata <- jsonlite::fromJSON("./inst/extdata/FieldSampleAirResults_2_Metadata.json")

save(Fukushima_2011_FieldSampleAirResults_2_Metadata, file = "./data/Fukushima_2011_FieldSampleAirResults_2_Metadata.rda")






## US DOE/NNSA and DoD Response to 2011 Fukushima Incident: Field Team Radiological Measurements

library(data.table)

Fukushima_2011_FieldMeasurements_5 <- fread("./inst/extdata/FieldMeasurements_5.csv")
# Data Source 5


change_class5 <- "Measurement Date"

for (col in change_class5)
set(Fukushima_2011_FieldMeasurements_5, j = col, value = lubridate::parse_date_time(Fukushima_2011_FieldMeasurements_5[[col]], "%m/%d/%y %H:%M"))

save(Fukushima_2011_FieldMeasurements_5, file = "./data/Fukushima_2011_FieldMeasurements_5.rda")



Fukushima_2011_FieldMeasurements_5_Metadata <- jsonlite::fromJSON("./inst/extdata/FieldMeasurements_5_Metadata.json")

save(Fukushima_2011_FieldMeasurements_5_Metadata, file = "./data/Fukushima_2011_FieldMeasurements_5_Metadata.rda")









## US DOE/NNSA and DoD Response to 2011 Fukushima Incident: Radiological Soil Samples

library(data.table)

Fukushima_2011_FieldSampleSoilResults_2 <- fread("./inst/extdata/FieldSampleSoilResults_2.csv")
# Data Source 6


change_class6 <- "Collection Date"

for (col in change_class6)
set(Fukushima_2011_FieldSampleSoilResults_2, j = col, value = lubridate::parse_date_time(Fukushima_2011_FieldSampleSoilResults_2[[col]], "%m/%d/%Y %I:%M:%S %p"))

save(Fukushima_2011_FieldSampleSoilResults_2, file = "./data/Fukushima_2011_FieldSampleSoilResults_2.rda")




Fukushima_2011_FieldSampleSoilResults_2_Metadata <- jsonlite::fromJSON("./inst/extdata/FieldSampleSoilResults_2_Metadata.json")

save(Fukushima_2011_FieldSampleSoilResults_2_Metadata, file = "./data/Fukushima_2011_FieldSampleSoilResults_2_Metadata.rda")












# Data Source 1
# https://web.archive.org/web/20110820090335/http://opendata.socrata.com:80/Government/Radiation-Data-from-EPA-RadNet-Radiation-Alert-Net/sdpb-7iqi | Radiation Data from EPA RadNet Radiation Alert Network 03/01/2011 - 04/22/2011
# Based on Radiation Data from EPA RadNet Radiation Alert Network
# Medium : Equal to , Air-Charcoal, Air-Filter, Drinking Water, Pasteurized Milk, Precipitation, Surface Water  [Recovered with the Internet Archive: Wayback Machine]

# Data Source 2
# https://web.archive.org/web/20111114010540/https://opendata.socrata.com/Education/Radiation-in-the-USA/rwxv-anw8 | EPA Envirofacts RadNet Customized Search All RADIATION DATA in the USA: All data returning above zero from march 11 2011. Until the EPA halted public reporting. Doh!  [Recovered with the Internet Archive: Wayback Machine]

# Data Source 3
# https://web.archive.org/web/20160630225626/https://catalog.data.gov/dataset/us-doe-nnsa-response-to-2011-fukushima-incident-instrument-samples-insitu-measurements-09ee4
# US DOE/NNSA Response to 2011 Fukushima Incident: Instrument Samples (InSitu Measurements)  [Recovered with the Internet Archive: Wayback Machine]

# Data Source 4
# https://web.archive.org/web/20201108073914/https://catalog.data.gov/dataset/us-doe-nnsa-and-dod-response-to-2011-fukushima-incident-radiological-air-samples-09f5e
# US DOE/NNSA and DoD Response to 2011 Fukushima Incident: Radiological Air Samples  [Recovered with the Internet Archive: Wayback Machine]

# Data Source 5
# https://web.archive.org/web/20160617002257/https://catalog.data.gov/dataset/us-doe-nnsa-and-dod-response-to-2011-fukushima-incident-field-team-radiological-measuremen-33914
# US DOE/NNSA and DoD Response to 2011 Fukushima Incident: Field Team Radiological Measurements  [Recovered with the Internet Archive: Wayback Machine]

# Data Source 6
# https://web.archive.org/web/20160617000359/https://catalog.data.gov/dataset/us-doe-nnsa-and-dod-response-to-2011-fukushima-incident-radiological-soil-samples-ff220
# US DOE/NNSA and DoD Response to 2011 Fukushima Incident: Radiological Soil Samples  [Recovered with the Internet Archive: Wayback Machine]
