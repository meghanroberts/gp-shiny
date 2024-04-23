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



############# cost per acre
library(here)
library(janitor)
elj<-read_csv(here("myapp", "data", "not_processed", "average_elj_costs.csv")) %>% clean_names()%>% 
  mutate(lower_average_cost = gsub("\\$ ", "", lower_average_cost)) %>% 
  mutate(upper_average_cost = gsub("\\$ ", "", upper_average_cost)) %>% 
  mutate(lower_average_cost = gsub(",", "", lower_average_cost)) %>%
  mutate(upper_average_cost = gsub(",", "", upper_average_cost)) %>% 
  mutate(lower_average_cost=as.numeric(lower_average_cost)) %>% 
  mutate(upper_average_cost=as.numeric(upper_average_cost)) 

fp<-read_csv(here("myapp", "data", "not_processed", "average_fp_costs.csv")) %>% 
  select(c("Subbasin", "Restoration", "Metric", "Lower Average Cost", "Upper Average Cost")) %>%
  rename("lower_avg_cost"="Lower Average Cost") %>% 
  rename("upper_avg_cost"="Upper Average Cost") %>% 
  mutate(lower_avg_cost = gsub("\\$ ", "", lower_avg_cost)) %>% 
  mutate(lower_avg_cost = str_trim(lower_avg_cost, side = "left"))%>% 
  mutate(lower_avg_cost = gsub(",", "", lower_avg_cost)) %>% 
  mutate(upper_avg_cost = gsub("\\$ ", "", upper_avg_cost)) %>% 
  mutate(upper_avg_cost = gsub(",", "", upper_avg_cost)) %>% 
  mutate(upper_avg_cost = str_trim(upper_avg_cost, side = "left")) %>% 
  mutate(lower_avg_cost=as.numeric(lower_avg_cost)) %>% 
  mutate(upper_avg_cost=as.numeric(upper_avg_cost)) %>% 
  group_by(Subbasin) %>% mutate(upper_average_cost=sum(upper_avg_cost), 
                                lower_average_cost=sum(lower_avg_cost),
                                Restoration="Floodplain", 
                                Metric="per acre") %>% 
  unique() %>% clean_names %>% select(-c(lower_avg_cost, upper_avg_cost))

rp<-read_csv(here("myapp", "data", "not_processed", "average_rp_costs.csv")) %>% clean_names()%>% 
  mutate(lower_average_cost = gsub("\\$ ", "", lower_average_cost)) %>% 
  mutate(upper_average_cost = gsub("\\$ ", "", upper_average_cost)) %>% 
  mutate(lower_average_cost = gsub(",", "", lower_average_cost)) %>%
  mutate(upper_average_cost = gsub(",", "", upper_average_cost)) %>% 
  mutate(lower_average_cost=as.numeric(lower_average_cost)) %>% 
  mutate(upper_average_cost=as.numeric(upper_average_cost)) 

avg_master<-full_join(elj, fp)
avg_master<-full_join(avg_master, rp) %>% 
  mutate(restoration=gsub("rp", "Riparian Planting", restoration)) %>% 
  mutate(restoration=gsub("elj", "Engineered Log Jams", restoration))

write.csv(avg_master, here("myapp", "data", "processed", "unit_cost.csv"))

#plot for avg per acre or per mile
ggplot(data = avg_master, aes(group = restoration)) +
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
# scale_x_continuous(labels = scales::label_dollar(scale = 0.000001, suffix = "M")) +
  # pushing y axis labels to edhe of data 
  labs(x = "Cost Per Acre",
       y = "",
       title = paste( "FP Habitat Restoration Costs")) +
  theme_minimal() +
  theme(plot.title.position = "plot",
        axis.text.x = element_text(size = 14),  
        axis.text.y = element_text(size = 14),
        axis.title.x = element_text(size = 16, margin = margin(t = 15)),
        plot.title = element_text(size = 20, margin = margin(b = 15)))
