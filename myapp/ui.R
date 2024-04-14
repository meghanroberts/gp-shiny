#........................dashboardHeader.........................
header <- dashboardHeader(
  
  #title
  title = "Restoration of Chinook Salmon in the Stillaguamish River Basin",
  titleWidth = 550 #adjust accordingly
) # END dashboardHeader

#........................dashboardSidebar........................
sidebar <- dashboardSidebar(
  
  #different pages
  menuItem(text = "Background", tabName = "background", icon = icon("star")),
  menuItem(text = "Summary Results", tabName = "map", icon = icon("map-pin")),
  menuItem(text = "Cost", tabName = "cost", icon = icon("money-bill-1")),
  menuItem(text = "Benefits", tabName = "ben", icon = icon("fish"), selected = TRUE),
  menuItem(text = "Cost Effectiveness", tabName = "ce", icon = icon("dollar-sign")),
  menuItem(text = "Demographic Info", tabName = "demo", icon = icon("person"))
  
)#END dashboardsidebar

#..........................dashboardBody.........................
body <- dashboardBody(
  
  # tabItems ----
  tabItems(
    
    # background tabItem ----
    tabItem(tabName = "background",
            
            # left-hand column ----
            column(width = 5,
                   
                   #background info box
                   box(width=NULL, #takes on width of the column
                       title = tagList(icon("water"), 
                                       strong("Chinook Salmon Habitat Restoration")),
                       includeMarkdown("text/intro.md")
                   ) #END background box
                  
            ), # END left-hand column
            
            # right-hand column ----
            column(width = 7,
                   
                   #map box
                   box(width=NULL, #takes on width of the column
                       tags$img(src="final_ps_map.jpeg", ##saved in www
                                alt="A map of Northern Alaska showing Fish Creek Watershed located within the National Petroleum Reserve.",
                                style="max-width:100%;") #css to ensure the map is the correct size
                   ) #END map box
                   
            ), # END right-hand column
            
            # bottom column ----
            column(width = 12,
                   
                   # first fluidRow ----
                   fluidRow(
                     
                     # data source box ----
                     box(width = NULL,
                         title = tagList(strong("Purpose")),
                         includeMarkdown("text/disclaimer.md")
                         
                     ) # END data source box
                     
                   ), # END first fluidRow
                   
                   # second fluidRow ----
                   fluidRow(
                     
                     # disclaimer box ----
                     box(width = NULL,
                         title = tagList(strong("Data")),
                         includeMarkdown("text/datacitation.md")
                         
                     ) # END disclaimer box
                     
                   ) # END second fluidRow
                   
            ), # END bottom column
            
    ), # END background tabItem
    
    # map tabItem ----
    tabItem(tabName = "map",
            
            fluidRow(
              leafletOutput("map")
            )
            
    ), # END map tabItem
    
    # cost tabItem ----
    tabItem(tabName = "cost",
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 12,
                  
                  
                  # cost dumbell pickerInputs ----
                  restoration_action_pickerInput(inputId = "cost_dumbell_input")
                  
              ), # END input box
              
              # cost dumbell ----
              box(width = 12, 
                  
                  # cost dumbell output ----
                  plotOutput(outputId = "cost_dumbell_output")
                  
              ) # END cost dumbell box
              
            ) # END fluidRow
            
    ), # END cost tabItem
    
    # ben tabItem ----
    tabItem(tabName = "ben",
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 12,
                  
                  # figure pickerInputs ----
                  rest_multiaction_pickerInput(inputId = "ben_rest_input"),
                  # figure pickerInputs ----
                  species_pickerInput(inputId = "species_input")
                  
              ), # END input box
              
              # leaflet box ----
              box(width = 12, 
                  
                  # ben plot output ----
                  plotOutput(outputId = "ben_fig_output")
                  
              ) # END leaflet box
              
            ) # END fluidRow
            
    ), # END ben tabItem
    
    # ce tabItem ----
    tabItem(tabName = "ce",
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 12,
                  
                  # cost dumbell pickerInputs ----
                  restoration_action_pickerInput(inputId = "cost_effectiveness_input")
                  
              ), # END input box
              
              # leaflet box ----
              box(width = 12, 
                  
                  # cost effectiveness output ----
                  plotOutput(outputId = "cost_effectiveness_output")
                  
              ) # END cost effectiveness graph
              
            ) # END fluidRow
            
    ), # END ce tabItem
    
    # demo tabItem ----
    tabItem(tabName = "demo",
            
            fluidRow(
              leafletOutput("demo_map")
            )
            
    ) # END demo tabItem
    
  ) # END tabItems
)#END dashboardbody

#..................combine all in dashboardPage..................
dashboardPage(header, sidebar, body)#END dashobardPage