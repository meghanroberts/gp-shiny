# LOAD LIBRARIES ----
library(shiny)
library(shinydashboard)
library(sf)

# sources
source("functions/leaflet.R")



# master data 
master <- st_read("data/processed/master.shp") 
# map data with benefits and actions
map_data <- st_read("data/processed/map_data/map_data.shp")
# map data without benefits or actions
NA_subs <- st_read("data/processed/map_data/NA_subs.shp")
