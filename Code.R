library(readxl)
library(writexl)

# Duncan method
duncan_method <- function(total_flow, c, k) {
  
  # Step 1: Reverse the order of the data
  reverse_total_flow <- rev(total_flow)
  
  # Step 2: Add a constant (default is 0)
  reverse_total_flow <- reverse_total_flow + c 
  
  # Step 3: Compute time factor
  time_factor <- numeric(length(reverse_total_flow))
  time_factor[1] <- reverse_total_flow[1]
  
  for (i in 1:(length(reverse_total_flow)-1)) {
    time_factor[i+1] <- min(reverse_total_flow[i+1], time_factor[i] / k)
  }
  
  # Step 4: Subtract the constant
  time_factor <- time_factor - c
  
  # Step 5: Restore original order
  mrc_data <- rev(time_factor)
  
  # Step 6: Compute quickflow
  quickflow <- numeric(length(mrc_data))
  quickflow[1] <- 0
  
  for (i in 1:(length(mrc_data)-1)) {
    quickflow[i+1] <- max(0, quickflow[i]*k + (mrc_data[i+1]-mrc_data[i])*(1+k)*0.5)
  }
  
  # Step 7: Compute baseflow
  baseflow <- mrc_data - quickflow
  
  return(baseflow)
}

# Read input data from an Excel file
file_path <- "D:/Flora/Documents/Dunca/Lysterfield-Daily-Rainfall_ladson.xlsx"  # Replace with your file path
data <- read_excel(file_path)

# Convert flow data to numeric
data$Flow_ml_day <- as.numeric(gsub(",", ".", data$`Mean flow (ML/day)`))

# Remove NA values
data <- data[!is.na(data$Flow_ml_day), ]

# Choose a specific k value
k_chosen <- 0.97  # Modify this value as needed

# Compute baseflow using the selected k value
results <- data.frame(
  Date = data$`Date/Time`,
  Total_Flow = data$Flow_ml_day,
  Baseflow = duncan_method(data$Flow_ml_day, c = 0, k = k_chosen)
)

# Export results to an Excel file

output_file <- paste0("duncan_baseflow_results_k", k_chosen, ".xlsx")
write_xlsx(results, output_file)

cat("Results have been exported to:", output_file)
