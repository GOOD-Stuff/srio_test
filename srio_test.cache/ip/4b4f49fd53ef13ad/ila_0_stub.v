// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Wed Sep 20 12:59:30 2017
// Host        : vldmr-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ ila_0_stub.v
// Design      : ila_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg676-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2016.3" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clk, probe0, probe1, probe2, probe3, probe4, probe5, 
  probe6, probe7, probe8, probe9, probe10, probe11)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[63:0],probe1[63:0],probe2[0:0],probe3[0:0],probe4[0:0],probe5[0:0],probe6[3:0],probe7[7:0],probe8[7:0],probe9[1:0],probe10[0:0],probe11[0:0]" */;
  input clk;
  input [63:0]probe0;
  input [63:0]probe1;
  input [0:0]probe2;
  input [0:0]probe3;
  input [0:0]probe4;
  input [0:0]probe5;
  input [3:0]probe6;
  input [7:0]probe7;
  input [7:0]probe8;
  input [1:0]probe9;
  input [0:0]probe10;
  input [0:0]probe11;
endmodule
