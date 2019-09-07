#2019-01-15
#
#preparing for timing analysis and rc calculation
#
#
##report_operating_condition -library $lib_name
#

##set operating condition ,if define in .sdc, ignore here
#set_operating_condition -min $$ -min_library $$ -max $$ -max_library $$
#


##setting timing
#
#set_clock_uncertainty 
#set_clock_lantency
#set_clock_transition
#

#set_delay_calculation_options 
#
## preroute delay calculaton options 
set_delay_calculation_options -preroute awe -awe_effort high
## set delay calculation options for clock net and postroute
set_delay_calculation_options -routed_clock arnoldi
set_delay_calculation_options -postroute arnoldi


## import standard delay format file






