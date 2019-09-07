set ICC_PATH ["pwd"]
source $ICC_PATH/scripts/common_setup.tcl


set INSERT "True"
set INSERT_BUFFER_TYPE scc018ug_uhd_rvt_ff_v1p32_0c_basic/CLKBUFUHDV8


set reg_coll [all_registers]
set reg [get_object_name $reg_coll]
set ssize [llength $reg]
set half [expr $ssize/2]
set reg_list ""
set x0 0
set y0 0
set x 0
set y 0
for {set i 0} {$i < $half} {incr i} {
	set reg_i [lindex $reg $i]
	set x0 [expr $x0+[lindex [get_location [lindex $reg $i]] 0]]
	set y0 [expr $y0+[lindex [get_location [lindex $reg $i]] 1]]	
	lappend reg_list [append reg_i "/CK"]
}
set x  [format "%.2f" [expr $x0/$half]]
set y  [format "%.2f" [expr $y0/$half]]

##############################################################
## insert buffers 
##############################################################
set CLUSTERS_NUM [llength $reg_list]
set NET_PREFIX eco_buffer_net
set CELL_PREFIX eco_buffer_cel
set LOCA [list $x $y]
if {$INSERT} {
	insert_buffer 							\
			-new_net_names  "$NET_PREFIX" 			\
			-new_cell_names "$CELL_PREFIX" 			\
			-no_of_cells 1							\
			-location $LOCA							\
			$reg_list						\
			$INSERT_BUFFER_TYPE

}

	legalize_placement -cells [get_cells $CELL_PREFIX*] -priority high
	## set inserted buffers' location fixed
	set_object_fixed_edit [get_cells $CELL_PREFIX*] 1

create_generated_clock -name "ECOCLK" -source CLK [get_pins $CELL_PREFIX/Z]

