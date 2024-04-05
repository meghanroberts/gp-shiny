library(tidyverse)
library(leaflet)
library(here)
library(sf)

#read in data
all_cost_ben <- st_read(here("myapp", "data", "not_processed", "all_cost_benefit.shp"))
additional_costs<-read_csv(here("myapp", "data", "not_processed","ag_fp_cost.csv"))
demo_shp <- st_read(here("myapp", "data","processed", "demo.shp"))

all_cost_ben<-all_cost_ben %>%
  rename(total_lower_cost=ttl_lw_)%>% 
  rename(total_upper_cost=ttl_pp_)%>% 
  rename(percent_change=prc_chn)%>% 
  rename(total_avg_cost=ttl_vg_)%>% 
  rename(cb_ratio=cb_rati)%>% 
  rename(rest_type=rstrtn_)%>% 
  rename(subbasin_name=sbbsn_n)%>% 
  rename(noaa_subba=noa_sbb)

additional_costs<-additional_costs %>% select(c(subbasin_name, total_subba_area_ha, total_subba_cost, hab_unit)) %>% 
  unique() %>% group_by(subbasin_name) %>% mutate(ag_land_cost=sum(total_subba_cost)) %>% 
  mutate(ag_land_ha=sum(total_subba_area_ha)) %>% select(subbasin_name, ag_land_cost, ag_land_ha) %>% unique()

all_cost_ben<-left_join(all_cost_ben, additional_costs)
write_sf(all_cost_ben, here("myapp", "data", "processed", "master.shp"))
master <- st_read(here("myapp", "data", "processed", "master.shp"))
