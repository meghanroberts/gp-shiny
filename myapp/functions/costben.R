library(tidyverse)


# cost dumbell chart function 
cost_dumbell_chart <- function(data, input, axis) {
  
  # Define default x-axis limits
  x_limits <- c(0, 450000000)  # Default x-axis limits
  
  if ("Floodplain" %in% unique(data$rst_typ)) {
    # If Floodplain restoration is present, adjust x-axis limits
    x_limits <- c(0, 375000000)
  } else if ("Riparian Planting" %in% unique(data$rst_typ)) {
    # If Riparian Planting restoration is present, adjust x-axis limits
    x_limits <- c(0, 130000000)
  } else if ("Engineered Log Jams" %in% unique(data$rst_typ)) {
    # If Engineered Log Jams restoration is present, adjust x-axis limits
    x_limits <- c(0, 30000000)
  }
  
  # Check the user's selection
  if (axis == "extend") {
    # If user selects "Extend X-axis", change x-axis limits
    x_limits <- c(0, 375000000) } # Set extended x-axis limits
  
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
  scale_x_continuous(labels = scales::label_dollar(scale = 0.000001, suffix = "M"), limits=x_limits) +
    # pushing y axis labels to edhe of data 
    labs(x = "Total Cost ($ million)",
         y = "",
         title = paste(input, "Total Habitat Restoration Costs")) +
    theme_minimal() +
    theme(plot.title.position = "plot",
          axis.text.x = element_text(size = 14),  
          axis.text.y = element_text(size = 14),
          axis.title.x = element_text(size = 16, margin = margin(t = 15)),
          plot.title = element_text(size = 20, margin = margin(b = 15)),
          panel.grid.major.y  = element_blank(),
          panel.grid.minor.x  = element_blank())
}

# # Benefits

#correct for mismatch between code name and what I want displayed
species_mapping <- c("fall_chinook" = "Chinook",
                     "coho" = "Coho",
                     "steelhead" = "Steelhead")

restoration_colors <- c("Riparian Planting" = "#03045E",
                        "Engineered Log Jams" = "#19647E",
                        "Floodplain" = "#28AFB0")

#function for spawner barchart
spawner_barchart2 <- function(data, spp) {
  full_species_name <- species_mapping[spp]
  
  ggplot(data = data, aes(x = sbbsn_n, 
                          y = n_diff, 
                          fill = as.factor(rst_typ))) +
    theme_minimal() +
    geom_col() +
    labs(fill = "Restoration Type", 
         x = "", 
         y = paste("# Annual", full_species_name, "Spawners"),
         title = paste("Modeled Annual", full_species_name, "Spawner Increases")) +
    coord_flip() +
    scale_fill_manual(values = restoration_colors,
                      # values = c("Riparian Planting"="#03045E", "Engineered Log Jam"="#19647E", "Floodplain"="#28AFB0"),
                      # labels = c("Riparian Planting", "Engineered Log Jam", "Floodplain"),
                      guide = guide_legend(reverse = TRUE)) +
    guides(fill = guide_legend(title = "Restoration Type", 
                               title.theme = element_text(size = 15), 
                               label.theme = element_text(size = 13),
                               keywidth = 2, 
                               keyheight = 2)) +
    theme(plot.title.position = "plot",
          axis.text.x = element_text(size = 14),  
          axis.text.y = element_text(size = 14),
          axis.title.x = element_text(size = 16, margin = margin(t = 15)),
          plot.title = element_text(size = 20, margin = margin(b = 15)),
          panel.grid.major.y  = element_blank(),
          panel.grid.minor.x  = element_blank())
}

# Cost effectiveness 

cost_effectiveness_bar <- function(data, input, axis) {
  
  # Define default x-axis limits
  x_limits <- c(0, 250000)  # Default x-axis limits
  
  if ("Floodplain" %in% unique(data$rst_typ)) {
    # If Floodplain restoration is present, adjust x-axis limits
    x_limits <- c(0, 80000)
  } else if ("Riparian Planting" %in% unique(data$rst_typ)) {
    # If Riparian Planting restoration is present, adjust x-axis limits
    x_limits <- c(0, 320000)
  } else if ("Engineered Log Jams" %in% unique(data$rst_typ)) {
    # If Engineered Log Jams restoration is present, adjust x-axis limits
    x_limits <- c(0, 125000)
  }
  
  # Check the user's selection
  if (axis == "extend") {
    # If user selects "Extend X-axis", change x-axis limits
    x_limits <- c(0, 320000)}  # Set extended x-axis limits
  
  
  ggplot(data = data, aes(x = fct_reorder(sbbsn_n, cb_rati), 
                          y = cb_rati)) +
    geom_col(fill = "#03045E") +
    theme_minimal() +
    labs( 
      x = "", 
      y = "Cost Effectiveness ($/Chinook Spawner)",
      title = paste("Cost Effectiveness of", input, "Habitat Restoration")) +
    # caption = "Data Source: Beechie, T. J., Goodman, A., Stefankiv, O., Timpane-Padgham, B., & Lowe, M. (2023). \n Habitat Assessment and Restoration Planning (HARP) Model for the Snohomish and Stillaguamish \n River Basins (noaa:48860).") +
    
    scale_y_continuous(expand = c(0,0), 
                       labels = scales::label_dollar(scale = 0.001, suffix = "K"), limits = x_limits) +
    coord_flip() +
    theme(plot.title.position = "plot",
          axis.text.x = element_text(size = 14),  
          axis.text.y = element_text(size = 14),
          axis.title.x = element_text(size = 16, margin = margin(t = 15)),
          plot.title = element_text(size = 20, margin = margin(b = 15)),
          panel.grid.major.y  = element_blank(),
          panel.grid.minor.x  = element_blank())
  
}

