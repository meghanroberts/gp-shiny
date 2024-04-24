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
                   "<strong>", "Average Cost: ", "</strong>", "$", map_data$ttl_vg_, "<br>",
                   "<strong>", "# of Spawners: ", "</strong>", map_data$n_diff)) %>% 
  addLegend(position = "bottomright", opacity = 0.8, pal = summ_palette, values = ~rst_typ, title = "Restoration Type") %>% 
  
  addPolygons(
    data = NA_subs,
    weight = 1,
    color = "black",
    fillColor = "grey",
    fillOpacity = 0.7,
    popup = paste0("<strong>", "Subbasin Name: ", "</strong>", NA_subs$sbbsn_n, "<br>",
                   "<em>", "no predicted increase in spawners", "</em>")) %>% 
  addScaleBar(position = "bottomleft") 




##START OF DEMO MAP

palette = c("#28AFB0","#03045E")
color_palette <- colorNumeric(palette = palette, domain = demo$Sbb_Tt_S)
breaks <- round(seq(max(demo$Sbb_Tt_S), min(demo$Sbb_Tt_S), length.out = 5),1)
legend <- leaflet::colorNumeric(palette = palette, domain = demo$Sbb_Tt_S)(breaks)

demo_map<-leaflet(demo) |> 
  # mutate(demo$Sbb_Tt_S=as.numeric(demo$Sbb_Tt_S)) %>% 
  
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
              fillOpacity = 1,  # fill opacity
              weight = 2,      # outline weight
              popup = ~paste("<strong>", "Subbasin Name: ", "</strong>", map_data$sbbsn_n,"<br>",
                             "<strong>", "Total Score: ", demo$Sbb_Tt_S, "</strong>","<br>",
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
  addScaleBar(position = "bottomleft")%>% 
  addLegend(position = "bottomright", 
            # pal = color_palette,
            values = demo$Sbb_Tt_S,
            title = "Subbasin Total Score",
            opacity = 0.8, labels = breaks,
            colors = legend)

