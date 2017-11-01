

##
## Create Clock Constraints on BSCAN ports TCK & UPDATE
##
create_clock -period 33 [get_pins SWITCH_N_EXT_BSCAN.bscan_inst/SERIES7_BSCAN.bscan_inst/TCK]
##
## Timing Exceptions on TCK & UPDATE clocks
##
set_false_path -through [get_pins SWITCH_N_EXT_BSCAN.bscan_inst/SERIES7_BSCAN.bscan_inst/SHIFT]
set_clock_groups -asynchronous -group  [list [get_clocks -of_objects [get_pins SWITCH_N_EXT_BSCAN.bscan_inst/SERIES7_BSCAN.bscan_inst/TCK]]]




