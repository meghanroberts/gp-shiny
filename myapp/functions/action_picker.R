
# function for creating a restoration action picker. can be used for any figure that requires picking an action 
restoration_action_pickerInput <- function(inputId) {
  
pickerInput(inputId = inputId, label = "Pick Restoration Action:",
            choices = c("Floodplain", "Riparian Planting", "Engineered Log Jams"),
            selected = "Floodplain",
            options = pickerOptions(actionsBox = TRUE),
            multiple = FALSE)
<<<<<<< HEAD
     
}

=======
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


>>>>>>> bd1ec9aaac423224a806e3de0bf5ee8687a49d44
