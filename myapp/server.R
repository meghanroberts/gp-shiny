server <- function(input, output) {


# START leaflet map ---- 
  output$map <- renderLeaflet({
    
    # from functions/leaflet.R
    leaflet
    
  }) # END leaflet map
  
  
}