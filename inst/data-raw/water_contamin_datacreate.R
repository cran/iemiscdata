# US EPA National Primary Drinking Water Regulations Contaminants

install.load::load_package("rvest", "data.table")

# url1 <- "https://www.epa.gov/ground-water-and-drinking-water/national-primary-drinking-water-regulations"
url1 <- "/media/xbyri/5A96-9475/repo/iemiscdataA/iemiscdataa/inst/extdata/national-primary-drinking-water-regulations.html"

# Source 1 begin
primary_water_contamin <- read_html(url1)
primary_water_contamin <- html_nodes(primary_water_contamin, "table") %>% html_table(header = TRUE)
# Source 1 end

# combine the list into a single data.table
primary_water_contamin <- rbindlist(primary_water_contamin)


change_class <- "MCLG1 (mg/L)2"

for (col in change_class)
set(primary_water_contamin, j = col, value = mgsub::mgsub(primary_water_contamin[[col]], c("zero", "^n/a$"), c(0, NA_character_)))


USA_primary_water_contaminants <- copy(primary_water_contamin)

save(USA_primary_water_contaminants, file = "./data/USA_primary_water_contaminants.rda")



# read in the notes
primary_water_contamin_definitions <- fread("./inst/extdata/USA_primary_water_contaminants_notes.csv")


USA_primary_water_contaminants_notes <- copy(primary_water_contamin_definitions)

# save the notes
save(USA_primary_water_contaminants_notes, file = "./data/USA_primary_water_contaminants_notes.rda")



# Notes

# 1 Definitions:

# Maximum Contaminant Level Goal (MCLG) - The level of a contaminant in drinking water below which there is no known or expected risk to health. MCLGs allow for a margin of safety and are non-enforceable public health goals.
# Maximum Contaminant Level (MCL) - The highest level of a contaminant that is allowed in drinking water. MCLs are set as close to MCLGs as feasible using the best available treatment technology and taking cost into consideration. MCLs are enforceable standards.
# Maximum Residual Disinfectant Level Goal (MRDLG) - The level of a drinking water disinfectant below which there is no known or expected risk to health. MRDLGs do not reflect the benefits of the use of disinfectants to control microbial contaminants.
# Treatment Technique (TT) - A required process intended to reduce the level of a contaminant in drinking water.
# Maximum Residual Disinfectant Level (MRDL) - The highest level of a disinfectant allowed in drinking water. There is convincing evidence that addition of a disinfectant is necessary for control of microbial contaminants.

# 2 Units are in milligrams per liter (mg/L) unless otherwise noted. Milligrams per liter are equivalent to parts per million (PPM).

# 3 EPA's surface water treatment rules require systems using surface water or ground water under the direct influence of surface water to

# Disinfect their water, and
# Filter their water, or
# Meet criteria for avoiding filtration so that the following contaminants are controlled at the following levels:

# Cryptosporidium: Unfiltered systems are required to include Cryptosporidium in their existing watershed control provisions
# Giardia lamblia: 99.9% removal/inactivation.
# Viruses: 99.99% removal/inactivation.
# Legionella: No limit, but EPA believes that if Giardia and viruses are removed/inactivated, according to the treatment techniques in the Surface Water Treatment Rule, Legionella will also be controlled.   
# Turbidity: For systems that use conventional or direct filtration, at no time can turbidity (cloudiness of water) go higher than 1 Nephelometric Turbidity Unit (NTU), and samples for turbidity must be less than or equal to 0.3 NTUs in at least 95 percent of the samples in any month. Systems that use filtration other than the conventional or direct filtration must follow state limits, which must include turbidity at no time exceeding 5 NTUs.
# Heterotrophic Plate Count (HPC): No more than 500 bacterial colonies per milliliter.
# Long Term 1 Enhanced Surface Water Treatment: Surface water systems or groundwater under the direct influence (GWUDI) systems serving fewer than 10,000 people must comply with the applicable Long Term 1 Enhanced Surface Water Treatment Rule provisions (such as turbidity standards, individual filter monitoring, Cryptosporidium removal requirements, updated watershed control requirements for unfiltered systems).
# Long Term 2 Enhanced Surface Water Treatment Rule: This rule applies to all surface water systems or ground water systems under the direct influence of surface water. The rule targets additional Cryptosporidium treatment requirements for higher risk systems and includes provisions to reduce risks from uncovered finished water storage facilities and to ensure that the systems maintain microbial protection as they take steps to reduce the formation of disinfection byproducts.
# Filter Backwash Recycling: This rule requires systems that recycle to return specific recycle flows through all processes of the system's existing conventional or direct filtration system or at an alternate location approved by the state.

