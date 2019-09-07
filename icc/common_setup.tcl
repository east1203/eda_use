##2019-01-19
##description:
##	common viriables


###########################################
## USER specify
############################################
set DESIGN_NAME s5378_bench
set MY_DESIGN [join "$DESIGN_NAME mw" . ]
set TOP_DESIGN $DESIGN_NAME 
set CLK_NAME "blif_clk_net"
#set CLK_NAME "iccad_clk"
###########################################
##path
############################################
set ICC_PATH ["pwd"]
set TF_PATH "./../ref/tf"
set TLUPLUS_PATH "./../ref/tluplus/TD-LO40-XS-2008v0R_1PxM_1TM9k_ALPA28k/1P9M_1TM"
set MW_LIB_PATH "./../ref/mw_lib"
set LEF_PATH "./../ref/lef"
set DC_OUTPUTS $ICC_PATH/../dc/outputs/$DESIGN_NAME
set OUTPUTS_PATH $ICC_PATH/outputs/$DESIGN_NAME
set LOGS_PATH $ICC_PATH/logs/$DESIGN_NAME
set REPORTS_PATH $ICC_PATH/reports/$DESIGN_NAME
set DESIGN_PATH $ICC_PATH
################################################
## mkdir for design
################################################
if {![file exists $OUTPUTS_PATH]} { file mkdir $OUTPUTS_PATH }
if {![file exists $LOGS_PATH]} { file mkdir $LOGS_PATH }
if {![file exists $REPORTS_PATH]} { file mkdir $REPORTS_PATH }

###########################################
## libraries
############################################
set SEARCH_PATH [list "./../ref/liberty/1.1v" 			\
							"./../ref/sdb"			\
							"./../ref/tf"		\
							"./../ref/tluplus/TD-LO40-XS-2008v0R_1PxM_1TM9k_ALPA28k/1P9M_1TM"		\
							"./../src/iscas/rtl"	\
			"./../ref/liberty/IO/1p8v"
					]
set TARGET_LIBRARY [join "scc40nll_hdc40_hvt_tt_v1p1_25c_basic.db SP40NLLD2RNP_OV3_V1p1_ff_V1p21_0C.db
			"]

set LINK_LIBRARY [join "* $TARGET_LIBRARY"]
set SYMBOL_LIBRARY [join "scc40nll_hdc40_hvt.sdb"]

set TF_FILE "scc40nll_hd_7lm_1tm.tf"
set LOGIC_LIB "scc40nll_hdc40_hvt_tt_v1p1_25c_basic"
set MW_REF_LIB [join "$MW_LIB_PATH/SP40NLLD2RNP_OV3_V1p1_7MT_1TM		\
			$MW_LIB_PATH/scc40nll_hdc40_hvt
		"]
#set TLUPLUS_MAX_FILE StarRC_40LL_1P7M_1TM_ALPA28K_CMAX.tluplus
#set TLUPLUS_MIN_FILE StarRC_40LL_1P7M_1TM_ALPA28K_CMIN.tluplus
#set TECH2ITF_MAP StarRC_40LL_1P7M_1TM_cell.map

set TLUPLUS_MAX_FILE StarRC_40LL_1P9M_1TM_ALPA28K_CMAX.tluplus
set TLUPLUS_MIN_FILE StarRC_40LL_1P9M_1TM_ALPA28K_CMIN.tluplus
set TECH2ITF_MAP StarRC_40LL_1P9M_1TM_cell.map









