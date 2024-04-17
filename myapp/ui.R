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
  menuItem(text = "Benefits", tabName = "ben", icon = icon("fish")),
  menuItem(text = "Cost Effectiveness", tabName = "ce", icon = icon("dollar-sign")),
  menuItem(text = "Cobenefits", tabName = "ce", icon = icon("fish")),
  menuItem(text = "Demographic Info", tabName = "demo", icon = icon("person"))
  
)#END dashboardsidebar

#..........................dashboardBody.........................
body <- dashboardBody(
  
  # set theme
  fresh::use_theme("shinydashboard-fresh-theme.css"),
  
  # tabItems ----
  tabItems(
    
    # background tabItem ----
    tabItem(tabName = "background",
            
            # left-hand column ----
            column(width = 6,
                   
                   #background info box
                   box(width=NULL, #takes on width of the column
                       title = tagList(icon("water"), 
                                       strong("Monitoring Fish Creek Watershed")),
                       includeMarkdown("text/intro.md"), 
                       tags$img(src="final_ps_map.jpeg", ##saved in www
                                alt="A map of Northern Alaska showing Fish Creek Watershed located within the National Petroleum Reserve.",
                                style="max-width:100%;") #css to ensure the map is the correct size
                   ) #END background box
                  
            ), # END left-hand column
            
            # right-hand column ----
            column(width = 6,
                   
                   # first fluidRow ----
                   fluidRow(
                     
                     # data source box ----
                     box(width = NULL,
                         
                         "data citation here"
                         
                     ) # END data source box
                     
                   ), # END first fluidRow
                   
                   # second fluidRow ----
                   fluidRow(
                     
                     # disclaimer box ----
                     box(width = NULL,
                         
                         "disclaimer here"
                         
                     ) # END disclaimer box
                     
                   ) # END second fluidRow
                   
            ) # END right-hand column
            
    ), # END background tabItem
    
    # map tabItem ----
    tabItem(tabName = "map",
            
            fluidRow(
              leafletOutput("map")
            )
            
    ), # END map tabItem
    
    # cost tabItem ----
    tabItem(tabName = "cost",
            
            # cost info box ----
            fluidRow(
                   box(width=12, #takes on width of the column
                       title = tagList(icon("money-bill-1"), 
                                       strong("Restoration Costs")),
                       includeMarkdown("text/cost.md"),
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
              box(width = 4,
                  
                  "checkbox here"
                  
              ), # END input box
              
              # leaflet box ----
              box(width = 8, 
                  
                  "map here"
                  
              ) # END leaflet box
              
            ) # END fluidRow
            
    ), # END ben tabItem
    
    # ce tabItem ----
    tabItem(tabName = "ce",
            
            # cost info box ----
            fluidRow(
              box(width=12, #takes on width of the column
                  title = tagList(icon("dollar-sign"), 
                                  strong("Cost Effectiveness")),
                  includeMarkdown("text/ce.md"),
                  restoration_action_pickerInput(inputId = "cost_effectiveness_input"),
                  
             
                  
              ), # END input box
              
              # leaflet box ----
              box(width = 12, 
                  
                  # cost effectiveness output ----
                  plotOutput(outputId = "cost_effectiveness_output")
                  
              ) # END cost effectiveness graph
              
            ) # END fluidRow
            
    ), # END ce tabItem
    
    # cobenefits tabItem ----
    tabItem(tabName = "cobens",
            
            "cobenefits info here"
            
    ), # END coben tabItem
    
    # demo tabItem ----
    tabItem(tabName = "demo",
            
            "deom info here"
            
    ) # END demo tabItem
    
  ) # END tabItems
)#END dashboardbody

#..................combine all in dashboardPage..................
dashboardPage(header, sidebar, body)#END dashobardPage