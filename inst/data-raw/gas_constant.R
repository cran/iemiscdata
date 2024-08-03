install.load::load_package("data.table", "stringi")


# Universal gas constant (Wikipedia)
gas_constant <- fread("./inst/extdata/gas_constant.csv")


# check for & replace non-ASCII strings

if(any(unlist(lapply(gas_constant, stri_enc_isascii)) == FALSE)) { # Source 1

check_ascii <- names(gas_constant)

# Source 2 begin
for (col in check_ascii) {

idx1 <- which(!stri_enc_isascii(gas_constant[[col]]))

set(gas_constant, i = idx1, j = col, value = stri_escape_unicode(gas_constant[[col]][idx1]))
}
# Source 2 end
}



# change the column name
setnames(gas_constant, "Values of R", "R Values")

# remove blank spaces
change_class1 <- colnames(gas_constant)

# remove the white space
for (col in change_class1)
set(gas_constant, j = col, value = stri_trim_both(gas_constant[[col]], pattern = "\\P{Wspace}"))



change_class2 <- "R Values"

# set as numeric column
for (col in change_class2)
set(gas_constant, j = col, value = as.numeric(gas_constant[[col]]))


save(gas_constant, file = "./data/gas_constant.rda")




# Reference

# Wikimedia Foundation, Inc. Wikipedia, 4 January 2022, Gas constant. https://en.wikipedia.org/wiki/Gas_constant





# Sources

# Source 1
# https://stackoverflow.com/questions/29043932/how-to-handle-example-data-in-r-package-that-has-utf-8-marked-strings
# twitter - How to handle example data in R Package that has UTF-8 marked strings - Stack Overflow

# Source 2
# https://stackoverflow.com/questions/50361168/r-data-table-set-add-number-to-certain-j-values-only | r - data.table set add number to certain j values only - Stack Overflow; answered by chinsoon12 on May 16 2018.
