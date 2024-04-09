library(tidyverse)

cost_graph_fun <- function(df, rest_type) {
  
  df_filtered <- df %>% 
    filter(pop == "fall_chinook",
           rst_typ == paste(rest_type))
  
  # initialize plot (we'll map our aesthetics locally for each geom, below) ----
  ggplot(data = df_filtered, aes(group = rst_typ
  )) +
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
         title = paste(rest_type, "Habitat Restoration Costs")) +
    theme_minimal() 
}

cost_graph_fun(master, "Floodplain")




