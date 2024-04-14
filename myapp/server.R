server <- function(input, output) {
  
  ## MAP TAB
  # START leaflet map ---- 
  
  output$map <- renderLeaflet({
    
    # from functions/leaflet.R
    leaflet
    
  }) # END leaflet map
  
  ##MAP TAB END
  
  ##COST TAB
  # START cost dumbbell filter df ----
  
  master_cost_filtered <- reactive({ 
    
    master %>% 
      filter(pop == "fall_chinook",
             rst_typ == c(input$cost_dumbell_input))
    
  }) # END cost dumbbell filter df
  
  
  
  # START cost dumbbell graph  ----  
  
  output$cost_dumbell_output <- renderPlot({
    
    # from cost function 
    cost_dumbell_chart(data = master_cost_filtered(), 
                       input = input$cost_dumbell_input)
    
  }) # END cost dumbbell graph
  
  ##COST TAB END
  
  ##BEN TAB 
  
  # START ben filter df ----
  
  master_ben_filtered<- reactive({ 
    
    master %>% 
      filter(!is.na(cb_rati),
             pop == c(input$species_input),
             rst_typ == c(input$ben_rest_input)) %>%
      as.data.frame()  
    
  }) # END ben filter df
  
  # START ben graph  ----  
  
  output$ben_fig_output <- renderPlot({
    spawner_barchart
    # (data = master_ben_filtered(), input = c(input$ben_rest_input, input$species_input))
    
  }) # END ben graph
  
  ##BEN TAB END
  
  
  ##CE TAB
  
  # START cost effectiveness filter df ----
  
  master_cost_effectiveness_filtered <- reactive({ 
    
    master %>% 
      filter(!is.na(cb_rati),
             pop == "fall_chinook",
             rst_typ == c(input$cost_effectiveness_input), 
             sbbsn_n != "Mainstem") %>%
      as.data.frame()  
  
  }) # END cost effectivness filter df
  
  
  # START cost effectivness graph  ----  
  
  output$cost_effectiveness_output <- renderPlot({
    
    # from cost function 
    cost_effectiveness_bar(data = master_cost_effectiveness_filtered(), 
                       input = input$cost_effectiveness_input)
    
  }) # END cost effectiveness graph
  
  ##CE TAB END
  
  ##DEMO TAB
  output$demo_map <- renderLeaflet({
    
    # from functions/leaflet.R
    demo_map
    
  }) # END leaflet map
  
  ##DEMO TAB END
  
}