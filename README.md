# iemiscdata

R data package that contains Irucka Embry&#8217;s miscellaneous data sets:  

* Chemistry
    + Periodic Table of the Elements,
    + Gaseous Compounds and Elements,
    + Water Vapor Pressure;
* Engineering Economics
    + Nominal Interest Rate,
    + Effective Interest Rate;
* Environmental/Water Resources Engineering
    + Exceptional Tennessee Waters,
    + Greenhouse Gas Contributions,
    + Manning's n Roughness Coefficients,
    + East Palestine, Ohio Norfolk Southern Train 32N Cargo List,
    + Stormwater-related Tables From NRCS,
    + Primary and Secondary Drinking Water Contaminants,
    + Tennessee Department of Transportation (TDOT) Machined riprap;
* Nuclear Accidents
    + Civilian,
        + Fukushima Daiichi Nuclear Power Plant Explosions
    + Military;
* US Presidential Elections; and 
* US Continental Congress Presidents



# Installation of iemiscdata from CRAN

```R
install.packages("iemiscdata")
```


# Help

With credit due to the `matlab` package, for a complete list of functions and the package DESCRIPTION file, use:  

```R
library(help = "iemiscdata")
```



# Vignette Viewing

If you wish to browse the `iemiscdata` Vignettes, please copy-and-paste the following code into R:  

```R
library(iemiscdata)

utils::browseVignettes("iemiscdata")
```


# Package Contents

This package currently contains 93 data sets:  

