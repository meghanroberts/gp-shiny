#..............................SETUP.............................

# load packages ----
library(tidyverse)
library(leaflet)
library(sf)

# read in data ----
demo<-read_sf(here::here("myapp", "data", "processed", "demo_transformed.shp"))

#..........................PRACTICE VIZ..........................

leaflet() |> 
  
  # add tiles
  addProviderTiles(providers$Esri.WorldImagery) |> 
  
  # set view over Stilly
  setView(lng = -121.9, lat = 48.15, zoom = 9) |> 
  
  # add mini map
  addMiniMap(toggleDisplay = TRUE, minimized = FALSE) |> 
  
  addPolygons(
    data = map_data,
    weight = 2,
    color = "black",
    opacity = 1, 
    fillColor = "grey",
    fillOpacity = 0.7,
    popup = paste0("<strong>", "Subbasin Name: ", "</strong>", map_data$sbbsn_n, "<br>",
                   "<em>", "no predicted increase in spawners", "</em>")) %>% 
  
  # add polygons
  addPolygons(data = demo,
              color = "#838393",    # outline color
              fillColor = "#373870",  # fill color
              fillOpacity = 0.7,  # fill opacity
              weight = 2,      # outline weight
              popup = ~paste("Total Score: ", demo$Sbb_Tt_S,
                             "POC Score: ", demo$Sb_POC_,
                             "Poverty Score: ", demo$Sbb_Pv_,
                             "Unemployment Score: ", demo$Sbb_Un_,
                             "Tribal Presence: ", demo$Sbb_Tr_S))

