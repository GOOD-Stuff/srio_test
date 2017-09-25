// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Fri Sep 22 20:11:26 2017
// Host        : vldmr-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               c:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/tx_axis_gen/tx_axis_gen_stub.v
// Design      : tx_axis_gen
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg676-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_1_2,Vivado 2016.3" *)
module tx_axis_gen(clk, rst, din, wr_en, rd_en, dout, full, almost_full, 
  empty)
/* synthesis syn_black_box black_box_pad_pin="clk,rst,din[64:0],wr_en,rd_en,dout[64:0],full,almost_full,empty" */;
  input clk;
  input rst;
  input [64:0]din;
  input wr_en;
  input rd_en;
  output [64:0]dout;
  output full;
  output almost_full;
  output empty;
endmodule
