
# function for creating a restoration action picker. can be used for any figure that requires picking an action 
restoration_action_pickerInput <- function(inputId) {
  
pickerInput(inputId = inputId, label = "Pick Restoration Action:",
            choices = c("Floodplain", "Riparian Planting", "Engineered Log Jams"),
            selected = "Floodplain",
            options = pickerOptions(actionsBox = TRUE),
            multiple = FALSE)
}



# function for creating a restoration action picker that allows for multiple to be selected. can be used for any figure that requires picking an action
rest_multiaction_pickerInput <- function(inputId) {

  pickerInput(inputId = inputId, label = "Pick Restoration Action(s):",
              choices = c("Floodplain", "Riparian Planting", "Engineered Log Jams"),
              selected = "Floodplain",
              options = pickerOptions(actionsBox = TRUE),
              multiple = TRUE)
}

# function for creating a restoration action picker that allows for multiple to be selected. can be used for any figure that requires picking an action
species_pickerInput <- function(inputId) {
  
  pickerInput(inputId = inputId, label = "Pick Species:",
              choices = c("Chinook"="fall_chinook", "Coho"="coho", "Steelhead"="steelhead"),
              selected = "Chinook",
              options = pickerOptions(actionsBox = TRUE),
              multiple = FALSE)
}

# function for creating an action picker that allows for either per mile or per structure to be selected
elj_unit_pickerInput <- function(inputId) {
  
  pickerInput(inputId = inputId, label = "Pick Units:",
              choices = c("Per Mile"="per_mile", "Per Structure"="per_structure"),
              options = pickerOptions(actionsBox = TRUE),
              multiple = FALSE)
}

# function for choosing x-axis
axis_Input <- function(inputId) {
  
  radioButtons(inputId=inputId, label = "Select data view:",
               choices = c("Match x-axis extent to this restoration action"="fit", "Match x-axis extent across restoration actions"="extend"),
               selected = "fit")

}
