vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../srio_test.srcs/sources_1/ip/dbg_ila/hdl/verilog" "+incdir+../../../../srio_test.srcs/sources_1/ip/dbg_ila/hdl/verilog" \
"C:/Xilinx/Vivado/2016.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2016.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"C:/Xilinx/Vivado/2016.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../../srio_test.srcs/sources_1/ip/dbg_ila/hdl/verilog" "+incdir+../../../../srio_test.srcs/sources_1/ip/dbg_ila/hdl/verilog" \
"../../../../srio_test.srcs/sources_1/ip/dbg_ila/sim/dbg_ila.v" \

vlog -work xil_defaultlib "glbl.v"

