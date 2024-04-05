# LOAD LIBRARIES ----
library(shiny)
library(shinydashboard)
library(sf)

master <- st_read("myapp/data/processed/master.shp") 
subs <- st_read("myapp/data/processed/subs/subs.shp") 
