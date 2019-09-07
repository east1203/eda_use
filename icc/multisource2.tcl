
#2019-01-17
#
#cluster registers 
#using multisource tree flow
#
#
set reg_coll [all_registers]
set reg [get_object_name $reg_coll]

set reg_list ""
set reg_tmp ""
set x 0
set y 0
set x0 0
set y0 0
set xy ""

set nu15 0
set x0 0
set y0 0
set index0 0
for {set j 0} {$j < [llength $reg]} {incr j} {
	
	set nu15 [expr $nu15+1]
#	for {set i 0} {$i < 15} { incr i} {
#		lappend x0 [lindex [get_location [lindex $reg $j]] 0]
#		lappend y0 [lindex [get_location [lindex $reg $j]] 1]
#	} 
	# get registers' locations and add their them up
	set x1 [lindex [get_location [lindex $reg $j]] 0]
	set y1 [lindex [get_location [lindex $reg $j]] 1]
	set x0 [expr $x0+$x1]
	set y0 [expr $y0+$y1]
#	set x0 [expr $x0+[lindex [get_location [lindex $reg $j]] 0]]
#	set y0 [expr $y0+[lindex [get_location [lindex $reg $j]] 1]]
	lappend reg_tmp [lindex $reg $j]
	#select 15 registers and calculate their centrial locations
	if {$nu15 == 15} {	
		set x [expr $x0/15]
		set y [expr $y0/15]	
		lappend xy [list $x $y ]
		set x0 0
		set y0 0
		set nu15 0
		lappend reg_list $reg_tmp
		set reg_tmp {}
	}
	if {$j == [expr [llength $reg]-1]} {
		set x [expr $x0/$nu15]
		set y [expr $y0/$nu15]
		lappend xy [list $x $y ]
		lappend reg_list $reg_tmp
	}
	
	
}
#add_multisource_drivers -mesh_net CLK \
#-prefix TAP_ -driver_type my_lib/clkbuff10 \
#-tap_locations {{400 500} {600 700}}









