
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
    data = map_data,
    weight = 1,
    color = "black",
    opacity = 1, 
    fillColor = "cyan",
    fillOpacity = 0.7,
    popup = paste0("<strong>", "Subbasin Name: ", "</strong>", map_data$sbbsn_n, "<br>",
                   "<strong>", "Action: ", "</strong>", map_data$rst_typ, "<br>",
                   "<strong>", "Cost Effectiveness Ratio: ", "</strong>", "$", map_data$cb_rati, "/Chinook", "<br>",
                   "<strong>", "Average Cost: ", "</strong>", "$ ", map_data$ttl_vg_, "<br>",
                   "<strong>", "# of Spawners: ", "</strong>", map_data$n_diff)) %>% 
  addPolygons(
    data = NA_subs,
    weight = 1,
    color = "black",
    opacity = 1, 
    fillColor = "grey",
    fillOpacity = 0.7,
    popup = paste0("<strong>", "Subbasin Name: ", "</strong>", map_data$sbbsn_n, "<br>",
                   "<strong>", "Action: ", "</strong>", "NA", "<br>",
                   "<strong>", "Cost Effectiveness Ratio: ", "</strong>", "NA", "<br>",
                   "<strong>", "Average Cost: ", "</strong>", "NA", "<br>",
                   "<strong>", "# of Spawners: ", "</strong>", "NA")) %>% 
  addScaleBar(position = "bottomleft")
