# # R/mokus_layer/mokus_targets.R

# mokus_targets <- function() {
#   list(
#     # 1. Track your raw data file as an input dependency
#     tar_file(
#       raw_marine_mokus_file,
#       "data/mokus/raw/marine_mokus/.shp"
#     ),
#     tar_file(
#       raw_terrestrial_mokus_file,
#       "data/mokus/raw/terrestrial_mokus/.shp"
#     ),


#     # 2. Read the raw data file
#     tar_target(
#       raw_marine_mokus_layer,
#       load_mokus_layer(raw_marine_mokus_file)
#     ),
#     tar_target(
#       raw_terrestrial_mokus_layer,
#       load_mokus_layer(raw_terrestrial_mokus_file)
#     ),

#     # 3. Process and clean the data
#     tar_target(
#       processed_marine_mokus_layer,
#       process_marine_mokus_layer(raw_marine_mokus_layer)
#     ),
#     tar_target(
#       processed_terrestrial_mokus_layer,
#       process_terrestrial_mokus_layer(raw_terrestrial_mokus_layer)
#     ),

#     # 4. Export the processed dataset — tracked as an output file
#     tar_file(
#       exported_mokus_layer,
#       export_mokus_layer(processed_mokus_layer, "data/mokus/processed/")
#     )
#   )
# }
