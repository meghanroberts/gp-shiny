#........................dashboardHeader.........................
header <- dashboardHeader(
  
  #title
  title = "Place Title Here",
  titleWidth = 400 #adjust accordingly
) # END dashboardHeader

#........................dashboardSidebar........................
sidebar <- dashboardSidebar(
  
  #different pages
  menuItem(text = "Background", tabName = "background", icon = icon("star")),
  menuItem(text = "Summary Results", tabName = "map", icon = icon("map-pin")),
  menuItem(text = "Cost", tabName = "cost", icon = icon("money-bill-1")),
  menuItem(text = "Benefits", tabName = "ben", icon = icon("fish")),
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
            column(width = 6,
                   
                   # background info box ----
                   box(width = NULL,
                       
                       "background info here"
                       
                   ), # END background info box
                   
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
            
           "map here"
            
    ), # END map tabItem
    
    # cost tabItem ----
    tabItem(tabName = "cost",
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 4,
                  
                  "radiobutton here"
                  
              ), # END input box
              
              # leaflet box ----
              box(width = 8, 
                  
                  "figure here"
                  
              ) # END leaflet box
              
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
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 4,
                  
                  "radiobutton here"
                  
              ), # END input box
              
              # leaflet box ----
              box(width = 8, 
                  
                  "figure here"
                  
              ) # END leaflet box
              
            ) # END fluidRow
            
    ), # END ce tabItem
    
    # demo tabItem ----
    tabItem(tabName = "demo",
            
            "deom info here"
            
    ) # END demo tabItem
    
  ) # END tabItems
)#END dashboardbody

#..................combine all in dashboardPage..................
dashboardPage(header, sidebar, body)#END dashobardPage