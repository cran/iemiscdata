install.load::load_package("rvest", "data.table", "mgsub", "anytime", "stringi")

# read in the data
cont_congress <- read_html("./inst/extdata/President_of_the_Continental_Congress.html")
cont_congressions <- html_table(html_nodes(cont_congress, "table.wikitable"), fill = TRUE)
cont_congressions <- as.data.table(cont_congressions[[1]])


# copy the table
pres_cont_congress <- copy(cont_congressions)


# replace – with -
pres_cont_congress <- mgsub(pres_cont_congress, "–", "-")


# remove the Portrait column
pres_cont_congress[, Portrait := NULL]


# split the strings
pres_cont_congress[, c("Year Born", "Year Died") := tstrsplit(Name, "-", fixed = TRUE)][]


# split the strings
pres_cont_congress[, c("Term Begin", "Term End") := tstrsplit(Term, "-", fixed = TRUE)][]


# replace the contents of the Name column
pres_cont_congress$Name <- c("Peyton Randolph", "Henry Middleton", "Peyton Randolph", "John Hancock", "Henry Laurens", "John Jay", "Samuel Huntington", "Thomas McKean", "John Hanson", "Elias Boudinot", "Thomas Mifflin", "Richard Henry Lee", "John Hancock", "Nathaniel Gorham", "Arthur St. Clair", "Cyrus Griffin")

# Source 1 Begin
pres_cont_congress$"Year Born" <- gsub("[^0-9]", "", pres_cont_congress$"Year Born")

pres_cont_congress$"Year Died" <- gsub("[^0-9]", "", pres_cont_congress$"Year Died")
# Source 1 End

setcolorder(pres_cont_congress, c("Name", "Year Born", "Year Died", "State/colony", "Term Begin", "Term End", "Term", "Length", "Previous position"))


# select the columns to change
change_class <- c("Year Born", "Year Died", "Term Begin", "Term End")

# remove invalid space characters
for (col in change_class)
set(pres_cont_congress, j = col, value = mgsub(pres_cont_congress[[col]], " ", " "))

# change the columns to POSIX dates
for (col in change_class)
set(pres_cont_congress, j = col, value = anydate(pres_cont_congress[[col]]))


# check for & replace non-ASCII strings

if(any(unlist(lapply(pres_cont_congress, stri_enc_isascii)) == FALSE)) { # Source 1

check_ascii <- names(pres_cont_congress)

# Source 2 begin
for (col in check_ascii) {

idx1 <- which(!stri_enc_isascii(pres_cont_congress[[col]]))

set(pres_cont_congress, i = idx1, j = col, value = stri_escape_unicode(pres_cont_congress[[col]][idx1]))
}
# Source 2 end
}



save(pres_cont_congress, file = "./data/pres_cont_congress.rda")




# Data source
# Wikimedia Foundation, Inc. Wikipedia, Accessed on 24 August 2023, United States presidential cont_congression. https://en.wikipedia.org/wiki/President_of_the_Continental_Congress. This page was last edited on 18 August 2023


# Notes:
# Please refer to the notes on the Wikipedia page


# R help source
# https://stackoverflow.com/questions/52722846/how-can-i-remove-non-numeric-characters-from-strings-using-gsub-in-r
# regex - How can I remove non-numeric characters from strings using gsub in R? - Stack Overflow
# answered by Andre Elrico on Oct 9, 2018 and edited by Andre Elrico on Sep 5, 2019



## Corrected Names obtained via removing extraneous text in a text editor

# Peyton Randolph
# Henry Middleton
# Peyton Randolph
# John Hancock
# Henry Laurens
# John Jay
# Samuel Huntington
# Thomas McKean
# John Hanson
# Elias Boudinot
# Thomas Mifflin
# Richard Henry Lee
# John Hancock
# Nathaniel Gorham
# Arthur St. Clair
# Cyrus Griffin




# Sources

# Source 1
# https://stackoverflow.com/questions/29043932/how-to-handle-example-data-in-r-package-that-has-utf-8-marked-strings
# twitter - How to handle example data in R Package that has UTF-8 marked strings - Stack Overflow

# Source 2
# https://stackoverflow.com/questions/50361168/r-data-table-set-add-number-to-certain-j-values-only | r - data.table set add number to certain j values only - Stack Overflow; answered by chinsoon12 on May 16 2018.

