
#2019-01-19
#
#cluster registers 
#
#insert buffers according to the result from the clustering result file



set ICC_PATH ["pwd"]
source $ICC_PATH/scripts/common_setup.tcl

##############################################################
## user settings
##############################################################
## buffer type
set INSERT_BUFFER_TYPE scc018ug_uhd_rvt_ff_v1p32_0c_basic/CLKBUFUHDV8
## the file containing clusters results
set CLUSTERS_FILE_PATH reg
## $INSERT is "True" and $REMOVE is "False",then insert buffers
set INSERT "True"
## $RMOVE is "False",then remove the inserted buffers
set REMOVE "False"
##############################################################
## distribute registers to different clusters
##############################################################
set reg_coll [all_registers]
set reg [get_object_name $reg_coll]
# $reg_list :contains registers' CK pins of all clusters
set reg_list ""
# $reg_tmp :temporarily contains registers' CK pins of every clusters
set reg_tmp ""
set x 0
set y 0
set x0 0
set y0 0
# xy : contains clusters centers cordination pairs
set xy ""
set fp ""
##############################################################
## read register cluster results from files
##############################################################
set fp [open $CLUSTERS_FILE_PATH r+]
while {[gets $fp line]>0} {
	for {set i 0} {$i < [llength $line]} {incr i} {
		#add up cordinations
		set reg_i [lindex $line $i]
		set x0 [expr $x0+[lindex [get_location [lindex $reg $reg_i]] 0]]
		set y0 [expr $y0+[lindex [get_location [lindex $reg $reg_i]] 1]]
		lappend reg_tmp [join "[lindex $reg [lindex $line $i]] CK" "/"]
	}
	# calculation clusters center
	set x [format "%.2f" [expr $x0/[llength $line]]]
	set y [format "%.2f" [expr $y0/[llength $line]]]
	set x0 0
	set y0 0
	lappend xy [list $x $y ]
	lappend reg_list $reg_tmp
	set reg_tmp ""
	
}
##############################################################
## insert buffers 
##############################################################
set CLUSTERS_NUM [llength $reg_list]
set NET_PREFIX eco_buffer_net
set CELL_PREFIX eco_buffer_cel
set LO ""
set LOCA ""
if {$INSERT && !$REMOVE} {

	for {set i 0} {$i < $CLUSTERS_NUM} {incr i} {
		set LOCA [join "[lindex $xy $i]"]
##bi xu yao duo fu zhi yi ci ,yao bu ran chu cuo 
		set LO $LOCA   
		insert_buffer 							\
		-new_net_names [join "$NET_PREFIX $i" "_"]			\
		-new_cell_names [join "$CELL_PREFIX $i" "_"]			\
		-no_of_cells 1							\
		-location $LO							\
		[lindex $reg_list $i]						\
		$INSERT_BUFFER_TYPE
		#-location $LO							\
	#	set inv_name [join "$CELL_PREFIX $i" "_"]
   	#	set net_name [join "$NET_PREFIX $i" "_"] 
   	#	create_cell $inv_name $INSERT_BUFFER_TYPE
   	#	create_net $net_name
   	#	disconnect_net {blif_clk_net}  [lindex $reg_list $i]
   	#	connect_net $net_name  [lindex $reg_list $i]
   	#	set inv_name_zn $inv_name
   	#	append inv_name_zn "/ZN"
   	#	set inv_name_i $inv_name
   	#	append inv_name_i "/I"
   	#	connect_net $net_name  $inv_name_zn 
   	#	# connect_net {blif_clk_net}  $inv_name_i
   	#	connect_net {blif_clk_net} $inv_name_i

	}

	# adjust buffer locations
	legalize_placement -cells [get_cells $CELL_PREFIX*] -priority high
	## set inserted buffers' location fixed
	set_object_fixed_edit [get_cells $CELL_PREFIX*] 1
	## set dont_size_cells attribute to inserted buffers
	#set_clock_tree_exceptions -dont_size_cells [get_cells $CELL_PREFIX*]
	#set_clock_tree_exceptions -dont_touch_subtrees [get_pins $CELL_PREFIX*/Z]

}
##############################################################
## remove buffers 
##############################################################
if {$REMOVE} {
	remove_buffer $CELL_PREFIX*
}










