## ----warning = FALSE, message = FALSE, tidy = TRUE, out.width = "100%", out.height = "100%"----
install.load::load_package("iemiscdata", "iemisc", "USA.state.boundaries", "ggplot2", "sfheaders", "sf", "dplyr", "data.table")
# load needed packages using the load_package function from the install.load package (it is assumed that you have already installed these packages)

# load the exceptional_tn_waters data from iemiscdata (containing the Exceptional Tennessee Waters)
data(exceptional_tn_waters)

# load the state_boundaries_wgs84 data from USA.state.boundaries (for the US map)
data(state_boundaries_wgs84)



# determine all states that have a river source or end point
states1 <- unique(lat_long2state(na.omit(exceptional_tn_waters$From_Lat), na.omit(exceptional_tn_waters$From_Long)))

states2 <- unique(lat_long2state(na.omit(exceptional_tn_waters$To_Lat), na.omit(exceptional_tn_waters$To_Long)))

get_states <- unique(states1, states2)



# subset all states that have a river source or end point from state_boundaries_wgs84 
river_states <- subset(state_boundaries_wgs84, NAME %in% get_states)
# Source 1 / subset for Southeast states only

states_map <- st_as_sf(river_states, crs = "+proj=longlat +datum=NAD83")



# add an id column to exceptional_tn_waters
exceptional_tn_waters_map <- exceptional_tn_waters[, id := seq(nrow(exceptional_tn_waters))]

# Source 2 begins
# the data has to be in long form to use sfheaders
tn_dt1 <- exceptional_tn_waters[, .(id, lon = From_Long, lat = From_Lat)]

tn_dt2 <- exceptional_tn_waters[, .(id, lon = To_Long, lat = To_Lat)]


# Add a "sequence" variable to identify which one occurs first
tn_dt1[, sequence := 1L ]
tn_dt2[, sequence := 2L ]


# rbind the data.tables
exceptional_tn_waters_map2 <- rbindlist(list(tn_dt1, tn_dt2), use.names = TRUE)


# set the row ordering
setorder(exceptional_tn_waters_map2, id, sequence)
# Source 2 ends

map1 <- exceptional_tn_waters_map2

# Source 3 begins
map2 <- map1 %>% 
  st_as_sf(coords = c("lon", "lat"), na.fail = FALSE, crs = "epsg:4326") %>% 
  group_by(id) %>% 
  summarize() %>%
  filter(st_geometry_type(.) == "MULTIPOINT") %>%
  st_cast("MULTILINESTRING")
# Source 3 ends


p <- ggplot() + geom_sf(data = states_map, colour = "black", fill = "white")
p <- p + geom_sf(data = map2, colour = "blue")
p <- p + labs(x = "", y = "", title = "Tennessee Exceptional Waters Map")
print(p)

