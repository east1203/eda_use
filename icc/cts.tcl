## 2019-01-16
#description:
##	common clock tree synthesis flow
#########################################################
############################################################
## 40 nm labs #############
###########################
set ICC_PATH ["pwd"]
source $ICC_PATH/scripts/common_setup.tcl
set LAB_NAME scc40nll_hdc40_hvt_tt_v1p1_25c_basic
###########################################
## Control CTS
############################################
set S_CLK_REF "True"
###########################################
##CTS settings
############################################
if { $S_CLK_REF } {
	set CLK_REF_CELL [join "{CLKBUFV12RQ_8TH40 CLKBUFV12_8TH40 CLKBUFV16RQ_8TH40 CLKBUFV16_8TH40 CLKBUFV20RQ_8TH40 CLKBUFV20_8TH40 CLKBUFV24RQ_8TH40 CLKBUFV24_8TH40 CLKBUFV2_8TH40 CLKBUFV32RQ_8TH40 CLKBUFV32_8TH40 CLKBUFV3_8TH40 CLKBUFV40RQ_8TH40 CLKBUFV40_8TH40 CLKBUFV48RQ_8TH40 CLKBUFV48_8TH40 CLKBUFV4_8TH40 CLKBUFV5RQ_8TH40 CLKBUFV5_8TH40 \
CLKBUFV6RQ_8TH40 CLKBUFV6_8TH40 CLKBUFV8RQ_8TH40 CLKBUFV8_8TH40 }"]
	set CLK_REF_CELL2 [join "{CLKBUFV24_8TH40 }"]
	## setting clock tree reference cell(buffers or inverter types)
	set_clock_tree_references -clock_trees [all_clocks] -references $CLK_REF_CELL2 -delay_insertion_only -sizing_only
}
set CLK_ROOT_DRIVING_CELL scc40nll_hdc40_hvt_tt_v1p1_25c_basic/BUFV24_8TH40
set MAX_FANOUT 40
set MAX_TRANSITION ""
set MAX_CAPACITANCE ""

## setting clock root driving cell
#set_driving_cell -library LAB_NAME  -lib_cell $CLK_ROOT_DRIVING_CELL [get_ports $CLK_NAME]


############################################################################
## specifying clock tree synthesis goals: design rule and timing constraints
############################################################################
	## design rule : max_capacitance max_transition max_fanout
	set_clock_tree_options -max_fanout $MAX_FANOUT -clock_trees "CLK"
	## timing constraint: skew  insertion_delay

############################################################################
## SET routing rules
############################################################################
#report_routing_rules
#define_routing_rule 2X_SPACING -spacings {METAL2 0.6 METAL3 0.6 METAL4 0.8 METAL5 1.2 METAL6 1.4}
#define_routing_rule 2X_SPACING	\
#	-widths {M1 0.14 M2 0.14 M3 0.14 M4 0.14 M5 0.14 M6 0.14 M7 0.14 M8 0.14 }  \
#	-spacings {M1 0.14 M2 0.14 M3 0.14 M4 0.14 M5 0.14 M6 0.14 M7 0.14 M8 0.14}
#set_clock_tree_options -clock_tree [all_clocks] -routing_rule 2X_SPACING -layer_list "METAL4 METAL5"
set_clock_tree_options -clock_tree [all_clocks] -layer_list "METAL4 METAL5"

remove_ideal_network -all

### define in timing_rc.tcl file 
## preroute delay calculaton options 
#set_delay_calculation_options -preroute awe awe_effort high
## set delay calculation options for clock net and postroute
#set_delay_calculation_options -routed_clock arnoldi
#set_delay_calculation_options -postroute arnoldi

#save clock tree construction
set_clock_tree_options -config_file_write $OUTPUTS_PATH/config_file

## CTS 
clock_opt -only_cts -no_clock_route
save_mw_cel -as clock_opt_cts

set_fix_hold [all_clocks]
extract_rc
## -only-psyn  optimize timing and placement 
clock_opt_ -only_psyn -area_recovery -no_clock_route
save_mw_cel -as clock_opt_psyn
## route clock nets
route_zrt_group -all_clock_nets -reuse_existing_global_route true
save_mw_cel -as clock_opt_route

report_clock_tree -summary > $REPORTS_PATH/cts.rpt
report_clock_tree >> $REPORTS_PATH/cts.rpt





