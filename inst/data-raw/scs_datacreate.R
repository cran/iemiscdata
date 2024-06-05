# Table 16-1: Ratios for dimensionless unit hydrograph and mass curve

library(data.table)

uh_ratios_masscurve <- fread("./inst/extdata/time_discharge_mass-curve_ratios.csv")

setnames(uh_ratios_masscurve, c("Time ratios (t/Tp)", "Discharge ratios (q/qp)", "Mass curve ratios (Qa/Q)"))

save(uh_ratios_masscurve, file = "./data/uh_ratios_masscurve.rda")



# Table 16-2 Computation of coordinates for unit hydrograph for use in example 16-1

library(data.table)

uh_ratios <- fread("./inst/extdata/time_discharge-ratios.csv")

setnames(uh_ratios, c("Time ratios (t/Tp)", "Discharge ratios (q/qp)"))

save(uh_ratios, file = "./data/uh_ratios.rda")




# Table 16-5 Relationship of m and PRF for DUH developed from a Gamma equation

library(data.table)

duh_gamma <- fread("./inst/extdata/m_PRF_gamma-DUH.csv")

save(duh_gamma, file = "./data/duh_gamma.rda")





# Source
# https://directives.sc.egov.usda.gov/OpenNonWebContent.aspx?content=17755.wba
# United States Department of Agriculture (USDA) Natural Resources Conservation Service (NRCS) National Engineering Handbook Part 630 Hydrology Chapter 16 Hydrographs
# Pages 16-4, 16-9, 16-15
