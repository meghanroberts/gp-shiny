
# function for creating a restoration action picker. can be used for any figure that requires picking an action 
restoration_action_pickerInput <- function(inputId) {
  
pickerInput(inputId = inputId, label = "Pick Restoration Action:",
            choices = c("Floodplain", "Riparian Planting", "Engineered Log Jams"),
            selected = "Floodplain",
            options = pickerOptions(actionsBox = TRUE),
            multiple = FALSE)
}