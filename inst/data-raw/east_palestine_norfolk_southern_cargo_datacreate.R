## United States EPA East Palestine, Ohio Norfolk Southern Train 32N Cargo List

library("data.table")

norfolk_southern_epoh <- fread("./inst/extdata/Train32N-EastPalestine_derail-list-Norfolk-Southern.csv")
# Data Source 1

setnames(norfolk_southern_epoh, c("Line #", "Train Car ID", "Load/Empty", "Car Type", "Commodity", "Tank Car Specification", "UN ID", "Hazardous Class", "Status of Car") )

save(norfolk_southern_epoh, file = "./data/norfolk_southern_epoh.rda")


# Data source
# US Environmental Protection Agency (EPA), TRAIN 32N cargo list, https://www.epa.gov/system/files/documents/2023-02/TRAIN%2032N%20-%20EAST%20PALESTINE%20-%20derail%20list%20Norfolk%20Southern%20document.pdf
