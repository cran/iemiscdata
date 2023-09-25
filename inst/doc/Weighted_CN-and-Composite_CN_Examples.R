## ---- warning = FALSE, message = FALSE, tidy = TRUE---------------------------

install.load::load_package("iemiscdata", "iemisc", "round", "data.table")
# load needed packages using the load_package function from the install.load package (it is assumed that you have already installed these packages)

data(cn_other_agricultural)

# locate the row where "Hydrologic condition" == "Good" & "Cover type" %like% "Pasture, grassland, or range--continuous forage for grazing"
CNlocation1 <- cn_other_agricultural[cn_other_agricultural$"Hydrologic condition" == "Good" & cn_other_agricultural$"Cover type" %like% "Pasture, grassland, or range--continuous forage for grazing"]

CN1 <- CNlocation1$"Curve numbers for hydrologic soil group C"

CN1



# locate the row where "Hydrologic condition" == "Good" & "Cover type" %like% "Pasture, grassland, or range--continuous forage for grazing"
CNlocation2 <- cn_other_agricultural[cn_other_agricultural$"Hydrologic condition" == "Good" & cn_other_agricultural$"Cover type" %like% "Pasture, grassland, or range--continuous forage for grazing"]

CN2 <- CNlocation2$"Curve numbers for hydrologic soil group B"

CN2



CNa <- c(CN1, CN2)

area_pct1 <- c(0.70, 0.30)
weighted_CN(CN = CNa, area_pct = area_pct1)

## ---- warning = FALSE, message = FALSE, tidy = TRUE---------------------------

data(cn_urban)

# locate the row where "Cover type and hydrologic condition" == "1/2 acre"
CNlocation1 <- cn_urban[cn_urban$"Cover type and hydrologic condition" == "1/2 acre", ]


CN1 <- CNlocation1$"Curve numbers for hydrologic soil group B"

CN1




# locate the row where "Cover type and hydrologic condition" == "1/2 acre"
CNlocation2 <- cn_urban[cn_urban$"Cover type and hydrologic condition" == "1/2 acre", ]


CN2 <- CNlocation2$"Curve numbers for hydrologic soil group C"

CN2



# locate the row where "Cover type and hydrologic condition" == "Good condition (grass cover > 75%)"
CNlocation3 <- cn_urban[cn_urban$"Cover type and hydrologic condition" == "Good condition (grass cover > 75%)", ]


CN3 <- CNlocation3$"Curve numbers for hydrologic soil group C"

CN3



CNb <- c(CN1, CN2, CN3)

area_pct2 <- c(0.30, 0.40, 0.30)
weighted_CN(CN = CNb, area_pct = area_pct2)

## ---- warning = FALSE, message = FALSE, tidy = TRUE---------------------------

# locate the row where "Cover type and hydrologic condition" == "1/2 acre"
CNlocation1 <- cn_urban[cn_urban$"Cover type and hydrologic condition" == "1/2 acre", ]


CN1 <- CNlocation1$"Curve numbers for hydrologic soil group B"

CN1


# obtain the composite CN at 35%
CN1_new <- c_composite_CN(CN1, impervious = 35)

CN1_new



# locate the row where "Cover type and hydrologic condition" == "1/2 acre"
CNlocation2 <- cn_urban[cn_urban$"Cover type and hydrologic condition" == "1/2 acre", ]


CN2 <- CNlocation2$"Curve numbers for hydrologic soil group C"

CN2


# obtain the composite CN at 35%
CN2_new <- c_composite_CN(CN2, impervious = 35)

CN2_new



# locate the row where "Cover type and hydrologic condition" == "Good condition (grass cover > 75%)"
CNlocation3 <- cn_urban[cn_urban$"Cover type and hydrologic condition" == "Good condition (grass cover > 75%)", ]


CN3 <- CNlocation3$"Curve numbers for hydrologic soil group C"

CN3



CNc <- c(CN1_new, CN2_new, CN3)

area_pct3 <- c(0.30, 0.40, 0.30)
weighted_CN(CN = CNc, area_pct = area_pct3)

## ---- warning = FALSE, message = FALSE, tidy = TRUE---------------------------

# locate the row where "Cover type and hydrologic condition" == "1/2 acre"
CNlocation1 <- cn_urban[cn_urban$"Cover type and hydrologic condition" == "1/2 acre", ]


CN1 <- CNlocation1$"Curve numbers for hydrologic soil group B"

CN1




# locate the row where "Cover type and hydrologic condition" == "1/2 acre"
CNlocation2 <- cn_urban[cn_urban$"Cover type and hydrologic condition" == "1/2 acre", ]


CN2 <- CNlocation2$"Curve numbers for hydrologic soil group C"

CN2


# obtain the composite CN at 25%
CN2_new <- uc_composite_CN(CN2, impervious = 25, R = 50 / 100)

CN2_new




# locate the row where "Cover type and hydrologic condition" == "Good condition (grass cover > 75%)"
CNlocation3 <- cn_urban[cn_urban$"Cover type and hydrologic condition" == "Good condition (grass cover > 75%)", ]


CN3 <- CNlocation3$"Curve numbers for hydrologic soil group C"

CN3



CNc <- c(CN1, CN2_new, CN3)

area_pct4 <- c(0.30, 0.40, 0.30)
weighted_CN(CN = CNc, area_pct = area_pct4)

