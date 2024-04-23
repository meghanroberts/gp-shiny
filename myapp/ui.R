#........................dashboardHeader.........................
header <- dashboardHeader(
  
  #title
  title = "Chinook Habitat Restoration in the Stillaguamish River Basin",
  titleWidth = 550 #adjust accordingly
) # END dashboardHeader

#........................dashboardSidebar........................
sidebar <- dashboardSidebar(
  sidebarMenu(id = "tabs",
              
              #different pages
              menuItem(text = "Background", tabName = "background", icon = icon("star"), selected = TRUE),
              menuItem(text = "Summary Results", tabName = "map", icon = icon("map-pin")),
              menuItem(text = "Cost", tabName = "cost", icon = icon("money-bill-1")),
              menuItem(text = "Benefits", tabName = "ben", icon = icon("fish")),
              menuItem(text = "Cost Effectiveness", tabName = "ce", icon = icon("dollar-sign")),
              menuItem(text = "Demographic Info", tabName = "demo", icon = icon("person"))
              
  ))#END dashboardsidebar

#..........................dashboardBody.........................
body <- dashboardBody(
  
  # set theme
  # fresh::use_theme("shinydashboard-fresh-theme5.css"),
  
  # link stylesheet
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
  ),
  
  tags$head(
    tags$style(HTML("
      /* Remove borders and shadows from all boxes */
      .box {
        border: none !important;
        -webkit-box-shadow: none !important;
        -moz-box-shadow: none !important;
        box-shadow: none !important;
      }

      /* Custom CSS to adjust the width of the picker input box */
      .custom-picker .selectize-input {
        width: 50px; /* Adjust the width as needed */
      }
    "
    ))),
  
  
  # tabItems ----
  tabItems(
    
    # background tabItem ----
    tabItem(tabName = "background",
            
            # left-hand column ----
            column(width = 12,
                   
                   #background info box
                   box(width=12, #takes on width of the column
                       title = tagList(
                         strong("Chinook Salmon Habitat Restoration")),
                       includeMarkdown("text/intro.md")
                   ) #END background box
                   
            ), # END left-hand column
            
            # right-hand column ----
            column(width = 12,
                   
                   #map box
                   box(width=NULL, #takes on width of the column
                       tags$img(src="final_ps_map.jpeg", ##saved in www
                                alt="A map of Puget Sound highlighting the Stillaguamish River Basin",
                                style="max-width:100%;") #css to ensure the map is the correct size
                   ) #END map box
                   
            ), # END right-hand column
            
            # bottom column ----
            column(width = 12,
                   
                   # first fluidRow ----
                   fluidRow(
                     
                     # data source box ----
                     box(width = NULL,
                         title = tagList(strong("Data")),
                         includeMarkdown("text/datacitation.md")
                         
                     ) # END data source box
                     
                   )
                   
            ), # END bottom column
            
            # bottom column ----
            column(width = 12,
                   
                   # first fluidRow ----
                   fluidRow(
                     
                     # data source box ----
                     box(width = NULL,
                         includeMarkdown("text/purpose.md")
                         
                     ) # END data source box
                     
                   )
                   
            ), # END bottom column
            
    ), # END background tabItem
    
    # map tabItem ----
    tabItem(tabName = "map",
            
            fluidRow(box(width = 12,
                         title = tagList( 
                           strong("Summary")),
                         includeMarkdown("text/summary.md")),
                     leafletOutput("map")%>% 
                       shinycssloaders::withSpinner(color="#03045E", type=6) #add a loading spinner
            )
            
    ), # END map tabItem
    
    # cost tabItem ----
    tabItem(tabName = "cost",
            
            # cost info box ----
            fluidRow(
              box(width=12, #takes on width of the column
                  title = tagList( 
                    strong("Restoration Costs")),
                  includeMarkdown("text/cost.md"),
                  restoration_action_pickerInput(inputId = "cost_dumbell_input"),
                  conditionalPanel(
                    condition = "input.cost_dumbell_input == 'Engineered Log Jams'",
                    elj_unit_pickerInput(inputId="elj_unit_input")
                  )
                  
              ), # END input box
              
              
              # unit cost dumbell ----
              box(width = 12, 
# 
#                   # Display the resulting dataframe
#                   dataTableOutput("filtered_table"),

                  # cost dumbell output ----
                  plotOutput(outputId = "unit_cost_dumbell_output")%>% 
                    shinycssloaders::withSpinner(color="#03045E", type=6) #add a loading spinner
                  
              ), # END unit cost dumbell box
              
              # cost dumbell ----
              box(width = 12, 
                  
                  # cost dumbell output ----
                  plotOutput(outputId = "cost_dumbell_output")%>% 
                    shinycssloaders::withSpinner(color="#03045E", type=6) #add a loading spinner
                  
              ), # END cost dumbell box
              
              
              
              box(width=12, #takes on width of the column
                  title = tagList( 
                    strong("Additional Costs")),
                  includeMarkdown("text/landcosts.md")
                  
              ), # END input box
              
              # land cost barchart ----
              box(width = 12, 
                  
                  # land cost barchart output ----
                  plotOutput(outputId = "land_cost_barchart_output")%>% 
                    shinycssloaders::withSpinner(color="#03045E", type=6) #add a loading spinner
                  
              ), # END land cost barchart box
              
            ) # END fluidRow
            
    ), # END cost tabItem
    
    # ben tabItem ----
    tabItem(tabName = "ben",
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 12,
                  title = tagList(
                    strong("Benefits of Restoration")),
                  includeMarkdown("text/ben.md"),
                  species_pickerInput(inputId = "spp_input")
                  
              ), # END input box
              
              # leaflet box ----
              box(width = 12, 
                  
                  # ben plot output ----
                  plotOutput(outputId = "ben_fig_output")%>% 
                    shinycssloaders::withSpinner(color="#03045E", type=6) #add a loading spinner
                  
              ) # END leaflet box
              
            ) # END fluidRow
            
    ), # END ben tabItem
    
    # ce tabItem ----
    tabItem(tabName = "ce",
            
            # cost info box ----
            fluidRow(
              box(width=12, #takes on width of the column
                  title = tagList(
                    strong("Cost Effectiveness")),
                  includeMarkdown("text/ce.md"),
                  restoration_action_pickerInput(inputId = "cost_effectiveness_input"),
                  
                  
                  
              ), # END input box
              
              # leaflet box ----
              box(width = 12, 
                  
                  # cost effectiveness output ----
                  plotOutput(outputId = "cost_effectiveness_output")%>% 
                    shinycssloaders::withSpinner(color="#03045E", type=6) #add a loading spinner
                  
              ) # END cost effectiveness graph
              
            ) # END fluidRow
            
    ), # END ce tabItem
    
    # demo tabItem ----
    tabItem(tabName = "demo",
            
            fluidRow(
              
              # input box ----
              box(width = 12,
                  
                  title = tagList(strong("Demographics of Stillaguamish Subbasins")),
                  includeMarkdown("text/demo.md")
                  
              ), # END input box
              box(width=12, 
                  leafletOutput("demo_map"))
            ),
            
    ) # END demo tabItem
    
  ) # END tabItems
)#END dashboardbody

#..................combine all in dashboardPage..................
dashboardPage(header, sidebar, body)#END dashobardPage