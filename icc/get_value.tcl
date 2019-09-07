
set logic_lib scc018ug_uhd_rvt_ff_v1p32_0c_basic
set reg_type DSNQUHDV1
set reg_ck_load [load_of $logic_lib/$reg_type/CK]
puts "The load of register's CK pin is [format "%f" $reg_ck_load] pF"

##############################################################
#
set cell_name CLKBUFUHDV16
set cell_pin Z
## buffer's max capacitance
set max_capa [get_attribute $logic_lib/$cell_name/$cell_pin max_capacitance]
puts "The max capacitance of $cell_name $cell_pin pin is \
				[format "%f" $max_capa] pF"
## 
set buffer_in_capa [load_of $logic_lib/$cell_name/I]
puts "The input capacitance os $cell_name I is [format "%f" $buffer_in_capa] pF"

