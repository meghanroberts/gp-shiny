library(tidyverse)


# cost dumbell chart function 
cost_dumbell_chart <- function(data, input) {
  
  ggplot(data = data, aes(group = rst_typ)) +
    # create dumbbells ----
  geom_segment(aes(x = ttl_lw_, xend = ttl_pp_,
                   y = fct_reorder(sbbsn_n, ttl_pp_), 
                   yend = sbbsn_n),
               color = "grey",
               size = 1.5
  ) + # reorder occupation by avg_salary here
    geom_point(aes(x = ttl_lw_, y = sbbsn_n, 
                   color = rst_typ, group = rst_typ), size = 3, color = "#28AFB0") +
    geom_point(aes(x = ttl_pp_, y = sbbsn_n,
                   color = rst_typ, group = rst_typ), size = 3, color = "#03045E") +
    # axis breaks & $ labels ----
  scale_x_continuous(labels = scales::label_dollar(scale = 0.000001, suffix = "M")) +
    # pushing y axis labels to edhe of data 
    labs(x = "Total Cost ($ million)",
         y = "",
         title = paste(input, "Habitat Restoration Costs")) +
    theme_minimal() +
    theme(plot.title.position = "plot",
          axis.text.x = element_text(size = 14),  
          axis.text.y = element_text(size = 14),
          axis.title.x = element_text(size = 16, margin = margin(t = 15)),
          plot.title = element_text(size = 20, margin = margin(b = 15)),
          panel.grid.major.y  = element_blank(),
          panel.grid.minor.x  = element_blank())
}



# Cost effectiveness 

cost_effectiveness_bar <- function(data, input) {
  
    
ggplot(data = data, aes(x = fct_reorder(sbbsn_n, cb_rati), 
           y = cb_rati)) +
  geom_col(fill = "#03045E") +
  theme_minimal() +
  labs( 
    x = "", 
    y = "$/Chinook Spawner",
    title = paste("Cost Effectiveness of", input, "Habitat Restoration")) +
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

}


library(here)
ag_land_cost1 <- read_csv(here("myapp", "data", "processed", "flood_ag_subba_sum.csv"))

ag_land_cost <- ag_land_cost1 %>% 
  
  group_by(noaa_subba, subbasin_name) %>% 
  summarise(total_subba_cost = sum(total_subba_cost))

#land cost figure
#figure itself
ag_land_price_barchart<- ag_land_cost %>% 
  ggplot(aes(
    # x = noaa_subba, 
    x = reorder(subbasin_name, total_subba_cost),
    y = total_subba_cost/1000000)) +
  theme_minimal() +
  geom_col(fill = "#03045E") +
  labs(fill = "Habitat Type", 
       x = "", 
       y = "Cost (Million $)",
       title = "Price of Agricultural Floodplain Habitat") +  ##CHANGE THIS
  coord_flip() + 
  # scale_fill_manual(values = custom_colors) +
  # pushing y axis labels to edhe of data 
  scale_y_continuous(expand = c(0,0)) +
  theme(plot.title.position = "plot",
        axis.text.x = element_text(size = 14),  
        axis.text.y = element_text(size = 14),
        axis.title.x = element_text(size = 16, margin = margin(t = 15)),
        plot.title = element_text(size = 20, margin = margin(b = 15)),
        panel.grid.major.y  = element_blank(),
        panel.grid.minor.x  = element_blank())

ag_land_price_barchart

  # theme(
  #   #axes
  #   axis.text = element_text(size = 10),
  #   axis.title.x = element_text(margin = margin(t = 12, r = 0, b = 30, l = 20), size = 12),
  #   #legend
  #   legend.position = c(0.5, -0.175),
  #   legend.direction = "horizontal",
  #   legend.title = element_blank(),
  #   # legend.box.background = element_rect(color = "grey"))
  #   # titles
  #   plot.title = element_text(hjust = 0, vjust = 1.8, size = 16),
  #   plot.subtitle = element_text(hjust = 0, vjust = 2.2),
  #   plot.caption = element_text(face = "italic", size = 6),
  #   # gridlines
  #   panel.grid.major.y  = element_blank(),
  #   panel.grid.minor.x  = element_blank()
  # ) 


