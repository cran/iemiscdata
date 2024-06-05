## Table 2-1: Runoff depth for selected CN's and rainfall amounts *1

library(data.table)

# read in the data
runoff_depth <- fread("./inst/extdata/runoff_depth.csv")

# change the column names by adding "Runoff depth for curve number of" as a prefix
setnames(runoff_depth, 2:ncol(runoff_depth), glue::glue("Runoff depth (in) for curve number of {names(runoff_depth)[-1]}"))

# save the data
save(runoff_depth, file = "./data/runoff_depth.rda")



# read in the notes
runoff_depth_notes <- fread("./inst/extdata/runoff_depth_notes.csv")

# save the notes
save(runoff_depth_notes, file = "./data/runoff_depth_notes.rda")



# Note for the table metadata:
# *1 Interpolate the values shown to obtain runoff depths for CN's or rainfall amounts not shown.







## Table 2-2a: Runoff curve numbers for urban areas *1

install.load::load_package("data.table", "stringi")

# read in the data
cn_urban <- fread("./inst/extdata/cn_urban.csv")


# trim all white space at the left and the right
column1 <- "Cover type and hydrologic condition"

for (col in column1)
set(cn_urban, j = col, value = stri_trim_both(cn_urban[[col]]))


# save the data
save(cn_urban, file = "./data/cn_urban.rda")



# read in the notes
cn_urban_notes <- fread("./inst/extdata/cn_urban_notes.csv")

# save the notes
save(cn_urban_notes, file = "./data/cn_urban_notes.rda")


# Notes:

# *1 Average runoff condition, and Ia = 0.2S.

# *2 The average percent impervious area shown was used to develop the composite CN's. Other assumptions are as follows: impervious areas are directly connected to the drainage system, impervious areas have a CN of 98, and pervious areas are considered equivalent to open space in good hydrologic condition. CN's for other combinations of conditions may be computed using figure 2-3 or 2-4.

# *3 CN's shown are equivalent to those of pasture. Composite CN's may be computed for other combinations of open space cover type.

# *4 Composite CN's for natural desert landscaping should be computed using figures 2-3 or 2-4 based on the impervious area percentage (CN = 98) and the pervious area CN. The pervious area CN's are assumed equivalent to desert shrub in poor hydrologic condition.

# *5 Composite CN's to use for the design of temporary measures during grading and construction should be computed using figure 2-3 or 2-4 based on the degree of development (impervious area percentage) and the CN's for the newly graded pervious areas.




## Table 2-2b: Runoff curve numbers for cultivated agricultural lands *1

library(data.table)

# read in the data
cn_agricultural <- fread("./inst/extdata/cn_agricultural.csv")

# save the data
save(cn_agricultural, file = "./data/cn_agricultural.rda")



# read in the notes
cn_agricultural_notes <- fread("./inst/extdata/cn_agricultural_notes.csv")

# save the notes
save(cn_agricultural_notes, file = "./data/cn_agricultural_notes.rda")




# Notes

# *1 Average runoff condition, and Ia=0.2S

# *2 Crop residue cover applies only if residue is on at least 5% of the surface throughout the year.

# *3 Hydraulic condition is based on combination factors that affect infiltration and runoff, including (a) density and canopy of vegetative areas, (b) amount of year-round cover, (c) amount of grass or close-seeded legumes, (d) percent of residue cover on the land surface (good ≥ 20%), and (e) degree of surface roughness.

# Poor: Factors impair infiltration and tend to increase runoff.

# Good: Factors encourage average and better than average infiltration and tend to decrease runoff.







## Table 2-2c: Runoff curve numbers for other agricultural lands *1

library(data.table)

# read in the data
cn_other_agricultural <- fread("./inst/extdata/cn_other_agricultural.csv")

# save the data
save(cn_other_agricultural, file = "./data/cn_other_agricultural.rda")



# read in the notes
cn_other_agricultural_notes <- fread("./inst/extdata/cn_other_agricultural_notes.csv")

# save the notes
save(cn_other_agricultural_notes, file = "./data/cn_other_agricultural_notes.rda")


# Notes

# *1 Average runoff condition, and Ia = 0.2S.

# *2 Poor: <50%) ground cover or heavily grazed with no mulch.
# Fair: 50 to 75% ground cover and not heavily grazed.

# *3 Poor: <50% ground cover.
# Fair: 50 to 75% ground cover.
# Good: >75% ground cover.

# *4 Actual curve number is less than 30; use CN = 30 for runoff computations.

# *5 CN's shown were computed for areas with 50% woods and 50% grass (pasture) cover. Other combinations of conditions may be computed from the CN's for woods and pasture.

