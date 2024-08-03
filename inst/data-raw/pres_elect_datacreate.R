install.load::load_package("rvest", "data.table", "stringi")


elect <- read_html("./inst/extdata/United_States_presidential_election.html")
elections <- html_table(html_nodes(elect, "table.wikitable"), fill = TRUE)
elections <- as.data.table(elections[[1]])

setnames(elections, "%", "Popular Vote %")


# check for & replace non-ASCII strings

if(any(unlist(lapply(elections, stri_enc_isascii)) == FALSE)) { # Source 1

check_ascii <- names(elections)

# Source 2 begin
for (col in check_ascii) {

idx1 <- which(!stri_enc_isascii(elections[[col]]))

set(elections, i = idx1, j = col, value = stri_escape_unicode(elections[[col]][idx1]))
}
# Source 2 end
}



pres_elect <- copy(elections)

save(pres_elect, file = "./data/pres_elect.rda")



# Data source
# Wikimedia Foundation, Inc. Wikipedia, Accessed on 17 May 2023, United States presidential election. https://en.wikipedia.org/wiki/United_States_presidential_election. This page was last edited on 15 May 2023


# Notes:
# Please refer to the notes on the Wikipedia page



# Sources

# Source 1
# https://stackoverflow.com/questions/29043932/how-to-handle-example-data-in-r-package-that-has-utf-8-marked-strings
# twitter - How to handle example data in R Package that has UTF-8 marked strings - Stack Overflow

# Source 2
# https://stackoverflow.com/questions/50361168/r-data-table-set-add-number-to-certain-j-values-only | r - data.table set add number to certain j values only - Stack Overflow; answered by chinsoon12 on May 16 2018.
