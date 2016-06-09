## ------------------------------------------------------------------------
library(iemiscdata)

# Use grep to find the row number matching the given description
# Use nchannel$"Type of Channel and Description" to select the column to search
# through
# Use nchannel[nlocation, 4] to select the row number from nlocation and
# column 4
# Similar steps are performed for each of these examples

# Example 1
# What is the maximum Manning's n value for 1) Natural streams - minor streams
# (top width at floodstage < 100 ft), 2) Mountain streams, no vegetation
# in channel, banks usually steep, trees and brush along banks submerged at
# high stages and 3) bottom: gravels, cobbles, and few boulders?
data(nchannel)

nlocation <- grep("bottom: gravels, cobbles, and few boulders",
nchannel$"Type of Channel and Description")
n <- nchannel[nlocation, 4] # 4 for column 4 - Maximum n


# Example 2
# What is the minimum Manning's n value for 1) Closed Conduits Flowing Partly
# Full, 2) Wood and 3) Stave?
data(npartfull)

nlocation <- grep("Stave",
npartfull$"Type of Conduit and Description")
n <- npartfull[nlocation, 2] # 2 for column 2 - Minimum n


# Example 3
# What is the Manning's n value for 1) Corrugated Metal Pipe,
# 2) Corrugations 6x2 inches and 3) 60" diameter?
data(nmetalpipe)
nnear <- grep("Corrugations 6x2 inches",
nmetalpipe$"Type of Pipe, Diameter and Corrugation Dimension")
# nnear is the row number matching the description
nlocation <- nlocation[which(grep("60\"\" diameter",
nmetalpipe$"Type of Pipe, Diameter and Corrugation Dimension") > nnear)]
# which provides all locations matching the description
# > nnear gives the row number(s) greater than nnear since the requested
# diameter is in the section located after nnear
n <- nmetalpipe[nlocation, 2] # 2 for column 2 - n


# Example 4
# Example to compute the "gradually-varied flow profile of a prismatic
# channel" with these channel conditions used to find Manning's n (normal):
# 1) Natural streams - minor streams (top width at floodstage < 100 ft),
# 2) Excavated or Dredged Channels, 3) Earth, straight, and uniform, &
# 4) clean, recently completed.
# Quote source: rivr's compute_profile

# Using the data for the M1 profile example in rivr's compute_profile, except
# for the value of n

library(rivr)
# to find the channel condition
nlocation <- grep("clean, recently completed",
nchannel$"Type of Channel and Description")
# use grep to find the n's row number
n <- nchannel[nlocation, 3] # 3 for column 3 - Normal n

compute_profile(0.001, n, 250, 2.7, 1.486, 32.2, 100, 0, stepdist = 50,
totaldist = 3000)

