library(tidyverse)
library(leaflet)
library(sf)


# wrangling map data

# subbasins with benefits and actions
map_data <- master %>% 
  filter(pop == "fall_chinook",
         n_diff > 1) %>% 
  group_by(noa_sbb) %>% 
  slice(which.min(cb_rati)) %>% 
  ungroup() %>% 
  mutate(cb_rati = paste0(format(round(cb_rati), big.mark = ",")),
         ttl_vg_ = paste0(format(round(ttl_vg_), big.mark = ",")),
         ttl_lw_ = paste0(format(round(ttl_lw_), big.mark = ",")),
         ttl_pp_ = paste0(format(round(ttl_pp_), big.mark = ","))) %>% 
  st_transform(4326)

write_sf(map_data, here("myapp", "data", "processed", "map_data", "map_data.shp"))

# subbasins with no benefits or actions
NA_subs <- master %>% 
  filter(is.na(pop)) %>% 
  st_transform(4326)

write_sf(NA_subs, here("myapp", "data", "processed", "map_data", "NA_subs.shp"))



# leaflet
leaflet(map_data) %>%  
  # addTiles() %>% 
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
             popup = paste0("<strong>", "Subbasin Name: ", "</strong>", map_dat$sbbsn_n, "<br>",
                            "<strong>", "Action: ", "</strong>", map_dat$rst_typ, "<br>",
                            "<strong>", "Cost Effectiveness Ratio: ", "</strong>", "$", map_dat$cb_rati, "/Chinook", "<br>",
                            "<strong>", "Average Cost: ", "</strong>", "$ ", map_dat$ttl_vg_, "<br>",
                            "<strong>", "# of Spawners: ", "</strong>", map_dat$n_diff)) %>% 
  addPolygons(
    data = NA_subs,
    weight = 1,
    color = "black",
    opacity = 1, 
    fillColor = "grey",
    fillOpacity = 0.7,
    popup = paste0("<strong>", "Subbasin Name: ", "</strong>", map_dat$sbbsn_n, "<br>",
                   "<strong>", "Action: ", "</strong>", "NA", "<br>",
                   "<strong>", "Cost Effectiveness Ratio: ", "</strong>", "NA", "<br>",
                   "<strong>", "Average Cost: ", "</strong>", "NA", "<br>",
                   "<strong>", "# of Spawners: ", "</strong>", "NA")) %>% 
  addScaleBar(position = "bottomleft")
