# Assuming your data frame is called 'your_data'
# and the columns are named 'ExperimentID', 'Param1', 'Param2', 'Param3', 'Param4'

library(dplyr)

# Function to generate all possible combinations of ExperimentID and Param2
generate_all_combinations <- function(your_data) {
  unique_experiments <- unique(your_data$ExperimentID)
  all_combinations <- expand.grid(ExperimentID = unique_experiments, Param2 = 1:10)
  return(all_combinations)
}

# Your data
your_data <- data.frame(
  ExperimentID = c(1, 2, 3, 4, 5, 6),  # Replace with your actual data
  Param1 = c("a1", "b1", "c1", "d1", "e1", "f1"),  # Replace with your actual data
  Param2 = c(1,3,5,6,2,1),  # Replace with your actual data
  Param3 = c("a2", "b2", "c2", "d2", "e2", "f1"),  # Replace with your actual data
  Param4 = c("x", "y", "z", "p", "q", "r")   # Replace with your actual data
)

# Mapping of Param2 to Param4
param2_to_param4_mapping <- data.frame(
  Param2 = 1:10,  # Replace with your actual mapping
  Param4_mapping = c("x", "y", "z", "p", "q", "r", "A", "B", "C", "D")  # Replace with your actual mapping
)

# Check for missing combinations
missing_combinations <- generate_all_combinations(your_data) %>%
  anti_join(your_data, by = c("ExperimentID", "Param2")) %>%
  mutate(Param1 = your_data$Param1[match(ExperimentID, unique(your_data$ExperimentID))],
        Param3 = your_data$Param3[match(ExperimentID, unique(your_data$ExperimentID))])

# Add missing combinations (excluding existing values)
your_data <- bind_rows(your_data, missing_combinations)

# Merge with the mapping to get Param4 values
your_data <- your_data %>%
  left_join(param2_to_param4_mapping, by = "Param2") %>%
  mutate(Param4 = coalesce(Param4, Param4_mapping)) %>% 
  select(-Param4_mapping) #Remove the original Param4 mapping column
    

# Sort the result if needed
your_data <- arrange(your_data, ExperimentID, Param2)

#View the data
View(your_data)
