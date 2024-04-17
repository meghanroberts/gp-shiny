# load libraries ----
library(fresh)

# create theme ----
create_theme(
  
  # change "light-blue"/"primary" color
  adminlte_color(
    light_blue = "#3B413C" # dark blue
  ),
  
  # dashboardBody styling (includes boxes)
  adminlte_global(
    content_bg = "#FFFFFF", 
    custom_css = '
      /* Remove box shadows from all boxes */
      .box {
        -webkit-box-shadow: none;
        -moz-box-shadow: none;
        box-shadow: none;
      }
    '
  ),
  
  # dashboardSidebar styling
  adminlte_sidebar(
    width = "300px", 
    dark_bg = "#3B413C", # light blue
    dark_hover_bg = "#DAF0EE", # magenta
    dark_color = "#FFFFFF" # red
  ),
  
  output_file = "www/shinydashboard-fresh-theme.css" # generate css file & save to www/
)

