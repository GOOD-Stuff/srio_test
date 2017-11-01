// (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.

// IP VLNV: xilinx.com:ip:srio_gen2:4.0
// IP Revision: 5

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
srio_gen2_0 your_instance_name (
  .sys_clkp(sys_clkp),                                            // input wire sys_clkp
  .sys_clkn(sys_clkn),                                            // input wire sys_clkn
  .sys_rst(sys_rst),                                              // input wire sys_rst
  .log_clk_out(log_clk_out),                                      // output wire log_clk_out
  .buf_rst_out(buf_rst_out),                                      // output wire buf_rst_out
  .log_rst_out(log_rst_out),                                      // output wire log_rst_out
  .gt_pcs_rst_out(gt_pcs_rst_out),                                // output wire gt_pcs_rst_out
  .gt_pcs_clk_out(gt_pcs_clk_out),                                // output wire gt_pcs_clk_out
  .cfg_rst_out(cfg_rst_out),                                      // output wire cfg_rst_out
  .deviceid(deviceid),                                            // output wire [15 : 0] deviceid
  .port_decode_error(port_decode_error),                          // output wire port_decode_error
  .s_axis_iotx_tvalid(s_axis_iotx_tvalid),                        // input wire s_axis_iotx_tvalid
  .s_axis_iotx_tready(s_axis_iotx_tready),                        // output wire s_axis_iotx_tready
  .s_axis_iotx_tlast(s_axis_iotx_tlast),                          // input wire s_axis_iotx_tlast
  .s_axis_iotx_tdata(s_axis_iotx_tdata),                          // input wire [63 : 0] s_axis_iotx_tdata
  .s_axis_iotx_tkeep(s_axis_iotx_tkeep),                          // input wire [7 : 0] s_axis_iotx_tkeep
  .s_axis_iotx_tuser(s_axis_iotx_tuser),                          // input wire [31 : 0] s_axis_iotx_tuser
  .m_axis_iorx_tvalid(m_axis_iorx_tvalid),                        // output wire m_axis_iorx_tvalid
  .m_axis_iorx_tready(m_axis_iorx_tready),                        // input wire m_axis_iorx_tready
  .m_axis_iorx_tlast(m_axis_iorx_tlast),                          // output wire m_axis_iorx_tlast
  .m_axis_iorx_tdata(m_axis_iorx_tdata),                          // output wire [63 : 0] m_axis_iorx_tdata
  .m_axis_iorx_tkeep(m_axis_iorx_tkeep),                          // output wire [7 : 0] m_axis_iorx_tkeep
  .m_axis_iorx_tuser(m_axis_iorx_tuser),                          // output wire [31 : 0] m_axis_iorx_tuser
  .s_axi_maintr_rst(s_axi_maintr_rst),                            // input wire s_axi_maintr_rst
  .s_axi_maintr_awvalid(s_axi_maintr_awvalid),                    // input wire s_axi_maintr_awvalid
  .s_axi_maintr_awready(s_axi_maintr_awready),                    // output wire s_axi_maintr_awready
  .s_axi_maintr_awaddr(s_axi_maintr_awaddr),                      // input wire [31 : 0] s_axi_maintr_awaddr
  .s_axi_maintr_wvalid(s_axi_maintr_wvalid),                      // input wire s_axi_maintr_wvalid
  .s_axi_maintr_wready(s_axi_maintr_wready),                      // output wire s_axi_maintr_wready
  .s_axi_maintr_wdata(s_axi_maintr_wdata),                        // input wire [31 : 0] s_axi_maintr_wdata
  .s_axi_maintr_bvalid(s_axi_maintr_bvalid),                      // output wire s_axi_maintr_bvalid
  .s_axi_maintr_bready(s_axi_maintr_bready),                      // input wire s_axi_maintr_bready
  .s_axi_maintr_bresp(s_axi_maintr_bresp),                        // output wire [1 : 0] s_axi_maintr_bresp
  .s_axi_maintr_arvalid(s_axi_maintr_arvalid),                    // input wire s_axi_maintr_arvalid
  .s_axi_maintr_arready(s_axi_maintr_arready),                    // output wire s_axi_maintr_arready
  .s_axi_maintr_araddr(s_axi_maintr_araddr),                      // input wire [31 : 0] s_axi_maintr_araddr
  .s_axi_maintr_rvalid(s_axi_maintr_rvalid),                      // output wire s_axi_maintr_rvalid
  .s_axi_maintr_rready(s_axi_maintr_rready),                      // input wire s_axi_maintr_rready
  .s_axi_maintr_rdata(s_axi_maintr_rdata),                        // output wire [31 : 0] s_axi_maintr_rdata
  .s_axi_maintr_rresp(s_axi_maintr_rresp),                        // output wire [1 : 0] s_axi_maintr_rresp
  .gt_clk_out(gt_clk_out),                                        // output wire gt_clk_out
  .drpclk_out(drpclk_out),                                        // output wire drpclk_out
  .refclk_out(refclk_out),                                        // output wire refclk_out
  .buf_lcl_response_only_out(buf_lcl_response_only_out),          // output wire buf_lcl_response_only_out
  .buf_lcl_tx_flow_control_out(buf_lcl_tx_flow_control_out),      // output wire buf_lcl_tx_flow_control_out
  .idle2_selected(idle2_selected),                                // output wire idle2_selected
  .idle_selected(idle_selected),                                  // output wire idle_selected
  .buf_lcl_phy_buf_stat_out(buf_lcl_phy_buf_stat_out),            // output wire [5 : 0] buf_lcl_phy_buf_stat_out
  .phy_clk_out(phy_clk_out),                                      // output wire phy_clk_out
  .gt0_qpll_clk_out(gt0_qpll_clk_out),                            // output wire gt0_qpll_clk_out
  .gt0_qpll_out_refclk_out(gt0_qpll_out_refclk_out),              // output wire gt0_qpll_out_refclk_out
  .phy_rst_out(phy_rst_out),                                      // output wire phy_rst_out
  .sim_train_en(sim_train_en),                                    // input wire sim_train_en
  .phy_mce(phy_mce),                                              // input wire phy_mce
  .phy_link_reset(phy_link_reset),                                // input wire phy_link_reset
  .force_reinit(force_reinit),                                    // input wire force_reinit
  .phy_lcl_phy_next_fm_out(phy_lcl_phy_next_fm_out),              // output wire [5 : 0] phy_lcl_phy_next_fm_out
  .phy_lcl_phy_last_ack_out(phy_lcl_phy_last_ack_out),            // output wire [5 : 0] phy_lcl_phy_last_ack_out
  .link_initialized(link_initialized),                            // output wire link_initialized
  .phy_lcl_phy_rewind_out(phy_lcl_phy_rewind_out),                // output wire phy_lcl_phy_rewind_out
  .phy_lcl_phy_rcvd_buf_stat_out(phy_lcl_phy_rcvd_buf_stat_out),  // output wire [5 : 0] phy_lcl_phy_rcvd_buf_stat_out
  .phy_rcvd_mce(phy_rcvd_mce),                                    // output wire phy_rcvd_mce
  .phy_rcvd_link_reset(phy_rcvd_link_reset),                      // output wire phy_rcvd_link_reset
  .port_error(port_error),                                        // output wire port_error
  .port_initialized(port_initialized),                            // output wire port_initialized
  .clk_lock_out(clk_lock_out),                                    // output wire clk_lock_out
  .mode_1x(mode_1x),                                              // output wire mode_1x
  .port_timeout(port_timeout),                                    // output wire [23 : 0] port_timeout
  .srio_host(srio_host),                                          // output wire srio_host
  .phy_lcl_master_enable_out(phy_lcl_master_enable_out),          // output wire phy_lcl_master_enable_out
  .phy_lcl_maint_only_out(phy_lcl_maint_only_out),                // output wire phy_lcl_maint_only_out
  .gtrx_disperr_or(gtrx_disperr_or),                              // output wire gtrx_disperr_or
  .gtrx_notintable_or(gtrx_notintable_or),                        // output wire gtrx_notintable_or
  .phy_debug(phy_debug),                                          // output wire [223 : 0] phy_debug
  .srio_txn0(srio_txn0),                                          // output wire srio_txn0
  .srio_txp0(srio_txp0),                                          // output wire srio_txp0
  .srio_rxn0(srio_rxn0),                                          // input wire srio_rxn0
  .srio_rxp0(srio_rxp0),                                          // input wire srio_rxp0
  .srio_txn1(srio_txn1),                                          // output wire srio_txn1
  .srio_txp1(srio_txp1),                                          // output wire srio_txp1
  .srio_rxn1(srio_rxn1),                                          // input wire srio_rxn1
  .srio_rxp1(srio_rxp1)                                          // input wire srio_rxp1
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

// You must compile the wrapper file srio_gen2_0.v when simulating
// the core, srio_gen2_0. When compiling the wrapper file, be sure to
// reference the Verilog simulation library.

