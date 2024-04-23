# load libraries ----
library(fresh)

# create theme ----
create_theme(
  
  # change "light-blue"/"primary" color
  adminlte_color(
    light_blue = "#150B5A" # dark blue
  ),
  
  # dashboardBody styling (includes boxes)
  adminlte_global(
    content_bg = "white" # blush pink
  ),
  
  # dashboardSidebar styling
  adminlte_sidebar(
    # width = "400px", 
    dark_bg = "lightgrey", # light blue
    dark_hover_bg = "cyan3", # magenta
    dark_color = "#150B5A" # red
  ),
  output_file = "myapp/www/shinydashboard-fresh-theme5.css" # generate css file & save to www/
)
