#2019-01-15

#remove previous design
#remove_design -design
#remove previous design and library
#remove_design -all

#preparing libraries

set ICC_PATH ["pwd"]
source $ICC_PATH/scripts/common_setup.tcl

lappend search_path $SEARCH_PATH

set_app_var target_library $TARGET_LIBRARY
set_app_var link_library $LINK_LIBRARY
set_app_var symbol_library $SYMBOL_LIBRARY
#set_min_library "SP018W_V1p8_max.db" -min_version "SP018W_V1p8_min.db"
#set_min_library "scc018ug_uhd_rvt_ss_v1p08_125c_basic.db" -min_version 	\
#			"scc018ug_uhd_rvt_ff_v1p32_0c_basic.db"

#check_library
check_library > $LOGS_PATH/check_lib.log



