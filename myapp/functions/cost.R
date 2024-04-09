
# cost dumbell chart function 
cost_dumbell_chart <- function(data, input) {
  
  ggplot(data = data, aes(group = rst_typ
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
       title = paste(input, "Habitat Restoration Costs")) +
  theme_minimal() 
}
