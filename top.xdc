#-----------------------------------------------------------------------------
#
# File name:    srio_gen2_0.xdc
# Rev:          4.0
# Description:  This module constrains the example design
#
#-----------------------------------------------------------------------------
######################################
#         Core Time Specs            #
######################################

create_clock -period 6.4 -name sys_clkp [get_ports sys_clkp]
set_case_analysis 0 [list [get_pins -hierarchical *mode_1x]]


#set_multicycle_path -from [get_pins *cfg_raddr_reg* -hierarchical] -to [get_pins *cfg_reg*rdata_reg* -hierarchical] 3
#set_multicycle_path -from [get_pins *cfg_raddr_reg* -hierarchical] -to [get_pins *cfg_reg*rdata_reg* -hierarchical] 2 -hold

################################################################################
######################################################
##       GT and other Pin Locations                  #
## NOTE: These pins need to be updated for device:   #
## "xc7k160tffg676-2"#
## Below LOC's are given as dummy LOC's and          #
## need to be updated by the user                    #
######################################################

set_property PACKAGE_PIN H5 [get_ports sys_clkn]
set_property PACKAGE_PIN H6 [get_ports sys_clkp]

set_property LOC R4  [get_ports srio_rxp0]
set_property LOC R3  [get_ports srio_rxn0]

set_property LOC P2  [get_ports srio_txp0]
set_property LOC P1  [get_ports srio_txn0]


set_property LOC GTXE2_CHANNEL_X0Y0 [get_cells -hier -nocase -regexp {.*/gt_wrapper_i/gt0_gt_wrapper_i/gt.e2_i}]

##  set_property LOC G8  [get_ports sys_clkp]
##  set_property LOC G7  [get_ports sys_clkn]
##  set_property LOC K18 [get_ports sys_rst]
##  
##  set_property LOC A20 [get_ports led0[7]]
##  set_property LOC A17 [get_ports led0[6]]
##  set_property LOC A16 [get_ports led0[5]]
##  set_property LOC B20 [get_ports led0[4]]
##  set_property LOC C20 [get_ports led0[3]]
##  set_property LOC F17 [get_ports led0[2]]
##  set_property LOC G17 [get_ports led0[1]]
##  set_property LOC B17 [get_ports led0[0]]
##  
##  set_property LOC C19 [get_ports sim_train_en]
##  
##  set_property IOSTANDARD LVCMOS18 [get_ports sys_rst]
##  set_property IOSTANDARD LVCMOS18 [get_ports sim_train_en]
##  
##  set_property IOSTANDARD LVCMOS18 [get_ports led0[7]]
##  set_property IOSTANDARD LVCMOS18 [get_ports led0[6]]
##  set_property IOSTANDARD LVCMOS18 [get_ports led0[5]]
##  set_property IOSTANDARD LVCMOS18 [get_ports led0[4]]
##  set_property IOSTANDARD LVCMOS18 [get_ports led0[3]]
##  set_property IOSTANDARD LVCMOS18 [get_ports led0[2]]
##  set_property IOSTANDARD LVCMOS18 [get_ports led0[1]]
##  set_property IOSTANDARD LVCMOS18 [get_ports led0[0]]