# *6 Poor: Forest litter, small trees, and brush are destroyed by heavy grazing or regular burning.
# Fair: Woods are grazed but not burned, and some forest litter covers the soil.
# Good: Woods are protected from grazing, and litter and brush adequately cover the soil.







## Table 2-2d: Runoff curve numbers for arid and semiarid rangelands *1

library(data.table)

# read in the data
cn_arid_semiarid <- fread("./inst/extdata/cn_arid_semiarid.csv")

# save the data
save(cn_arid_semiarid, file = "./data/cn_arid_semiarid.rda")



# read in the notes
cn_arid_semiarid_notes <- fread("./inst/extdata/cn_arid_semiarid_notes.csv")

# save the notes
save(cn_arid_semiarid_notes, file = "./data/cn_arid_semiarid_notes.rda")



# Notes

# *1 Average runoff condition, and Ia, = 0.2S. For range in humid regions, use table 2-2c.

# *2 Poor: <30% ground cover (litter, grass, and brush overstory).
# Fair: 30 to 70% ground cover.
# Good: > 70% ground cover.

# *3 Curve numbers for group A have been developed only for desert shrub.





## Table 4-1: Ia values for runoff Curve number

library(data.table)

# read in the data
Ia <- fread("./inst/extdata/ia.csv")

# save the data
save(Ia, file = "./data/Ia.rda")





## Table 4-2: Adjustment factor (Fp) for pond and swamp areas that are spread throughout the watershed

library(data.table)

# read in the data
Fp <- fread("./inst/extdata/pond_swamp.csv")

# save the data
save(Fp, file = "./data/Fp.rda")






## Table from Appendix A: Hydrologic Soil Groups (HSGs)

library(data.table)

# read in the data
hsg <- fread("./inst/extdata/hsg.csv")

# save the data
save(hsg, file = "./data/hsg.rda")



# read in the notes
hsg_definitions <- fread("./inst/extdata/hsg_definitions.csv")

# save the notes
save(hsg_definitions, file = "./data/hsg_definitions.rda")




# Further information

# Group A soils have low runoff potential and high infiltration rates even when thoroughly wetted. They consist chiefly of deep, well to excessively drained sand or gravel and have a high rate of water transmission (greater than 0.30 in/hr).

# Group B soils have moderate infiltration rates when thoroughly wetted and consist chiefly of moderately deep to deep, moderately well to well drained soils with moderately fine to moderately coarse textures. These soils have a moderate rate of water transmission (0.15-0.30 in/hr).

# Group C soils have low infiltration rates when thoroughly wetted and consist chiefly of soils with a layer that impedes downward movement of water and soils with moderately fine to fine texture. These soils have a low rate of water transmission (0.05-0.15 in/hr).

# Group D soils have high runoff potential. They have very low infiltration rates when thoroughly wetted and consist chiefly of clay soils with a high swelling potential, soils with a permanent high water table, soils with a claypan or clay layer at or near the surface, and shallow soils over nearly impervious material. These soils have a very low rate of water transmission (0-0.05 in/hr).

# Drainage and group D soils

# Some soils in the list are in group D because of a high water table that creates a drainage problem. Once these soils are effectively drained, they are placed in a different group. For example, Ackerman soil is classified as A/D. This indicates that the drained Ackerman soil is in group A and the undrained soil is in group D.





## Table F-1 Coefficients for the equation used to generate exhibits 4-I through 4-III

install.load::load_package("data.table", "stringi")

# read in the data
rainfall_type_equation_coefficients <- fread("./inst/extdata/rainfall_type_equation_coefficients.csv")


# trim all white space at the left and the right
column2 <- "Rainfall type"

for (col in column2)
set(rainfall_type_equation_coefficients, j = col, value = stri_trim_both(rainfall_type_equation_coefficients[[col]]))


# save the data
save(rainfall_type_equation_coefficients, file = "./data/rainfall_type_equation_coefficients.rda")







## Table F-2 Coefficients for the equation used to generate figure 6-1

install.load::load_package("data.table", "stringi")

# read in the data
rainfall_distribution_equation_coefficients <- fread("./inst/extdata/rainfall_distribution_equation_coefficients.csv")


# trim all white space at the left and the right
column3 <- "Rainfall distribution"

for (col in column3)
set(rainfall_distribution_equation_coefficients, j = col, value = stri_trim_both(rainfall_distribution_equation_coefficients[[col]]))


# save the data
save(rainfall_distribution_equation_coefficients, file = "./data/rainfall_distribution_equation_coefficients.rda")








# Data source
# https://directives.sc.egov.usda.gov/OpenNonWebContent.aspx?content=22162.wba
# Urban Hydrology for Small Watersheds, TR-55
# pages 2-3, 2-5 - 2-8, 4-1 - 4-2, A-1, F-2
