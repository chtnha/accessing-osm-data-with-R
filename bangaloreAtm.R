#install the osmdata, sf, tidyverse and ggmap packages
if(!require("osmdata")) install.packages("osmdata")
if(!require("tidyverse")) install.packages("tidyverse")
if(!require("sf")) install.packages("sf")
if(!require("ggmap")) install.packages("ggmap")

#load packages
library(tidyverse)
library(osmdata)
library(sf)
library(ggmap)

#check available features
head(available_features())

#Available tags in OSM
head(available_tags("amenity"))

#building the query
bangaloreAtm <- getbb(place_name = "Bangalore", display_name_contains = "Bengaluru") %>% opq() %>% add_osm_feature("amenity", "atm")

#check the built query
str(bangaloreAtm)

#building the same query with more timeout session
bangaloreAtm <- getbb(place_name = "Bangalore", display_name_contains = "Bengaluru") %>% opq(timeout = 400) %>% add_osm_feature("amenity", "atm")

#assign queried object to atm and call it
all_atm <- osmdata_sf(bangaloreAtm)

str(all_atm)

#plot final map
ggmap(bangalore_map) + 
  geom_sf(data = all_atm$osm_points, 
          inherit.aes = FALSE, 
          colour = "#20755151", 
          fill = "#741AEC", 
          alpha = .5, 
          size = 0.75, 
          shape = 21) + labs(x = "", y = "")




