server <- function(input, output) {
  
  ## MAP TAB
  # START leaflet map ---- 
  
  output$map <- renderLeaflet({
    
    # from functions/leaflet.R
    leaflet
    
  }) # END leaflet map
  
  ##MAP TAB END
  
  ##COST TAB
  
  # total cost
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
  
  #unit cost
  ## filter for unit cost
  unit_cost_filtered <- reactive({ 
    
    # unit_cost_master %>% 
    #   filter(restoration == c(input$cost_dumbell_input))
    
    if (input$cost_dumbell_input == "Engineered Log Jams") {
      unit_cost_master %>%
        filter(metric == input$elj_unit_input)
    } else {
      unit_cost_master
    }
  }) # END unit cost dumbbell filter df
  
  # START UNIT cost dumbell graph
  output$unit_cost_dumbell_output <- renderPlot({ 
    # unit_cost_dumbell_chart
    
    # from cost function
    unit_cost_dumbell_chart(data = unit_cost_filtered(),
                            input = input$cost_dumbell_input)
    
  }) # END cost dumbbell graph
  
  
  #land cost
  #START land cost barchart ----
  output$land_cost_barchart_output <- renderPlot({
    
    # from cost function 
    ag_land_price_barchart
    
  })  # END land cost barchart
  
  ##COST TAB END
  
  
  
  ##BEN TAB 
  
  # Function to create the bar chart
  spawner_barchart <- function(data) {
    ggplot(data = data, aes(x = sbbsn_n, 
                            y = n_diff, 
                            fill = rst_typ)) +
      theme_minimal() +
      geom_col() +
      labs(fill = "Restoration Type", 
           x = "", 
           y = "# Annual Steelhead Spawners",
           title = "Modeled Annual Steelhead Spawner Increases") +
      coord_flip() +
      scale_fill_manual(values = c("#03045E", "#19647E", "#28AFB0"),
                        labels = c("Riparian Planting", "Engineered Log Jam", "Floodplain"),
                        guide = guide_legend(reverse = TRUE)) +
      theme(plot.title.position = "plot",
            axis.text.x = element_text(size = 14),  
            axis.text.y = element_text(size = 14),
            axis.title.x = element_text(size = 16, margin = margin(t = 15)),
            plot.title = element_text(size = 20, margin = margin(b = 15)))
  }
  
  # START ben filter df ----
  
  master_ben_filtered <- reactive({ 
    filtered_data <- master %>%
      filter(pop == input$spp_input
             # ,rst_typ == c(input$ben_rest_input)
      ) %>%
      mutate(rst_typ=factor(rst_typ, levels = c("Floodplain", "Engineered Log Jams",
                                                "Riparian Planting"))) %>%
      mutate(sbbsn_n=factor(sbbsn_n)) %>% 
      mutate(n_diff=as.numeric(n_diff)) %>% 
      mutate(sbbsn_n = fct_reorder(sbbsn_n, n_diff, .fun = sum)) %>% 
      filter(n_diff>0) %>% 
      as.data.frame()
  })
  
  
  
  # START ben graph  ----  
  
  output$ben_fig_output <- renderPlot({
    spawner_barchart2(data = master_ben_filtered(), spp=input$spp_input)
  })
  
  
  # }) # END ben graph
  
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