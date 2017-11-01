-- (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:ip:srio_gen2:4.0
-- IP Revision: 5

-- The following code must appear in the VHDL architecture header.

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
COMPONENT srio_gen2_0
  PORT (
    sys_clkp : IN STD_LOGIC;
    sys_clkn : IN STD_LOGIC;
    sys_rst : IN STD_LOGIC;
    log_clk_out : OUT STD_LOGIC;
    buf_rst_out : OUT STD_LOGIC;
    log_rst_out : OUT STD_LOGIC;
    gt_pcs_rst_out : OUT STD_LOGIC;
    gt_pcs_clk_out : OUT STD_LOGIC;
    cfg_rst_out : OUT STD_LOGIC;
    deviceid : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    port_decode_error : OUT STD_LOGIC;
    s_axis_iotx_tvalid : IN STD_LOGIC;
    s_axis_iotx_tready : OUT STD_LOGIC;
    s_axis_iotx_tlast : IN STD_LOGIC;
    s_axis_iotx_tdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    s_axis_iotx_tkeep : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s_axis_iotx_tuser : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_iorx_tvalid : OUT STD_LOGIC;
    m_axis_iorx_tready : IN STD_LOGIC;
    m_axis_iorx_tlast : OUT STD_LOGIC;
    m_axis_iorx_tdata : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axis_iorx_tkeep : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    m_axis_iorx_tuser : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_maintr_rst : IN STD_LOGIC;
    s_axi_maintr_awvalid : IN STD_LOGIC;
    s_axi_maintr_awready : OUT STD_LOGIC;
    s_axi_maintr_awaddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_maintr_wvalid : IN STD_LOGIC;
    s_axi_maintr_wready : OUT STD_LOGIC;
    s_axi_maintr_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_maintr_bvalid : OUT STD_LOGIC;
    s_axi_maintr_bready : IN STD_LOGIC;
    s_axi_maintr_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_maintr_arvalid : IN STD_LOGIC;
    s_axi_maintr_arready : OUT STD_LOGIC;
    s_axi_maintr_araddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_maintr_rvalid : OUT STD_LOGIC;
    s_axi_maintr_rready : IN STD_LOGIC;
    s_axi_maintr_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_maintr_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    gt_clk_out : OUT STD_LOGIC;
    drpclk_out : OUT STD_LOGIC;
    refclk_out : OUT STD_LOGIC;
    buf_lcl_response_only_out : OUT STD_LOGIC;
    buf_lcl_tx_flow_control_out : OUT STD_LOGIC;
    idle2_selected : OUT STD_LOGIC;
    idle_selected : OUT STD_LOGIC;
    buf_lcl_phy_buf_stat_out : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
    phy_clk_out : OUT STD_LOGIC;
    gt0_qpll_clk_out : OUT STD_LOGIC;
    gt0_qpll_out_refclk_out : OUT STD_LOGIC;
    phy_rst_out : OUT STD_LOGIC;
    sim_train_en : IN STD_LOGIC;
    phy_mce : IN STD_LOGIC;
    phy_link_reset : IN STD_LOGIC;
    force_reinit : IN STD_LOGIC;
    phy_lcl_phy_next_fm_out : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
    phy_lcl_phy_last_ack_out : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
    link_initialized : OUT STD_LOGIC;
    phy_lcl_phy_rewind_out : OUT STD_LOGIC;
    phy_lcl_phy_rcvd_buf_stat_out : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
    phy_rcvd_mce : OUT STD_LOGIC;
    phy_rcvd_link_reset : OUT STD_LOGIC;
    port_error : OUT STD_LOGIC;
    port_initialized : OUT STD_LOGIC;
    clk_lock_out : OUT STD_LOGIC;
    mode_1x : OUT STD_LOGIC;
    port_timeout : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
    srio_host : OUT STD_LOGIC;
    phy_lcl_master_enable_out : OUT STD_LOGIC;
    phy_lcl_maint_only_out : OUT STD_LOGIC;
    gtrx_disperr_or : OUT STD_LOGIC;
    gtrx_notintable_or : OUT STD_LOGIC;
    phy_debug : OUT STD_LOGIC_VECTOR(223 DOWNTO 0);
    srio_txn0 : OUT STD_LOGIC;
    srio_txp0 : OUT STD_LOGIC;
    srio_rxn0 : IN STD_LOGIC;
    srio_rxp0 : IN STD_LOGIC;
    srio_txn1 : OUT STD_LOGIC;
    srio_txp1 : OUT STD_LOGIC;
    srio_rxn1 : IN STD_LOGIC;
    srio_rxp1 : IN STD_LOGIC
  );
END COMPONENT;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : srio_gen2_0
  PORT MAP (
    sys_clkp => sys_clkp,
    sys_clkn => sys_clkn,
    sys_rst => sys_rst,
    log_clk_out => log_clk_out,
    buf_rst_out => buf_rst_out,
    log_rst_out => log_rst_out,
    gt_pcs_rst_out => gt_pcs_rst_out,
    gt_pcs_clk_out => gt_pcs_clk_out,
    cfg_rst_out => cfg_rst_out,
    deviceid => deviceid,
    port_decode_error => port_decode_error,
    s_axis_iotx_tvalid => s_axis_iotx_tvalid,
    s_axis_iotx_tready => s_axis_iotx_tready,
    s_axis_iotx_tlast => s_axis_iotx_tlast,
    s_axis_iotx_tdata => s_axis_iotx_tdata,
    s_axis_iotx_tkeep => s_axis_iotx_tkeep,
    s_axis_iotx_tuser => s_axis_iotx_tuser,
    m_axis_iorx_tvalid => m_axis_iorx_tvalid,
    m_axis_iorx_tready => m_axis_iorx_tready,
    m_axis_iorx_tlast => m_axis_iorx_tlast,
    m_axis_iorx_tdata => m_axis_iorx_tdata,
    m_axis_iorx_tkeep => m_axis_iorx_tkeep,
    m_axis_iorx_tuser => m_axis_iorx_tuser,
    s_axi_maintr_rst => s_axi_maintr_rst,
    s_axi_maintr_awvalid => s_axi_maintr_awvalid,
    s_axi_maintr_awready => s_axi_maintr_awready,
    s_axi_maintr_awaddr => s_axi_maintr_awaddr,
    s_axi_maintr_wvalid => s_axi_maintr_wvalid,
    s_axi_maintr_wready => s_axi_maintr_wready,
    s_axi_maintr_wdata => s_axi_maintr_wdata,
    s_axi_maintr_bvalid => s_axi_maintr_bvalid,
    s_axi_maintr_bready => s_axi_maintr_bready,
    s_axi_maintr_bresp => s_axi_maintr_bresp,
    s_axi_maintr_arvalid => s_axi_maintr_arvalid,
    s_axi_maintr_arready => s_axi_maintr_arready,
    s_axi_maintr_araddr => s_axi_maintr_araddr,
    s_axi_maintr_rvalid => s_axi_maintr_rvalid,
    s_axi_maintr_rready => s_axi_maintr_rready,
    s_axi_maintr_rdata => s_axi_maintr_rdata,
    s_axi_maintr_rresp => s_axi_maintr_rresp,
    gt_clk_out => gt_clk_out,
    drpclk_out => drpclk_out,
    refclk_out => refclk_out,
    buf_lcl_response_only_out => buf_lcl_response_only_out,
    buf_lcl_tx_flow_control_out => buf_lcl_tx_flow_control_out,
    idle2_selected => idle2_selected,
    idle_selected => idle_selected,
    buf_lcl_phy_buf_stat_out => buf_lcl_phy_buf_stat_out,
    phy_clk_out => phy_clk_out,
    gt0_qpll_clk_out => gt0_qpll_clk_out,
    gt0_qpll_out_refclk_out => gt0_qpll_out_refclk_out,
    phy_rst_out => phy_rst_out,
    sim_train_en => sim_train_en,
    phy_mce => phy_mce,
    phy_link_reset => phy_link_reset,
    force_reinit => force_reinit,
    phy_lcl_phy_next_fm_out => phy_lcl_phy_next_fm_out,
    phy_lcl_phy_last_ack_out => phy_lcl_phy_last_ack_out,
    link_initialized => link_initialized,
    phy_lcl_phy_rewind_out => phy_lcl_phy_rewind_out,
    phy_lcl_phy_rcvd_buf_stat_out => phy_lcl_phy_rcvd_buf_stat_out,
    phy_rcvd_mce => phy_rcvd_mce,
    phy_rcvd_link_reset => phy_rcvd_link_reset,
    port_error => port_error,
    port_initialized => port_initialized,
    clk_lock_out => clk_lock_out,
    mode_1x => mode_1x,
    port_timeout => port_timeout,
    srio_host => srio_host,
    phy_lcl_master_enable_out => phy_lcl_master_enable_out,
    phy_lcl_maint_only_out => phy_lcl_maint_only_out,
    gtrx_disperr_or => gtrx_disperr_or,
    gtrx_notintable_or => gtrx_notintable_or,
    phy_debug => phy_debug,
    srio_txn0 => srio_txn0,
    srio_txp0 => srio_txp0,
    srio_rxn0 => srio_rxn0,
    srio_rxp0 => srio_rxp0,
    srio_txn1 => srio_txn1,
    srio_txp1 => srio_txp1,
    srio_rxn1 => srio_rxn1,
    srio_rxp1 => srio_rxp1
  );
-- INST_TAG_END ------ End INSTANTIATION Template ---------

-- You must compile the wrapper file srio_gen2_0.vhd when simulating
-- the core, srio_gen2_0. When compiling the wrapper file, be sure to
-- reference the VHDL simulation library.

