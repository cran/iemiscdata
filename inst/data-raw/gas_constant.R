install.load::load_package("data.table", "stringi")


# Universal gas constant (Wikipedia)
gas_constant <- fread("./inst/extdata/gas_constant.csv")

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
