### SUMMARY 


ord <- factor(unique(map_data$rst_typ), levels = c('Floodplain', 'Engineered Log Jams', 'Riparian Planting'))
palette_summ = c("#03045E", "#19647E", "#28AFB0")
summ_palette <- colorFactor(palette = palette_summ, levels = ord, ordered = FALSE)



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
    weight = 2,
    color = "black",
    fillOpacity = 1, 
    fillColor = ~summ_palette(rst_typ),
    popup = paste0("<strong>", "Subbasin Name: ", "</strong>", map_data$sbbsn_n, "<br>",
                   "<strong>", "Action: ", "</strong>", map_data$rst_typ, "<br>",
                   "<strong>", "Cost Effectiveness Ratio: ", "</strong>", "$", map_data$cb_rati, "/Chinook", "<br>",
                   "<strong>", "Average Cost: ", "</strong>", "$ ", map_data$ttl_vg_, "<br>",
                   "<strong>", "# of Spawners: ", "</strong>", map_data$n_diff)) %>% 
  addLegend(position = "bottomright", pal = summ_palette, values = ~rst_typ, title = "Restoration Type") %>% 
  
  addPolygons(
    data = NA_subs,
    weight = 1,
    color = "black",
    fillColor = "grey",
    fillOpacity = 0.7,
    popup = paste0("<strong>", "Subbasin Name: ", "</strong>", map_data$sbbsn_n, "<br>",
                   "<em>", "no predicted increase in spawners", "</em>")) %>% 
  addScaleBar(position = "bottomleft") 


##START OF DEMO MAP

palette = c("blue", "green")

color_palette <- colorNumeric(palette = palette, domain = demo$Sbb_Tt_S)

demo_map<-leaflet(demo) |> 
  
  # add tiles
  addProviderTiles(providers$Esri.WorldImagery) |> 
  
  # set view over Stilly
  setView(lng = -121.9, lat = 48.15, zoom = 9) |> 
  
  # add mini map
  addMiniMap(toggleDisplay = TRUE, minimized = FALSE) |> 
  
  # add polygons
  addPolygons(data = demo,
              color = "black",    # outline color
              # fillColor = "cyan",  # fill color
              fillColor = ~color_palette(Sbb_Tt_S),  # fill color based on the Sbb_Tt_S variable
              fillOpacity = 0.7,  # fill opacity
              weight = 2,      # outline weight
              popup = ~paste("<strong>", "Subbasin Name: ", "</strong>", map_data$sbbsn_n,"<br>",
                             "<strong>", "Total Score: ", "</strong>", demo$Sbb_Tt_S,"<br>",
                             "<strong>", "POC Score: ", "</strong>", demo$Sb_POC_,"<br>",
                             "<strong>", "Poverty Score: ", "</strong>", demo$Sbb_Pv_,"<br>",
                             "<strong>", "Unemployment Score: ", "</strong>", demo$Sbb_Un_,"<br>",
                             "<strong>", "Presence of Tribal Lands: ", "</strong>", demo$Sbb_Tr_S)) |> 
  addPolygons(
                               data = NA_subs,
                               weight = 1,
                               color = "black",
                               opacity = 1, 
                               fillColor = "grey",
                               fillOpacity = 0.7,
                               popup = paste0("<strong>", "Subbasin Name: ", "</strong>", map_data$sbbsn_n, "<br>",
                                              "<em>", "unlikely candidate for Chinook habitat restoration", "</em>")) %>% 
  addScaleBar(position = "bottomleft")

