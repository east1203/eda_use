
#2019-01-15
#
#floorplan scripts
#
set ICC_PATH ["pwd"]
source $ICC_PATH/scripts/common_setup.tcl

#create_floorplan 

#create_floorplan -core_aspect_ratio 1 -core_utilization 0.5 -left_io2core 10.0 -bottom_io2core 10.0 -right_io2core 10.0 -top_io2core 10.0
create_floorplan -core_aspect_ratio 1 -core_utilization 0.5 


# write_def 
save_mw_cel -as fp_cel

