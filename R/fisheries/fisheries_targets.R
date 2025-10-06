# # R/fisheries/fisheries_pipeline.R

# fisheries_targets <- function() {
#   list(
#     # 1. Track your raw data file as an input dependency
#     tar_file(
#       raw_fisheries_file,
#       "data/raw/fisheries_source.csv"
#     ),

#     # 2. Read the raw data file
#     tar_target(
#       raw_fisheries_data,
#       load_fisheries_data(raw_fisheries_file)
#     ),

#     # 3. Process and clean the data
#     tar_target(
#       processed_fisheries_data,
#       process_fisheries_data(raw_fisheries_data)
#     ),

#     # 4. Export the processed dataset — tracked as an output file
#     tar_file(
#       exported_fisheries_data,
#       export_fisheries_data(processed_fisheries_data, "data/processed/fisheries_clean.csv")
#     )
#   )
# }