ag_land_cost_mod <- ag_land_cost %>% 
  group_by(noaa_subba, subbasin_name) %>% 
  summarise(total_subba_cost = sum(total_subba_cost))

# Cost of ag land
ag_land_price_barchart<- ag_land_cost_mod %>% 
  ggplot(aes(
    x = reorder(subbasin_name, total_subba_cost),
    y = total_subba_cost/1000000)) +
  theme_minimal() +
  geom_col(fill = "#03045E", color = "#03045E") +
  labs(x = "", 
       y = "Cost ($ million)",
       title = "Price of Agricultural Floodplain Habitat") +  
  coord_flip() + 
  scale_y_continuous(expand = c(0,0), 
                     labels = scales::label_dollar(scale = 1, suffix = "M")) +
  theme(plot.title.position = "plot",
        axis.text.x = element_text(size = 14),  
        axis.text.y = element_text(size = 14),
        axis.title.x = element_text(size = 16, margin = margin(t = 15)),
        plot.title = element_text(size = 20, margin = margin(b = 15)),
        panel.grid.major.y  = element_blank(),
        panel.grid.minor.x  = element_blank())


#labeler for unit cost figure
map_metric_to_label <- function(metric) {
  # Define a lookup table or switch statement to map metric to label
  switch(metric[1], # Select the first element of the vector
         "per_acre" = "Cost Per Acre",
         "per_mile" = "Cost Per Mile",
         "per_structure" = "Cost Per Structure",
         # Add more cases for additional metrics
         "NA")
}


  # cost per acre/mile dumbell chart function 
  unit_cost_dumbell_chart <- #plot for avg per acre or per mile
    
    function(data, input, axis) {
      
      # Define default x-axis limits
      x_limits <- c(0, 250000)  # Default x-axis limits
      
      if ("Floodplain" %in% unique(data$restoration)) {
        # If Floodplain restoration is present, adjust x-axis limits
        x_limits <- c(0, 250000)
      } else if ("Riparian Planting" %in% unique(data$restoration)) {
        # If Riparian Planting restoration is present, adjust x-axis limits
        x_limits <- c(0, 150000)
      } else if ("Engineered Log Jams" %in% unique(data$restoration)) {
        # If Engineered Log Jams restoration is present, adjust x-axis limits
        x_limits <- c(0, 130000)
      }
      
      # Check the user's selection
      if (axis == "extend") {
        # If user selects "Extend X-axis", change x-axis limits
        x_limits <- c(0, 250000) } # Set extended x-axis limits
      
      x_label <- map_metric_to_label(unique(data$metric))
      
      #plot for avg per acre or per mile
      ggplot(data = data, aes(group = restoration)) +
        # create dumbbells ----
      geom_segment(aes(x = lower_average_cost, xend = upper_average_cost,
                       y = fct_reorder(subbasin, upper_average_cost),
                       yend = subbasin),
                   color = "grey",
                   size = 1.5
      ) + # reorder occupation by avg_salary here
        geom_point(aes(x = lower_average_cost, y = subbasin,
                       color = restoration, group = restoration), size = 3, color = "#28AFB0") +
        geom_point(aes(x = upper_average_cost, y = subbasin,
                       color = restoration, group = restoration), size = 3, color = "#03045E") +
        # axis breaks & $ labels ----
      scale_x_continuous(labels = scales::label_dollar(scale = 0.001, suffix = "K"), limits = x_limits) +
        # pushing y axis labels to edhe of data
        labs(x = paste(x_label, "($ thousand)"),
             y = "",
             title = paste(input, "Habitat Restoration", x_label)) +
        theme_minimal() +
        theme(plot.title.position = "plot",
              axis.text.x = element_text(size = 14),
              axis.text.y = element_text(size = 14),
              axis.title.x = element_text(size = 16, margin = margin(t = 15)),
              plot.title = element_text(size = 20, margin = margin(b = 15)),
              panel.grid.major.y  = element_blank(),
              panel.grid.minor.x  = element_blank())
      }
