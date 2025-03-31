# Baseflow separation -- A practical approach

This GitHub repository contains R code written by Flora Hilt which implements Duncan's approach to baseflow separation:

Duncan, H. P. (2019). Baseflow separation -- A practical approach. *Journal of Hydrology*, 575, 308--313. <https://doi.org/10.1016/j.jhydrol.2019.05.040>​

This script can be used to separate baseflow from total flow. This repository is a work in progress and is open for discussion and review. The workflow is described below.

**Input Data**

The script reads an Excel file containing daily river flow data. The expected format includes:

Date/Time column: Timestamps of flow measurements.

Mean flow (ML/day) column: Daily river flow in ML/day.

**Methodology**

The Duncan method follows these steps:

\- Reverse the flow data to apply a backward filter.

\- Apply a time decay factor based on the recession coefficient (k).

\- Compute quickflow (surface runoff component).

\- Derive baseflow (groundwater contribution).

\- Restore the original order of the data.

**How to run**

\- Install required R libraries if not already installed:

install.packages("readxl")

install.packages("writexl")

\- Set the correct file path for your dataset:

file_path \<- "path of the file/FileName.xlsx"

\- Choose a recession coefficient (k):

k_chosen \<- 0.97 \# Modify this value as needed

\- Run the script in RStudio or any R environment.

\- The script generates an Excel file containing:

Date: Original timestamps.

Total_Flow: Observed total river flow.

Baseflow: Estimated baseflow using the Duncan method.

\- The file is saved as: "duncan_baseflow_results_0.97.xlsx"

(where 0.97 corresponds to the chosen k-value)

**Additional features**

Handles missing values (NA) by removing them.

**Note**

The recession coefficient (k) typically ranges between 0.90 and 0.99 depending on the watershed characteristics.

The choice of k influences the smoothness of baseflow:

Higher k values → Slower recession, more groundwater influence.

Lower k values → Faster flow separation, more runoff influence.

**Note**

For any issues or improvements, feel free to reach out : flora.hilt\@insa-lyon.fr (original author) or matthew.burns\@unimelb.edu.au