# 4 No more than 5.0% samples total coliform-positive (TC-positive) in a month. (For water systems that collect fewer than 40 routine samples per month, no more than one sample can be total coliform-positive per month.) Every sample that has total coliform must be analyzed for either fecal coliforms or E. coli if two consecutive TC-positive samples, and one is also positive for E.coli fecal coliforms, system has an acute MCL violation.

# 5 Fecal coliform and E. coli are bacteria whose presence indicates that the water may be contaminated with human or animal wastes. Disease-causing microbes (pathogens) in these wastes can cause diarrhea, cramps, nausea, headaches, or other symptoms. These pathogens may pose a special health risk for infants, young children, and people with severely compromised immune systems.

# 6 Although there is no collective MCLG for this contaminant group, there are individual  MCLGs for some of the individual contaminants:

# Trihalomethanes: bromodichloromethane (zero); bromoform (zero); dibromochloromethane (0.06 mg/L): chloroform (0.07 mg/L.
# Haloacetic acids: dichloroacetic acid (zero); trichloroacetic acid (0.02 mg/L); monochloroacetic acid (0.07mg/L). Bromoacetic acid and dibromoacetic acid are regulated with this group but have no MCLGs.

# 7 Lead and copper are regulated by a treatment technique that requires systems to control the corrosiveness of their water. If more than 10% of tap water samples exceed the action level, water systems must take additional steps. For copper, the action level is 1.3 mg/L, and for lead is 0.015 mg/L.

# 8 Each water system must certify, in writing, to the state (using third-party or manufacturer's certification) that when acrylamide and epichlorohydrin are used to treat water, the combination (or product) of dose and monomer level does not exceed the levels specified, as follows:

# Acrylamide = 0.05% dosed at 1 mg/L (or equivalent)
# Epichlorohydrin = 0.01% dosed at 20 mg/L (or equivalent)



# Data source
# National Primary Drinking Water Regulations | US EPA
# https://www.epa.gov/ground-water-and-drinking-water/national-primary-drinking-water-regulations
# Saved as national-primary-drinking-water-regulations.html in inst/extdata





# US EPA Secondary Drinking Water Standards

install.load::load_package("rvest", "data.table")

# url2 <- "https://www.epa.gov/sdwa/secondary-drinking-water-standards-guidance-nuisance-chemicals"
url2 <- "/media/xbyri/5A96-9475/repo/iemiscdataA/iemiscdataa/inst/extdata/secondary-drinking-water-standards-guidance-nuisance-chemicals.html"


# Source 1 begin
secondary_water_contamin <- read_html(url2)
secondary_water_contamin <- html_nodes(secondary_water_contamin, "table") %>% html_table(header = TRUE)
# Source 1 end

secondary_water_contamin <- as.data.table(secondary_water_contamin)

setnames(secondary_water_contamin, c("Secondary.MCL", "Noticeable.Effects.above.the.Secondary.MCL"), c("Secondary MCL", "Noticeable Effects above the Secondary MCL"))


USA_secondary_water_contaminants <- copy(secondary_water_contamin)

save(USA_secondary_water_contaminants, file = "./data/USA_secondary_water_contaminants.rda")


# read in the notes
secondary_water_contamin_definitions <- fread("./inst/extdata/USA_secondary_water_contaminants_notes.csv")



USA_secondary_water_contaminants_notes <- copy(secondary_water_contamin_definitions)

# save the notes
save(USA_secondary_water_contaminants_notes, file = "./data/USA_secondary_water_contaminants_notes.rda")



# Note

# * mg/L is milligrams of substance per liter of water.



# Data source
# Secondary Drinking Water Standards: Guidance for Nuisance Chemicals | US EPA
# https://www.epa.gov/sdwa/secondary-drinking-water-standards-guidance-nuisance-chemicals
# Saved as secondary-drinking-water-standards-guidance-nuisance-chemicals.html in inst/extdata




# Source 1
# Wikipedia Data Scraping with R: rvest in Action: Scraping list of people on bank notes for exploratory data analysis using rvest functions By Korkrid Kyle Akepanidtaworn, Jul 21, 2018. https://medium.com/@kyleake/wikipedia-data-scraping-with-r-rvest-in-action-3c419db9af2d
