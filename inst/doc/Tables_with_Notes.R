## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------

install.load::load_package("iemiscdata", "pander", "knitr")
# load needed packages using the load_package function from the install.load package (it is assumed that you have already installed these packages)

# set the pander options
panderOptions("missing", "")
panderOptions("table.alignment.default", "left")
panderOptions("table.alignment.rownames", "left")
panderOptions("table.split.cells", Inf)
panderOptions("table.split.table", Inf)


## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------

data(runoff_depth)
data(runoff_depth_notes)
# load the data from iemiscdata (containing Table 2-1: Runoff depth for selected CN's and rainfall amounts & notes)

pander(runoff_depth)
pander(runoff_depth_notes)


## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------

data(cn_urban)
data(cn_urban_notes)
# load the data from iemiscdata (containing Table 2-2a: Runoff curve numbers for urban areas & notes)

pander(cn_urban)
pander(cn_urban_notes)


## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------

data(cn_agricultural)
data(cn_agricultural_notes)
# load the data from iemiscdata (containing Table 2-2b: Runoff curve numbers for cultivated agricultural lands & notes)


pander(cn_agricultural)
pander(cn_agricultural_notes)

## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------

data(cn_other_agricultural)
data(cn_other_agricultural_notes)
# load the data from iemiscdata (containing Table 2-2c: Runoff curve numbers for other agricultural lands & notes)


pander(cn_other_agricultural)
pander(cn_other_agricultural_notes)


## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------

data(cn_arid_semiarid)
data(cn_arid_semiarid_notes)
# load the data from iemiscdata (containing Table 2-2d: Runoff curve numbers for arid and semiarid rangelands & notes)


pander(cn_arid_semiarid)
pander(cn_arid_semiarid_notes)


## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------

data(hsg)
data(hsg_definitions)
# load the data from iemiscdata (containing Table from Appendix A: Hydrologic Soil Groups (HSGs) & notes)



pander(hsg)
pander(hsg_definitions)


## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------
data(USA_primary_water_contaminants)
data(USA_primary_water_contaminants_notes)
# load the data from iemiscdata (containing US EPA National Primary Drinking Water Regulations Contaminants Table & notes)



pander(USA_primary_water_contaminants)
pander(USA_primary_water_contaminants_notes)


## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------
data(USA_secondary_water_contaminants)
data(USA_secondary_water_contaminants_notes)
# load the data from iemiscdata (containing US EPA Secondary Drinking Water Standards Table & notes)



pander(USA_secondary_water_contaminants)
pander(USA_secondary_water_contaminants_notes)


## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------

data(nsheetflow)
data(nsheetflow_notes)
# load the data from iemiscdata (containing Table 3-1: Roughness coefficients (Manning's n) for sheet flow & notes)



pander(nsheetflow)
pander(nsheetflow_notes)


## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------

data(greenhouse_gases_cloudy_wikipedia)
data(greenhouse_gases_cloudy_notes_wikipedia)
# load the data from iemiscdata [containingGreenhouse Gases -- Percent Contribution to Total Greenhouse Effect & notes (Wikipedia)]



pander(greenhouse_gases_cloudy_wikipedia)
pander(greenhouse_gases_cloudy_notes_wikipedia)


