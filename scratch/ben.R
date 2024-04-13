library(tidyverse)

master <- st_read("data/processed/master.shp") 

custom_colors <- c("rp" = "#03045E",
                   # "#1F271B",
                   "elj" = "#19647E", 
                   "floodplain" = "#28AFB0")

#creating a bar chart with spawners by action and subbasin

spawner_barchart <- master %>% 
  filter(pop == "steelhead") %>% 
  mutate(sbbsn_n = as.factor(sbbsn_n)) %>%
  mutate(n_diff = as.numeric(n_diff)) %>%
  mutate(subbasin_name = fct_reorder(sbbsn_n, n_diff, .fun = sum),
         restoration_type = factor(rst_typ,
                                   levels = c( "rp", "elj", "floodplain"))) %>% 
  group_by(sbbsn_n) %>% 
  # creating a column to identify where the labels of the n_diff will go on the bar chart for each restoration type in each subbasin
  mutate(label_y = cumsum(n_diff) - .5 * n_diff) %>%
  filter(n_diff>0) %>% #remove when there is no benefit
  
  ggplot(aes(x = sbbsn_n, 
             y = n_diff, fill = rst_typ)) +
  theme_minimal() +
  geom_col() +
  labs(fill = "Restoration Type", 
       x = "", 
       y = "# Annual Steelhead Spawners",
       title = "Modeled Annual Steelhead Spawner Increases",
       subtitle = "by subbasin and restoration action",
       caption = "Data Source: Beechie, T. J., Goodman, A., Stefankiv, O., Timpane-Padgham, B., & Lowe, M. (2023). \n Habitat Assessment and Restoration Planning (HARP) Model for the Snohomish and Stillaguamish \n River Basins (noaa:48860).") +
  coord_flip() +
  scale_fill_manual(values = c("#03045E",
                               # "#1F271B",
                               "#19647E", 
                               "#28AFB0"),
                    labels = c("Riparian Planting",
                               "Engineered Log Jam",
                               "Floodplain"),
                    guide = guide_legend(reverse = TRUE)) +
  # geom_text(aes(y = label_y, label = round(n_diff)), color = "white", alpha = 0.5) +
  
  # pushing y axis labels to edhe of data 
  scale_y_continuous(expand = c(0,0)) +
  
  # scale_y_continuous(limits = c(0, 85)) +
  theme(
    #axes
    axis.text = element_text(size = 10),
    axis.title.x = element_text(margin = margin(t = 12, r = 0, b = 30, l = 20), size = 12),
    #legend
    legend.position = c(0.5, -0.175),
    legend.direction = "horizontal",
    legend.title = element_blank(),
    # legend.box.background = element_rect(color = "grey"))
    # titles
    plot.title = element_text(hjust = 0, vjust = 1.8, size = 16),
    plot.subtitle = element_text(hjust = 0, vjust = 2.2),
    plot.caption = element_text(face = "italic", size = 6),
    # gridlines
    panel.grid.major.y  = element_blank(),
    panel.grid.minor.x  = element_blank()
  ) 

spawner_barchart
