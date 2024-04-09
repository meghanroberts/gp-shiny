# LOAD LIBRARIES ----
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


# sources
source("functions/leaflet.R")
source("functions/cost.R")
source("functions/action_picker.R")
