library(tidyverse)
library(leaflet)
library(here)
library(sf)

#read in data
all_cost_ben_og <- st_read(here("myapp", "data", "not_processed", "all_cost_benefit.shp"))
additional_costs<-read_csv(here("myapp", "data", "not_processed","ag_fp_cost.csv"))
demo_shp <- st_read(here("myapp", "data","processed", "demo.shp"))

# editing master df
all_cost_ben<-all_cost_ben_og %>%
  # rename(rest_type = rstrtn_,
  #        subbasin_name=sbbsn_n, 
  #        noaa_subba=noa_sbb) %>% 
 transmute(subbasin_name=sbbsn_n,
           noaa_subba=noa_sbb,
           rest_type = case_when(
             rstrtn_ == "floodplain" ~ "Floodplain",
             rstrtn_ == "rp" ~ "Riparian Planting",
             rstrtn_ == "elj" ~ "Engineered Log Jams"),
           pop = pop,
           n_diff = paste0(format(round(n_diff), big.mark = ",")),
           total_lower_cost = paste0(format(round(ttl_vg_), big.mark = ",")), 
         total_upper_cost = paste0(format(round(ttl_pp_), big.mark = ",")), 
         # percent_change = paste0(format(round(prc_chn), big.mark = ",")),  
         total_avg_cost = paste0(format(round(ttl_vg_), big.mark = ",")),
         cb_ratio = cb_rati)  
 

additional_costs<-additional_costs %>% select(c(subbasin_name, total_subba_area_ha, total_subba_cost, hab_unit)) %>% 
  unique() %>% group_by(subbasin_name) %>% mutate(ag_land_cost=sum(total_subba_cost)) %>% 
  mutate(ag_land_ha=sum(total_subba_area_ha)) %>% select(subbasin_name, ag_land_cost, ag_land_ha) %>% unique()

all_cost_ben<-left_join(all_cost_ben, additional_costs)
write_sf(all_cost_ben, here("myapp", "data", "processed", "master.shp"))
master <- st_read(here("myapp", "data", "processed", "master.shp"))
