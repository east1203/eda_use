#2019-01-15
#dyk
#description:
#		This script is about ICC software
#
#
close_mw_lib
remove_design -design
set ICC_PATH ["pwd"]
#source $ICC_PATH/scripts/common_setup.tcl
source $ICC_PATH/scripts/synopsys_setup.tcl

## delete previous milkyway design library
if { [file exist $ICC_PATH/$MY_DESIGN]} { file delete -force $ICC_PATH/$MY_DESIGN }

################################################
## create directory to save reports and logs
################################################
if {![file exists $OUTPUTS_PATH]} { file mkdir $OUTPUTS_PATH }
if {![file exists $LOGS_PATH]} { file mkdir $LOGS_PATH }
if {![file exists $REPORTS_PATH]} { file mkdir $REPORTS_PATH }
file delete -force ./outputs/$DESIGN_NAME/*
file delete -force ./reports/$DESIGN_NAME/*
file delete -force ./logs/$DESIGN_NAME/*

################################################
### create milkyway design library
#################################################
#create_mw_lib $MY_DESIGN 				\
#		-technology $TF_PATH/$TF_FILE		\
#		-mw_reference_library	$MW_REF_LIB	\
#		-bus_naming_style {[%d]}	
if {![file exists $DESIGN_PATH/$MY_DESIGN]} {
create_mw_lib $DESIGN_PATH/$MY_DESIGN -technology $TF_PATH/$TF_FILE	-mw_reference_library $MW_REF_LIB -bus_naming_style {[%d]}	
}


open_mw_lib $DESIGN_PATH/$MY_DESIGN
################################################
#set TLUPLus file containing RC coefficient 
################################################
set_tlu_plus_files			\
	-tech2itf_map $TLUPLUS_PATH/$TECH2ITF_MAP	\
	-max_tluplus $TLUPLUS_PATH/$TLUPLUS_MAX_FILE	\
	-min_tluplus $TLUPLUS_PATH/$TLUPLUS_MIN_FILE
#check consistence between TLUPlus files and milkyway design libraries
check_tlu_plus_files
### report milkyway design library 
report_mw_lib -mw_reference_library > $LOGS_PATH/report_mw_lib.log

#save phsical library information to file
write_mw_lib_files -technology -output $OUTPUTS_PATH/$DESIGN_NAME.tf $MY_DESIGN


### verify consistence between logic libraries and physical libraries
check_design > $LOGS_PATH/check_design.log

################################################
## import files
################################################
import_design -format ddc -top $TOP_DESIGN $DC_OUTPUTS/$DESIGN_NAME.ddc
#read_verilog -dirty_netlist -top $TOP_DESIGN $DC_OUTPUTS/$DESIGN_NAME.v
import_design -format  verilog -top  $TOP_DESIGN  $DC_OUTPUTS/$DESIGN_NAME.v
#instance only
uniquify_fp_mw_cel
check_design > $LOGS_PATH/check_design1.log
read_sdc $DC_OUTPUTS/$DESIGN_NAME.sdc

set_fix_multiple_port_nets -all -buffer_constants

#setting power and ground connection
derive_pg_connection -power_net VDD -ground_net VSS
derive_pg_connection -power_net VDD -ground_net VSS -tie
################################################
## check design
################################################
set_zero_interconnect_delay_mode true
## no setup time violation
report_timing > $REPORTS_PATH/init_design_timing.rpt
report_constraint -all_violators > $REPORTS_PATH/init_design_drc.rpt
set_zero_interconnect_delay_mode false

#remove_ideal_network [get_ports $CLK_NAME]
remove_ideal_network -all


#preparing for timing analysis and rc calculation
source ./scripts/timing_rc.tcl

#link cells in design with cells in link library
link -force

save_mw_cel -as init_cel

source ./scripts/fp.tcl > $LOGS_PATH/fp.log

source ./scripts/place.tcl > $LOGS_PATH/place.log

#source ./scripts/cts.tcl > $LOGS_PATH/cts.log

#source ./scripts/route.tcl > $LOGS_PATH/route.log

#close_mw_lib $MY_DESIGN






