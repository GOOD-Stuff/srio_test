vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../srio_test.srcs/sources_1/ip/ila_0/hdl/verilog" "+incdir+../../../../srio_test.srcs/sources_1/ip/ila_0/hdl/verilog" \
"C:/Xilinx/Vivado/2016.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2016.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2016.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../srio_test.srcs/sources_1/ip/ila_0/hdl/verilog" "+incdir+../../../../srio_test.srcs/sources_1/ip/ila_0/hdl/verilog" \
"../../../../srio_test.srcs/sources_1/ip/ila_0/sim/ila_0.v" \

vlog -work xil_defaultlib "glbl.v"

