## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------
install.load::load_package("iemiscdata", "data.table", "iemisc", "rivr", "units")
# load needed packages using the load_package function from the install.load package (it is assumed that you have already installed these packages)

## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------
# Use grep to find the row number matching the given description
# Use nchannel$"Type of Channel and Description" to select the column to search through
# Use nchannel[nlocation, 4] to select the row number from nlocation and column 4
# Similar steps are performed for each of these examples


# The 1st heading is "Manning's n for Channels"
# The 2nd heading is "Natural streams - minor streams (top width at floodstage < 100 ft)"
# The 3rd heading is "Mountain streams, no vegetation in channel, banks usually steep, trees and brush along banks submerged at high stages"
# The 4th heading is "bottom: gravels, cobbles, and few boulders"

data(nchannel)

# locate the row where "Type of Channel and Description" == "bottom: gravels, cobbles, and few boulders"
nlocation1 <- nchannel[nchannel$"Type of Channel and Description" %like% "bottom: gravels, cobbles, and few boulders", ]


n1 <- nlocation1$"Maximum n"

n1

## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------


# The 1st heading is "Manning's n for Closed Conduits Flowing Partly Full"
# The 2nd heading is "Wood"
# The 3rd heading is "Stave"

data(npartfull)

# locate the row where "Type of Conduit and Description" %like% "Stave"
nlocation2 <- npartfull[npartfull$"Type of Conduit and Description" %like% "Stave", ]

n2 <- nlocation2$"Minimum n"

n2

## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------

# The 1st heading is "Manning's n for Corrugated Metal Pipe"
# The 2nd heading is "Corrugations 6x2 inches"
# The 3rd heading is "Corrugations 6x2 inches – 60\"\" diameter"

data(nmetalpipe)

# locate the row where "Type of Pipe and Diameter and Corrugation Dimension" %like% "Corrugations 6x2 inches – 60\"\" diameter"
nlocation3 <- nmetalpipe[nmetalpipe$"Type of Pipe and Diameter and Corrugation Dimension" %like% "Corrugations 6x2 inches – 60\"\" diameter", ]

n3 <- nlocation3$"n"

n3

## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------

# The 1st heading is "Manning's n for Channels"
# The 2nd heading is "Natural streams - minor streams (top width at floodstage < 100 ft)"
# The 3rd heading is "Excavated or Dredged Channels"
# The 4th heading is "Earth, straight, and uniform"
# The 5th heading is "clean, recently completed"


# Using the data for the M1 profile example in rivr's compute_profile, except for the value of n to find the channel condition

# locate the row where "Type of Channel and Description" == "bottom: gravels, cobbles, and few boulders"
nlocation4 <- nchannel[nchannel$"Type of Channel and Description" %like% "clean, recently completed", ]


n4 <- nlocation4$"Maximum n"

n4


compute_profile(0.001, n4, 250, 2.7, 1.486, 32.2, 100, 0, stepdist = 50, totaldist = 3000)

## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------

# Let's assume that the channel from Example 4 has a trapezoidal shape with a
# slope of m (see below).

m <- 1 / 0.8390996

critical_y <- Manningtrap_critical(Q = 250, b = 100, m = m, Sf = 0.001, n = n4, units = "Eng",
type = "symmetrical", critical = "accurate", output = "data.table")

## ----warning = FALSE, message = FALSE, tidy = TRUE----------------------------

# Given "dense grass", the table has "Dense grasses"

# locate the row where "Surface description" %like% "Dense grass"
nlocation5 <- nsheetflow[nsheetflow$"Surface description" %like% "Dense grass", ]


n5 <- nlocation5$"n *1"

n5

