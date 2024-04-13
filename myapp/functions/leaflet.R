
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
                   "<em>", "no predicted increase in spawners", "</em>")) %>% 
  addScaleBar(position = "bottomleft")


demo_map<-leaflet(demo) |> 
  
  # add tiles
  addProviderTiles(providers$Esri.WorldImagery) |> 
  
  # set view over Stilly
  setView(lng = -121.9, lat = 48.15, zoom = 9) |> 
  
  # add mini map
  addMiniMap(toggleDisplay = TRUE, minimized = FALSE) |> 
  
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

