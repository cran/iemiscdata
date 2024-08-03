# Exceptional Tennessee Waters

install.load::load_package("data.table", "anytime", "sjmisc", "assertthat", "openxlsx2", "stringi")

# read in the CSV file
exceptional_tn_waters <- fread("./inst/extdata/exceptional_tn_waters.csv", colClasses = "character")

# change the column names of exceptional_tn_waters
setnames(exceptional_tn_waters, c("From Lat", "To Lat", "From Long", "To Long"), c("From_Lat", "To_Lat", "From_Long", "To_Long"))

# change the columns to numeric
change_class1 <- c("From_Lat", "To_Lat", "From_Long", "To_Long")

for (col in change_class1)
set(exceptional_tn_waters, j = col, value = as.numeric(exceptional_tn_waters[[col]]))


# change the columns to POSIX dates
change_class2 <- c("Inclusion Date", "Revision Date")

for (col in change_class2)
set(exceptional_tn_waters, j = col, value = anydate(exceptional_tn_waters[[col]]))


# check for & replace non-ASCII strings

if(any(unlist(lapply(exceptional_tn_waters, stri_enc_isascii)) == FALSE)) { # Source 1

check_ascii <- names(exceptional_tn_waters)

# Source 2 begin
for (col in check_ascii) {

idx1 <- which(!stri_enc_isascii(exceptional_tn_waters[[col]]))

set(exceptional_tn_waters, i = idx1, j = col, value = stri_escape_unicode(exceptional_tn_waters[[col]][idx1]))
}
# Source 2 end
}


# check for wrong values for Latitude or Longitude

ex_tn_waters <- exceptional_tn_waters[From_Lat < 0 | To_Lat < 0 | From_Long > 0 | To_Long > 0]


# Verify the latitude and longitude coordinates
if (is_empty(ex_tn_waters)) {
# only proceed with at least one TRUE value and provide a stop warning if not

save(exceptional_tn_waters, file = "./data/exceptional_tn_waters.rda")


} else {

cat("Either From_Lat, To_Lat, From_Long, and/or To_Long has an incorrect value(s).\n\n")


wb <- wb_workbook() %>% wb_add_worksheet("Exceptional_TN_Streams") %>% wb_add_worksheet("TN_Streams_Errors_Only") %>%  wb_add_data("Exceptional_TN_Streams", exceptional_tn_waters, na.strings = "") %>% wb_add_data("TN_Streams_Errors_Only", ex_tn_waters, na.strings = "")

posStyle <- create_dxfs_style(font_color = wb_color(hex = "#006100"), bgFill = wb_color(hex = "#C6EFCE"))

wb$add_conditional_formatting("Exceptional_TN_Streams", cols = 7:10, rows = 1:nrow(exceptional_tn_waters), rule = "$G1<0", style = posStyle)
wb$add_conditional_formatting("Exceptional_TN_Streams", cols = 7:10, rows = 1:nrow(exceptional_tn_waters), rule = "$H1<0", style = posStyle)
wb$add_conditional_formatting("Exceptional_TN_Streams", cols = 7:10, rows = 1:nrow(exceptional_tn_waters), rule = "$I1>0", style = posStyle)
wb$add_conditional_formatting("Exceptional_TN_Streams", cols = 7:10, rows = 1:nrow(exceptional_tn_waters), rule = "$J1>0", style = posStyle)

wb_save(wb, file = "/media/xbyri/5A96-9475/repo/iemiscdataA/Not_Use/tn_rivers/exceptional_tn_waters_9February2024.xlsx", overwrite = TRUE)


wb_open(wb)

}





# Exceptional Tennessee Waters Abbreviations used

install.load::load_package("data.table", "stringi")

# read in the text
exceptional_tn_waters_abbrv <- fread("NF = National Forest
NM = National Monument
NMP = National Military Park
NP = National Park
NRA = National Recreation Area
NRRA = National River and Recreation Area
NW = National Wilderness
NWR = National Wildlife Refuge
ONRW = Outstanding National Resource Water
RM = River Mile
SAA = State Archaeological Area
SHP = State Historic Park
SNA = State National Area
SP = State Park
WA = Wilderness Area
WMA = Wildlife Management Area
WR = Wildlife Refuge", sep = "=", header = FALSE)


setnames(exceptional_tn_waters_abbrv, c("Abbreviation", "Full Name"))


# trim the white space
Colnus <- names(exceptional_tn_waters_abbrv)

for (col in Colnus)

set(exceptional_tn_waters_abbrv, j = col, value = stri_trim_both(exceptional_tn_waters_abbrv[[col]], pattern = "\\P{Wspace}"))


save(exceptional_tn_waters_abbrv, file = "./data/exceptional_tn_waters_abbrv.rda")



# Data source
# Tennessee Department of Environment and Conservation (TDEC) Division of Water Resources (DWR), Accessed 5 July 2024, The Known Exceptional Tennessee Waters and Outstanding National Resource Waters. https://dataviewers.tdec.tn.gov/dataviewers/f?p=2005:34304:8532810000898:::::


# Sources

# Source 1
# https://stackoverflow.com/questions/29043932/how-to-handle-example-data-in-r-package-that-has-utf-8-marked-strings
# twitter - How to handle example data in R Package that has UTF-8 marked strings - Stack Overflow

# Source 2
# https://stackoverflow.com/questions/50361168/r-data-table-set-add-number-to-certain-j-values-only | r - data.table set add number to certain j values only - Stack Overflow; answered by chinsoon12 on May 16 2018.
