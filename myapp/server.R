server <- function(input, output) {
  
  
  # START leaflet map ---- 
  
  output$map <- renderLeaflet({
    
    # from functions/leaflet.R
    leaflet
    
  }) # END leaflet map
  
  
  
  
  # START cost dumbell filter df ----
  
  master_cost_filtered <- reactive({ 
    
    master %>% 
      filter(pop == "fall_chinook",
             rst_typ == c(input$cost_dumbell_input))
    
  }) # END cost dumbell filter df
  
  
  
  # START cost dumbell graph  ----  
  
  output$cost_dumbell_output <- renderPlot({
    
    # from cost function 
    cost_dumbell_chart(data = master_cost_filtered(), 
                       input = input$cost_dumbell_input)
    
  }) # END cost dumbell graph
  
}