install.load::load_package("rvest", "data.table")


elect <- read_html("./inst/extdata/United_States_presidential_election.html")
elections <- html_table(html_nodes(elect, "table.wikitable"), fill = TRUE)
elections <- as.data.table(elections[[1]])

setnames(elections, "%", "Popular Vote %")
pres_elect <- copy(elections)

save(pres_elect, file = "./data/pres_elect.rda")



# Data source
# Wikimedia Foundation, Inc. Wikipedia, Accessed on 17 May 2023, United States presidential election. https://en.wikipedia.org/wiki/United_States_presidential_election. This page was last edited on 15 May 2023


# Notes:
# Please refer to the notes on the Wikipedia page
