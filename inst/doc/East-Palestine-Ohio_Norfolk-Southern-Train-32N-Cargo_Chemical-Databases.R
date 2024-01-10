## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------

install.load::load_package("iemiscdata", "chem.databases", "data.table", "mgsub", "stringi", "pander")
# load needed packages using the load_package function from the install.load package (it is assumed that you have already installed these packages)

data(norfolk_southern_epoh)
# from iemiscdata package

data(chem_wiki)
# from chem.databases package

data(atsdr_tsca_ld50_a)
# from chem.databases package



train_commodities <- unique(norfolk_southern_epoh$Commodity)

pander(train_commodities)


# remove items that are not needed

train_commodities <- train_commodities[-c(3, 9, 16:20, 23:26)]


# remove words that are not needed

train_commodities <- mgsub(train_commodities, c(", STABILIZED", "COMBUSTIBLE LIQ., NOS", "LUBE OIL", "WAX"), rep("", 4), fixed = TRUE)


# remove parentheses that are not needed

train_commodities <- mgsub(train_commodities, c("\\(", "\\)"), rep("", 2), fixed = FALSE)


# remove the beginning and trailing white space

train_commodities <- stri_trim_both(train_commodities)


# transform the text to sentence case

train_commodities <- stri_trans_totitle(train_commodities, type = "sentence")


# correct the spelling as needed

train_commodities[4] <- "Dipropylene glycol"

train_commodities[9] <- "Polyvinyl chloride"

train_commodities[13] <- "Butyl acrylate"

pander(train_commodities)


# the exact matched chemical names

pander(chem_wiki[`Substance Name` %in% train_commodities])

pander(atsdr_tsca_ld50_a[`Registry Name` %in% train_commodities])


# the matched names

train_match1 <- chem_wiki[`Substance Name` %in% train_commodities]

train_match2 <- atsdr_tsca_ld50_a[`Registry Name` %in% train_commodities]

train_matchs1 <- train_match1$"Substance Name"

train_matchs2 <- train_match2$"Registry Name"

train_match <- unique(c(train_matchs1, train_matchs2))

pander(train_match)


train_match_cas1 <- train_match1$CAS

train_match_cas2 <- train_match2$CAS

train_match_cas <- unique(c(train_match_cas1, train_match_cas2))

pander(train_match_cas)


# remove the matched names

train_commodities2 <- train_commodities[-which(train_commodities %in% train_match)]


# these are the chemical substances without an exact match

pander(train_commodities2)


