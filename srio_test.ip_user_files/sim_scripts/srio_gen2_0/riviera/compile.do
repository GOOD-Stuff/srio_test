vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/blk_mem_gen_v8_3_4
vlib riviera/fifo_generator_v13_1_2
vlib riviera/srio_gen2_v4_0_5

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap blk_mem_gen_v8_3_4 riviera/blk_mem_gen_v8_3_4
vmap fifo_generator_v13_1_2 riviera/fifo_generator_v13_1_2
vmap srio_gen2_v4_0_5 riviera/srio_gen2_v4_0_5

vlog -work xil_defaultlib  -sv2k12 \
"C:/Xilinx/Vivado/2016.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2016.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2016.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work blk_mem_gen_v8_3_4  -v2k5 \
"../../../ipstatic/simulation/blk_mem_gen_v8_3.v" \

vlog -work fifo_generator_v13_1_2  -v2k5 \
"../../../ipstatic/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_1_2 -93 \
"../../../ipstatic/hdl/fifo_generator_v13_1_rfs.vhd" \

vlog -work fifo_generator_v13_1_2  -v2k5 \
"../../../ipstatic/hdl/fifo_generator_v13_1_rfs.v" \

vlog -work srio_gen2_v4_0_5  -v2k5 \
"../../../ipstatic/hdl/srio_gen2_v4_0_rfs.v" \

vcom -work srio_gen2_v4_0_5 -93 \
"../../../ipstatic/hdl/srio_gen2_v4_0_rfs.vhd" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../srio_test.srcs/sources_1/ip/srio_gen2_0/synth/srio_gen2_0_srio_clk.v" \
"../../../../srio_test.srcs/sources_1/ip/srio_gen2_0/synth/srio_gen2_0_srio_rst.v" \
"../../../../srio_test.srcs/sources_1/ip/srio_gen2_0/synth/cfg_fabric_srio_gen2_0.v" \
"../../../../srio_test.srcs/sources_1/ip/srio_gen2_0/synth/srio_gen2_0_k7_v7_gtxe2_common.v" \
"../../../../srio_test.srcs/sources_1/ip/srio_gen2_0/synth/srio_gen2_0_gtx_GT.v" \
"../../../../srio_test.srcs/sources_1/ip/srio_gen2_0/synth/srio_gen2_0_gtxe2_init.v" \
"../../../../srio_test.srcs/sources_1/ip/srio_gen2_0/synth/srio_gen2_0_gtx_multi_gt.v" \
"../../../../srio_test.srcs/sources_1/ip/srio_gen2_0/synth/srio_gen2_0_gtxe2_rx_startup_fsm.v" \
"../../../../srio_test.srcs/sources_1/ip/srio_gen2_0/synth/srio_gen2_0_gtxe2_sync_block.v" \
"../../../../srio_test.srcs/sources_1/ip/srio_gen2_0/synth/srio_gen2_0_gtxe2_tx_startup_fsm.v" \
"../../../../srio_test.srcs/sources_1/ip/srio_gen2_0/synth/srio_gt_wrapper_srio_gen2_0_k7_2x.v" \
"../../../../srio_test.srcs/sources_1/ip/srio_gen2_0/synth/srio_gen2_0_support.v" \
"../../../../srio_test.srcs/sources_1/ip/srio_gen2_0/synth/srio_gen2_0_block.v" \
"../../../../srio_test.srcs/sources_1/ip/srio_gen2_0/synth/srio_gen2_0.v" \

vlog -work xil_defaultlib "glbl.v"

