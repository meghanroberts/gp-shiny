# LOAD LIBRARIES ----
library(tidyverse)
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(sf)
library(leaflet)


# master data 
master <- st_read("data/processed/master.shp") 
# map data with benefits and actions
map_data <- st_read("data/processed/map_data/map_data.shp")
# map data without benefits or actions
NA_subs <- st_read("data/processed/map_data/NA_subs.shp")
# demo data
demo <- st_read("data/processed/demo_transformed.shp")
# ag land cost data
ag_land_cost <- read_csv("data/processed/flood_ag_subba_sum.csv")


# sources
source("functions/leaflet.R")
source("functions/costben.R")
source("functions/action_picker.R")
