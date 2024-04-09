
master %>% 
  filter(!is.na(cb_rati),
         pop == "fall_chinook",
         rst_typ == "Floodplain",
         sbbsn_n != "Mainstem") %>%
  as.data.frame() %>% 

ggplot(aes(x = fct_reorder(sbbsn_n, cb_rati), 
           y = cb_rati)) +
  geom_col(fill = "#03045E") +
  theme_minimal() +
  labs( 
       x = "", 
       y = "Cost Effectivness ($/Chinook Spawner)",
       title = paste("Cost effectiveness of  habitat Restoration")) +
       # caption = "Data Source: Beechie, T. J., Goodman, A., Stefankiv, O., Timpane-Padgham, B., & Lowe, M. (2023). \n Habitat Assessment and Restoration Planning (HARP) Model for the Snohomish and Stillaguamish \n River Basins (noaa:48860).") +

  scale_y_continuous(expand = c(0,0), 
                     labels = scales::label_dollar(scale = 0.001, suffix = "K")) +
  coord_flip() +
  theme(plot.title.position = "plot",
          axis.text.x = element_text(size = 14),  
          axis.text.y = element_text(size = 14),
          axis.title.x = element_text(size = 16, margin = margin(t = 15)),
          plot.title = element_text(size = 20, margin = margin(b = 15)),
          panel.grid.major.y  = element_blank(),
          panel.grid.minor.x  = element_blank())

