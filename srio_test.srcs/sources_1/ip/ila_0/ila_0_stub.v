// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Tue Sep 19 16:52:32 2017
// Host        : vldmr-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               C:/Projects/srio_test/srio_test/srio_test.srcs/sources_1/ip/ila_0/ila_0_stub.v
// Design      : ila_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg676-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2016.3" *)
module ila_0(clk, probe0, probe1, probe2, probe3, probe4, probe5, 
  probe6)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[63:0],probe1[63:0],probe2[0:0],probe3[0:0],probe4[0:0],probe5[3:0],probe6[3:0]" */;
  input clk;
  input [63:0]probe0;
  input [63:0]probe1;
  input [0:0]probe2;
  input [0:0]probe3;
  input [0:0]probe4;
  input [3:0]probe5;
  input [3:0]probe6;
endmodule
