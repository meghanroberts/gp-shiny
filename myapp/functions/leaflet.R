
# creating a leaflet function 
leaflet <- 
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