* `nchannel`: Manning's n for Channels (Chow, 1959)
* `npartfull`: Manning's n for Closed Conduits Flowing Partly Full (Chow, 1959)
* `nmetalpipe`: Manning's n for Corrugated Metal Pipe (AISI, 1980)
* `nsheetflow`: Table 3-1: Roughness coefficients (Manning's n) for sheet flow
* `nsheetflow_notes`: Notes for Table 16-2 Computation of coordinates for unit hydrograph for use in example 16-1
* `r* (3 data sets)`: Nominal Interest Rate Tables (Engineering Economics)
    * `r8`: 8 Percent Nominal Interest Table (Engineering Economy)
    * `r10`: 10 Percent Nominal Interest Table (Engineering Economy)
    * `r20`: 20 Percent Nominal Interest Table (Engineering Economy)
* `i* (19 data sets)`: Effective Interest Rate Tables (Engineering Economics)
    * `i1`: 1 Percent Effective Interest Table (Engineering Economy)
    * `i2`: 2 Percent Effective Interest Table (Engineering Economy)
    * `i3`: 3 Percent Effective Interest Table (Engineering Economy)
    * `i4`: 4 Percent Effective Interest Table (Engineering Economy)
    * `i5`: 5 Percent Effective Interest Table (Engineering Economy)
    * `i6`: 6 Percent Effective Interest Table (Engineering Economy)
    * `i7`: 7 Percent Effective Interest Table (Engineering Economy)
    * `i8`: 8 Percent Effective Interest Table (Engineering Economy)
    * `i9`: 9 Percent Effective Interest Table (Engineering Economy)
    * `i10`: 10 Percent Effective Interest Table (Engineering Economy)
    * `i12`: 12 Percent Effective Interest Table (Engineering Economy)
    * `i15`: 15 Percent Effective Interest Table (Engineering Economy)
    * `i18`: 18 Percent Effective Interest Table (Engineering Economy)
    * `i20`: 20 Percent Effective Interest Table (Engineering Economy)
    * `i25`: 25 Percent Effective Interest Table (Engineering Economy)
    * `i_25`: 1/4 Percent Effective Interest Table (Engineering Economy)
    * `i_50`: 1/2 Percent Effective Interest Table (Engineering Economy)
    * `i_75`: 3/4 Percent Effective Interest Table (Engineering Economy)
    * `i1_50`: 1 1/2 Percent Effective Interest Table (Engineering Economy)
* `pres_elect`: USA Presidential Elections Results (Wikipedia)
* `Fp`: Table 4-2: Adjustment factor (Fp) for pond and swamp areas that are spread throughout the watershed
* `Fukushima_2011_FieldMeasurements_5_Metadata`: US DOE/NNSA and DoD Response to 2011 Fukushima Incident: Field Team Radiological Measurements Metadata
* `Fukushima_2011_FieldMeasurements_5`: US DOE/NNSA and DoD Response to 2011 Fukushima Incident: Field Team Radiological Measurements
* `Fukushima_2011_FieldSampleAirResults_2_Metadata`: US DOE/NNSA and DoD Response to 2011 Fukushima Incident: Radiological Air Samples Metadata
* `Fukushima_2011_FieldSampleAirResults_2`: US DOE/NNSA and DoD Response to 2011 Fukushima Incident: Radiological Air Samples
* `Fukushima_2011_FieldSampleInstrumentResults_Metadata`: US DOE/NNSA Response to 2011 Fukushima Incident: Instrument Samples (InSitu Measurements) Metadata
* `Fukushima_2011_FieldSampleInstrumentResults`: US DOE/NNSA Response to 2011 Fukushima Incident: Instrument Samples (InSitu Measurements)
* `Fukushima_2011_FieldSampleSoilResults_2_Metadata`: US DOE/NNSA and DoD Response to 2011 Fukushima Incident: Radiological Soil Samples Metadata
* `Fukushima_2011_FieldSampleSoilResults_2`: US DOE/NNSA and DoD Response to 2011 Fukushima Incident: Radiological Soil Samples
* `Ia`: Table 4-1: Ia values for runoff Curve number
* `USAEC_facilities_nuclear_accidents`: Criticality Accidents in USAEC Facilities, 1945-1970 (Trinity Atomic Web Site)
* `USA_primary_water_contaminants_notes`: US EPA National Primary Drinking Water Regulations Contaminants Notes
* `USA_primary_water_contaminants`: US EPA National Primary Drinking Water Regulations Contaminants
* `USA_secondary_water_contaminants_notes`: US EPA Secondary Drinking Water Standards Notes
* `USA_secondary_water_contaminants`: US EPA Secondary Drinking Water Standards
* `c_agricultural`: Table 2: Values of Runoff Coefficient C in Agricultural Areas
* `c_urban`: Table 1: Values of Runoff Coefficient C in Urban Areas
* `civilian_nuclear_accidents_wiki`: Civilian nuclear accidents (Wikipedia)
* `cn_agricultural_notes`: Notes for Table 2-2b: Runoff curve numbers for cultivated agricultural lands
* `cn_agricultural`: Table 2-2b: Runoff curve numbers for cultivated agricultural lands
* `cn_arid_semiarid_notes`: Notes for Table 2-2d: Runoff curve numbers for arid and semiarid rangelands
* `cn_arid_semiarid`: Table 2-2d: Runoff curve numbers for arid and semiarid rangelands
* `cn_other_agricultural_notes`: Notes for Table 2-2c: Runoff curve numbers for other agricultural lands
* `cn_other_agricultural`: Table 2-2c: Runoff curve numbers for other agricultural lands
* `cn_urban_notes`: Notes for Table 2-2a: Runoff curve numbers for urban areas
* `cn_urban`: Table 2-2a: Runoff curve numbers for urban areas
* `common_gases_simp`: Common Gaseous Elements and Compounds Simplified
* `common_gases`: Common Gaseous Elements and Compounds
* `dry_air`: Gaseous Composition of Dry Air
* `duh_gamma`: Table 16-5 Relationship of m and PRF for DUH developed from a Gamma equation
* `elements`: Period Table of the Elements (PubChem & Wikipedia) 
* `elements_pubchem`: Period Table of the Elements (PubChem)
* `elements_wiki`: Period Table of the Elements (Wikipedia)
* `exceptional_tn_waters_abbrv`: Abbreviations Used in the Known Exceptional Tennessee Waters and Outstanding National Resource Waters
* `exceptional_tn_waters`: Known Exceptional Tennessee Waters and Outstanding National Resource Waters
* `gas_constant`: Gas Constant in Various Units
* `gases_plain`: Gases at Standard Temperature and Pressure (STP) {Wikipedia} -- Plain
* `gases_table`: Gaseous Elements and Compounds
* `gases`: Gases at Standard Temperature and Pressure (STP) {Wikipedia}
* `greenhouse_gases_cloudy_sky`: Clear and cloudy sky radiative forcing (W m-2) and the contribution of individual absorbers to this total
* `greenhouse_gases_cloudy_wikipedia`: Greenhouse Gases -- Percent Contribution to Total Greenhouse Effect (Wikipedia)
* `greenhouse_gases_cloudy_notes_wikipedia`: Greenhouse Gases -- Percent Contribution to Total Greenhouse Effect Notes (Wikipedia)
* `greenhouse_gases_contributions`: Greenhouse Gases -- Percent Contribution to Total Greenhouse Effect (NASA)
* `hsg_definitions`: Table from Appendix A: Definitions of Hydrologic Soil Groups (HSGs)
* `hsg`: Table from Appendix A: Hydrologic Soil Groups (HSGs)
* `military_nuclear_accidents_wiki`: Military nuclear accidents (Wikipedia)
* `norfolk_southern_epoh`: United States EPA East Palestine, Ohio Norfolk Southern Train 32N Cargo List
* `nuclear_accidents_ranked`: Ranked Nuclear & Radiation Accidents and incidents (The Guardian)
* `nuclear_accidents_wiki`: Nuclear and radiation accidents and incidents (Wikipedia)
* `nuclear_accidents`: Nuclear & Radiation Accidents and incidents (The Guardian)
* `nuclear_power_accidents_country_wiki`: Nuclear power accidents by country (Wikipedia)
* `pres_cont_congress`: United States President of the Continental Congress
* `pres_elect`: Wikipedia Table of the United States of America Presidential Elections
* `raddata_US_Fukushima_2011`: US EPA Envirofacts RadNet (Radiation in the US)
* `raddata_usa_territories_Fukushima_2011`: United States EPA Radiation Readings from 1 March 2011 to 22 April 2011
* `rainfall_distribution_equation_coefficients`: Table F-2 Coefficients for the equation used to generate figure 6-1
* `rainfall_type_equation_coefficients`: Table F-1 Coefficients for the equation used to generate exhibits 4-I through 4-III
* `riprap_table_ft`: Tennessee Department of Transportation (TDOT) Machined riprap Table (feet)
* `riprap_table_in`: Tennessee Department of Transportation (TDOT) Machined riprap Table (inches)
* `riprap_table_mm`: Tennessee Department of Transportation (TDOT) Machined riprap Table (millimeters)
* `riprap_table_yd`: Tennessee Department of Transportation (TDOT) Machined riprap Table (yards)
* `runoff_depth_notes`: Notes for Table 2-1: Runoff depth for selected CN's and rainfall amounts
* `runoff_depth`: Table 2-1: Runoff depth for selected CN's and rainfall amounts
* `uh_ratios_masscurve`: Table 16-1: Ratios for dimensionless unit hydrograph and mass curve
* `uh_ratios`: Table 16-2 Computation of coordinates for unit hydrograph for use in example 16-1
* `water_vapour_pressure`: Vapour Pressure of Water (Wikipedia)



# Examples (see more examples in the vignettes)

```R
install.load::load_package("iemisc", "iemiscdata", "round")
# load needed packages using the load_package function from the install.load
# package (it is assumed that you have already installed these packages)


# Example 1

# Future value given present value
FgivenP(8330, 6, 10, frequency = "annual") # the interest rate is 10%

# or

P <- 8330
P * i10[n == 6, "F/P"][[1]]
# use i10 for the 10 percent effective interest table values
# n == 6 is the row number
# "F/P" provides the column number in a data.table
# [[1]] provides a vector result

FgivenP(8330, 6, 10, frequency = "annual") == round_r3(P * i10[n == 6, "F/P"][[1]], d = 1)
# [1] TRUE




# Example 2

# Future value given annual value with continuously compounded interest
FgivenAcont(4500, 5, 20) # 20% interest

# or

F <- 4500 
F * r20[n == 5, "F/A"][[1]]
# use r20 for the 20 percent nominal interest table values
# n == 5 is the row number
# "F/A" provides the column number in a data.table
# [[1]] provides a vector result

FgivenAcont(4500, 5, 20) == round_r3(F * r20[n == 5, "F/A"][[1]], d = 2)
# [1] TRUE
```



# Disclaimer

This software is provided &ldquo;AS IS&rdquo;. See the GPL License for more information.  



# License

iemiscdata is distributed under the GPL-3 (or later) license, as stated in the DESCRIPTION file. For more info, see the [GNU General Public License (GPL) page](https://www.gnu.org/licenses/gpl-3.0.html).  



# Donations Accepted

If you want to support the continued development of this and my other R packages, feel free to:  

<p><script src="https://liberapay.com/iaembry/widgets/button.js"></script>
<noscript><a href="https://liberapay.com/iaembry/donate"><img alt="Donate using Liberapay" src="https://liberapay.com/assets/widgets/donate.svg"></a></noscript></p>
