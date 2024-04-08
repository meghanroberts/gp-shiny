library(tidyverse)
library(leaflet)
library(sf)


# wrangling map data
map_dat <- master %>% 
  filter(pop == "fall_chinook",
         n_diff > 1) %>% 
  group_by(noa_sbb) %>% 
  slice(which.min(cb_rati)) %>% 
  ungroup() %>% 
  mutate(cb_rati = paste0(format(round(cb_rati), big.mark = ","))) %>% 
  st_transform(4326)

NA_subs <- master %>% 
  filter(is.na(pop)) %>% 
  st_transform(4326)



# leaflet
leaflet(map_dat) %>%  
  # add tiles
  addProviderTiles(providers$Esri.WorldImagery) %>%  
  # add mini map
  addMiniMap(toggleDisplay = TRUE, minimized = FALSE) |>
  # add markers
  addPolygons(
    data = map_dat,
    weight = 1,
    color = "black",
    opacity = 1, 
    fillColor = "cyan",
    fillOpacity = 0.7,
             popup = paste0("Subbasin Name: ", map_dat$sbbsn_n, "<br>",
                            "Action: ", map_dat$rst_typ, "<br>",
                            "Cost Effectiveness Ratio: ", "$", map_dat$cb_rati, "/Chinook", "<br>",
                            "Average Cost: ", "$ ", map_dat$ttl_vg_, "<br>",
                            "# of Spawners: ", map_dat$n_diff)) %>% 
  addPolygons(
    data = NA_subs,
    weight = 1,
    color = "black",
    opacity = 1, 
    fillColor = "grey",
    fillOpacity = 0.7,
    popup = paste("Subbasin Name: ", map_dat$sbbsn_n, "<br>",
                   "Action: NA", "<br>",
                   "Cost Effectiveness Ratio: NA", "<br>",
                   "Average Cost: NA", "<br>",
                   "# of Spawners: NA")) 
