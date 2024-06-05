# Vapour pressure of water

install.load::load_package("rvest", "data.table")

url <- "https://en.wikipedia.org/wiki/Vapour_pressure_of_water"

# Source 1 begin
water_vapour_pressure <- read_html(url)
water_vapour_pressure <- html_nodes(water_vapour_pressure, "table.wikitable") %>% html_table(header = TRUE)
# Source 1 end

# combine the list into a single data.table
water_vapour_pressure <- as.data.table(water_vapour_pressure[[1]])


save(water_vapour_pressure, file = "./data/water_vapour_pressure.rda")

# Data source
# Vapour pressure of water
# https://en.wikipedia.org/wiki/Vapour_pressure_of_water
# 6 September 2023





# Source 1
# Wikipedia Data Scraping with R: rvest in Action: Scraping list of people on bank notes for exploratory data analysis using rvest functions By Korkrid Kyle Akepanidtaworn, Jul 21, 2018. https://medium.com/@kyleake/wikipedia-data-scraping-with-r-rvest-in-action-3c419db9af2d
