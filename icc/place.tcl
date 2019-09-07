#
#2019-01-16
#description :
#	placement

set ICC_PATH ["pwd"]
source $ICC_PATH/scripts/common_setup.tcl

place_opt -congestion -effort low -area_recovery
#setting power and ground connection
derive_pg_connection -power_net VDD -ground_net VSS
derive_pg_connection -power_net VDD -ground_net VSS -tie

report_congestion > reports/$DESIGN_NAME/place_cong.rpt
report_timing > reports/$DESIGN_NAME/place_timing.rpt
report_constraint -all_violators > reports/$DESIGN_NAME/place_const.rpt

save_mw_cel -as place_cel
