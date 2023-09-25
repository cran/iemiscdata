## ---- warning = FALSE, message = FALSE, tidy = TRUE, out.width = "100%", out.height = "100%"----
install.load::load_package("iemiscdata", "USA.state.boundaries", "data.table", "ggplot2", "sf")
# load needed packages using the load_package function from the install.load package (it is assumed that you have already installed these packages)

# load the raddata_US_Fukushima_2011 data from iemiscdata {containing the US EPA Envirofacts RadNet (Radiation in the US)}
data(raddata_US_Fukushima_2011)

# load the state_boundaries_wgs84 data from USA.state.boundaries (for the US map)
data(state_boundaries_wgs84)



# remove the missing rows with location information missing
raddata_US_Fukushima_2011 <- raddata_US_Fukushima_2011[-which(is.na(raddata_US_Fukushima_2011$"Location 1 (Longitude)") | is.na(raddata_US_Fukushima_2011$"Location 1 (Latitude)")), ]




## USA

USA <- state_boundaries_wgs84
# create the USA object with the same data as state_boundaries_wgs84

USA_projected <- st_transform(USA, "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0")
# transform the coordinates to match those of the USA_state_boundaries_map data from USA.state.boundaries.data (formerly in USA.state.boundaries)


locations <- st_as_sf(raddata_US_Fukushima_2011, coords = c("Location 1 (Longitude)", "Location 1 (Latitude)"), crs = "+proj=longlat +datum=WGS84 +ellps=WGS84")
# set the projection to longlat using sf

# plot the map using ggplot2
p <- ggplot() + geom_sf(data = USA, colour = "black", fill = "white")
p <- p + geom_sf(data = locations, colour = "#3591d1", size = 0.5) + coord_sf(xlim = c(-60, -170), ylim = c(0, 80), expand = FALSE)
# Source 1
p <- p + labs(x = "", y = "", title = "2011 Fukushima Radiation Sample Locations within the USA")
print(p)

