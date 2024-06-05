# iemiscdata 1.0.2 (4 June 2024)

* Added the 27 Human Cell Salts Table (cell_salts), the Total Number of Atoms of Elements From the 27 Human Cell Salts Table (cell_salts_atoms_final), and the Table of Plant Nutrients (plant_essentials) data sets
* Updated the exceptional_tn_waters data set
* Added the Total Number of Atoms of Elements in the 27 Human Cell Salts vignette offsite at https://www.ecoccs.com/R_Examples/Total-Number-Atoms-Elements-27-Human-Cell-Salts.pdf
* Added `formatR` to Suggests due to the "Warning in eng_r(options) : Failed to tidy R code in chunk 'unnamed-chunk-1'. Reason: Error : The formatR package is required by the chunk option tidy = TRUE but not installed; tidy = TRUE will be ignored." in the CRAN Package Check Results
* Added `xopen` to Suggests
* Received an e-mail issue from Prof Brian Ripley on 16 May 2024 regarding the package check notes at https://cran.r-project.org/web/checks/check_results_iemiscdata.html. The issues have been resolved.
* This CRAN re-submission version has temporarily removed the use of `iemisc` in the vignettes


# iemiscdata 1.0.1 (10 January 2024)

* Received an e-mail issue from Prof Brian Ripley on 11 December 2023 regarding the package check notes at https://cran.r-project.org/web/checks/check_results_iemiscdata.html. The issues have been resolved.


# iemiscdata 1.0.0 (25 September 2023)

* Changed the R version due to this warning message: "Added dependency on R >= 3.5.0 because serialized objects in serialize/load version 3 cannot be read in older versions of R."
* Moved all stored data sets from .RData to .rda (based on the discussions here: https://stackoverflow.com/questions/64456152/how-to-add-a-list-to-exported-data-when-building-up-r-packages)
* Revised the non-standard evaluation of library calls to standard evaluation calls in the README and in the View-PDF-table vignette
* Removed `ie2misc` and `ie2miscdata` from Suggests
* Added `lubridate`, `snakecase`, `units`, `round`, `anytime`, `ggplot2`, `USA.state.boundaries`, `chem.databases`, `sf`, `pander`, `sfheaders`, `dplyr`, and `spelling` to Suggests
* Revised all of the vignettes
* Revised the examples in the Examples Using Manning's n vignette
* Added Viewing Tables & Their Associated Notes; Map of the Sampled US Locations after the Fukushima Power Plant Explosions in 2011; the Weighted CN Calculations Using the Composite CN; USEPA East Palestine, Ohio Norfolk Southern Train 32N Cargo List -- Chemical Databases Match; and Map of Tennessee Exceptional Waters vignettes
* Added the ability to browse vignettes & get help for the `iemiscdata` package in the README
* Moved from references to source declaration for all of the data sets
* Revised the Wikipedia US Presidential Election table as it's been totally revised and changed the name of the data set from pres_elect1 to pres_elect
* Added the following 68 data sets: Fp, Fukushima_2011_FieldMeasurements_5, Fukushima_2011_FieldMeasurements_5_Metadata, Fukushima_2011_FieldSampleAirResults_2, Fukushima_2011_FieldSampleAirResults_2_Metadata, Fukushima_2011_FieldSampleInstrumentResults, Fukushima_2011_FieldSampleInstrumentResults_Metadata, Fukushima_2011_FieldSampleSoilResults_2, Fukushima_2011_FieldSampleSoilResults_2_Metadata, Ia, USAEC_facilities_nuclear_accidents, USA_primary_water_contaminants, USA_primary_water_contaminants_notes, USA_secondary_water_contaminants, USA_secondary_water_contaminants_notes, c_agricultural, c_urban, civilian_nuclear_accidents_wiki, cn_agricultural, cn_agricultural_notes, cn_arid_semiarid, cn_arid_semiarid_notes, cn_other_agricultural, cn_other_agricultural_notes, cn_urban, cn_urban_notes, common_gases, common_gases_simp, dry_air, duh_gamma, elements, elements_pubchem, elements_wiki, exceptional_tn_waters, exceptional_tn_waters_abbrv, gas_constant, gases, gases_plain, gases_table, greenhouse_gases_cloudy_notes_wikipedia, greenhouse_gases_cloudy_sky, greenhouse_gases_cloudy_wikipedia, greenhouse_gases_contributions, hsg, hsg_definitions, military_nuclear_accidents_wiki, norfolk_southern_epoh, nsheetflow, nsheetflow_notes, nuclear_accidents, nuclear_accidents_ranked, nuclear_accidents_wiki, nuclear_power_accidents_country_wiki, pres_cont_congress, pres_elect, raddata_US_Fukushima_2011, raddata_usa_territories_Fukushima_2011, rainfall_distribution_equation_coefficients, rainfall_type_equation_coefficients, riprap_table_ft, riprap_table_in, riprap_table_mm, riprap_table_yd, runoff_depth, runoff_depth_notes, uh_ratios, uh_ratios_masscurve, water_vapour_pressure [Refer to the README for the title of each data set]


# iemiscdata 0.6.1

* Added `ie2misc`, `ie2miscdata` to Suggests


# iemiscdata 0.6.0

* Revised the examples in the vignettes (Examples Using Manning's n and PDF Version of Manning's n Tables)
* Changed the examples in the README.md
* Added effective and nominal interest tables (Engineering Economics)
* Added Wikipedia US Presidential Election table


# iemiscdata 0.5.1

* Added vignettes (Examples Using Manning's n and PDF Version of Manning's n Tables)
* Added `iemisc`, `knitr`, `rmarkdown`to Suggests


# iemiscdata 0.5.0

* Initial release
