//
// (c) Copyright 2010 - 2014 Xilinx, Inc. All rights reserved.
//
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
// 	PART OF THIS FILE AT ALL TIMES.                                
`resetall
`timescale 1 ps / 1 ps

module srio_gt_wrapper_srio_gen2_0_k7_1x
  #(
    parameter TCQ         = 100,
    parameter LINK_WIDTH  = 1
  )
  (
    input                   gt0_qpll_clk_out        ,
    input                   gt0_qpll_out_refclk_out ,

    input                       refclk,
    input                       drpclk,
    input                       gt_pcs_rst,
    input                       gt_pcs_clk,
    input                       gt_clk,
    input                       clk_lock,
    input                       srio_rxn0,
    input                       srio_rxp0,
    output                      srio_txn0,
    output                      srio_txp0,
    output [LINK_WIDTH*4*8-1:0] gtrx_data,
    output [LINK_WIDTH*4-1:0]   gtrx_charisk,
    output [LINK_WIDTH*4-1:0]   gtrx_chariscomma,
    output [LINK_WIDTH*4-1:0]   gtrx_disperr,
    output [LINK_WIDTH*4-1:0]   gtrx_notintable,
    input  [LINK_WIDTH-1:0]     gttx_inhibit,
    output [LINK_WIDTH-1:0]     gtrx_chanisaligned,
    output                      gtrx_reset_req,
    output [LINK_WIDTH-1:0]     gtrx_reset_done,
    input                       gtrx_reset,
    input                       gtrx_chanbonden,
    input  [LINK_WIDTH*4*8-1:0] gttx_data,
    input  [LINK_WIDTH*4-1:0]   gttx_charisk,

    input  [LINK_WIDTH-1:0]     gt_txpmareset_in,
    input  [LINK_WIDTH-1:0]     gt_rxpmareset_in,
    input  [LINK_WIDTH-1:0]     gt_txpcsreset_in,
    input  [LINK_WIDTH-1:0]     gt_rxpcsreset_in,
    input  [LINK_WIDTH-1:0]     gt_eyescanreset_in,
    input  [LINK_WIDTH-1:0]     gt_eyescantrigger_in,
    output [LINK_WIDTH-1:0]     gt_eyescandataerror_out,
    input [LINK_WIDTH*3-1:0]    gt_loopback_in,
    input                       gt_rxpolarity_in,
    input                       gt_txpolarity_in,
    input                       gt_rxlpmen_in,
    input  [LINK_WIDTH*5-1:0]   gt_txprecursor_in,
    input  [LINK_WIDTH*5-1:0]   gt_txpostcursor_in,
    input  [3:0]                gt0_txdiffctrl_in,
    input                       gt_txprbsforceerr_in,
    input  [LINK_WIDTH*3-1:0]   gt_txprbssel_in,
    input  [LINK_WIDTH*3-1:0]   gt_rxprbssel_in,
    output                      gt_rxprbserr_out,
    input                       gt_rxprbscntreset_in,
    input                       gt_rxcdrhold_in,
    input                       gt_rxdfelpmreset_in,
    output                      gt_rxcommadet_out,
    output [LINK_WIDTH*8-1:0]   gt_dmonitorout_out,
    output [LINK_WIDTH-1:0]     gt_rxresetdone_out,
    output [LINK_WIDTH-1:0]     gt_txresetdone_out,

    output [LINK_WIDTH*2-1:0]   gt_txbufstatus_out,
    output [LINK_WIDTH*3-1:0]   gt_rxbufstatus_out,

    output [LINK_WIDTH*16-1:0]  gt_drpdo_out ,
    output [LINK_WIDTH-1:0]     gt_drprdy_out,
    input  [LINK_WIDTH*9-1:0]   gt_drpaddr_in,
    input  [LINK_WIDTH*16-1:0]  gt_drpdi_in  ,
    input  [LINK_WIDTH-1:0]     gt_drpen_in  ,
    input  [LINK_WIDTH-1:0]     gt_drpwe_in


  );

    wire                        gnd;
    wire [63:0]                 gnd_vec;
    wire                        vcc;
    wire                        gt_gttxreset_in;
    wire                        gt_gtrxreset_in; //gtxreset;
    wire                        cpll_lock_out;
    //wire                        userrdy;
    wire [LINK_WIDTH-1:0]       gt_rxresetdone_out_i;
    wire [LINK_WIDTH-1:0]       gt_txresetdone_out_i;
    wire [LINK_WIDTH*3-1:0]     gt_rxbufstatus_out_i;
    wire                        gt_txuserrdy_in;
    wire                        gt_rxuserrdy_in;
    wire                        gt_rxbufreset_in;

    reg [9:0]                   reset_counter = 0; // initialized to 0 on GSR only
    reg [3:0]                   reset_pulse = 0;

    assign gnd                = 1'b0;
    assign gnd_vec            = 64'h0000000000000000;
    assign vcc                = 1'b1;

    assign gt_txuserrdy_in    = 1'b1;
    assign gt_rxuserrdy_in    = 1'b1;
    assign gt_gttxreset_in    = reset_pulse[0] || (reset_counter[9] && (gt_pcs_rst || !cpll_lock_out));

    assign gt_rxbufreset_in   = gtrx_reset;
    //assign userrdy            = clk_lock && cpll_lock_out;

    //assign gt_gttxreset_in           = reset_pulse[0] || (reset_counter[9] && (gt_pcs_rst || !cpll_lock_out));
    assign gtrx_reset_done    = gt_rxresetdone_out_i & gt_txresetdone_out_i;
    assign gtrx_reset_req     = gt_rxbufstatus_out_i[2];

assign gt_rxresetdone_out = gt_rxresetdone_out_i;
assign gt_txresetdone_out = gt_txresetdone_out_i;
assign gt_rxbufstatus_out = gt_rxbufstatus_out_i;

// below code synchronizes the gt_pcs_rst to drp_clk which  is used by the RX/TX Reset FSM
reg [3:0] soft_reset_in_sync_srl;
wire      soft_reset_in_sync;
//--------------------------------------------------
always @(posedge drpclk or posedge gt_pcs_rst) begin
  if (gt_pcs_rst) begin
    soft_reset_in_sync_srl <= 4'b1111;
  end else begin
    soft_reset_in_sync_srl <= {soft_reset_in_sync_srl[2:0], 1'b0};
  end
end
//--------------------------------------------------
assign soft_reset_in_sync = soft_reset_in_sync_srl[3];
//--------------------------------------------------

    srio_gen2_0_init #
    (
        .EXAMPLE_SIM_GTRESET_SPEEDUP    ("TRUE"),
        .EXAMPLE_SIMULATION             (0),
        .STABLE_CLOCK_PERIOD            (10),
        .EXAMPLE_USE_CHIPSCOPE          (0)
    )
    inst
    (
     .sysclk_in(drpclk),
     .soft_reset_in(soft_reset_in_sync), // earlier it was connected to gnd
     .dont_reset_on_data_error_in(gnd),
     .gt_tx_fsm_reset_done_out(),
     .gt_rx_fsm_reset_done_out(),

    //_________________________________________________________________________
    //GT0  (X1Y0)

     .gt0_data_valid_in(1'b1),
     .gt0_tx_mmcm_lock_in(clk_lock),
     .gt0_tx_mmcm_reset_out(),
     .gt0_rx_mmcm_lock_in(clk_lock),
     .gt0_rx_mmcm_reset_out(),
    //____________________________CHANNEL PORTS________________________________
    //------------------------------- CPLL Ports -------------------------------
        .gt0_cpllfbclklost_out          (),
        .gt0_cplllock_out               (cpll_lock_out),
        .gt0_cplllockdetclk_in          (drpclk),
        .gt0_cpllreset_in               (gt_pcs_rst),
    //------------------------ Channel - Clocking Ports ------------------------
        .gt0_gtrefclk0_in               (refclk),
    //-------------------------- Channel - DRP Ports  --------------------------
        .gt0_drpaddr_in                 (gt_drpaddr_in),
        .gt0_drpclk_in                  (drpclk),
        .gt0_drpdi_in                   (gt_drpdi_in),
        .gt0_drpdo_out                  (gt_drpdo_out),
        .gt0_drpen_in                   (gt_drpen_in),
        .gt0_drprdy_out                 (gt_drprdy_out),
        .gt0_drpwe_in                   (gt_drpwe_in),
    //------------------------- Digital Monitor Ports --------------------------
        .gt0_dmonitorout_out            (gt_dmonitorout_out[7:0]),
    //----------------------------- Loopback Ports -----------------------------
        .gt0_loopback_in                (gt_loopback_in[2:0]),
    //------------------- RX Initialization and Reset Ports --------------------
        .gt0_eyescanreset_in            (gt_eyescanreset_in[0]),
        .gt0_rxuserrdy_in               (gt_rxuserrdy_in),
    //------------------------ RX Margin Analysis Ports ------------------------
        .gt0_eyescandataerror_out       (gt_eyescandataerror_out[0]),
        .gt0_eyescantrigger_in          (gt_eyescantrigger_in[0]),
    //----------------------- Receive Ports - CDR Ports ------------------------
        .gt0_rxcdrhold_in               (gt_rxcdrhold_in),
    //----------------- Receive Ports - Clock Correction Ports -----------------
        .gt0_rxclkcorcnt_out            (),
    //---------------- Receive Ports - FPGA RX Interface Ports -----------------
        .gt0_rxusrclk_in                (gt_clk),
        .gt0_rxusrclk2_in               (gt_pcs_clk),
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
        .gt0_rxdata_out                 ({gtrx_data[7:0],gtrx_data[15:8],gtrx_data[23:16],gtrx_data[31:24]}),
    //----------------- Receive Ports - Pattern Checker Ports ------------------
        .gt0_rxprbserr_out              (gt_rxprbserr_out),
        .gt0_rxprbssel_in               (gt_rxprbssel_in[2:0]),
    //----------------- Receive Ports - Pattern Checker ports ------------------
        .gt0_rxprbscntreset_in          (gt_rxprbscntreset_in),
    //---------------- Receive Ports - RX 8B/10B Decoder Ports -----------------
        .gt0_rxdisperr_out              ({gtrx_disperr[0],gtrx_disperr[1],gtrx_disperr[2],gtrx_disperr[3]}),
        .gt0_rxnotintable_out           ({gtrx_notintable[0],gtrx_notintable[1],gtrx_notintable[2],gtrx_notintable[3]}),
    //------------------------- Receive Ports - RX AFE -------------------------
        .gt0_gtxrxp_in                  (srio_rxp0),
    //---------------------- Receive Ports - RX AFE Ports ----------------------
        .gt0_gtxrxn_in                  (srio_rxn0),
    //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
        .gt0_rxbufreset_in              (gt_rxbufreset_in),
        .gt0_rxbufstatus_out            (gt_rxbufstatus_out_i[2:0]),
    //------------ Receive Ports - RX Byte and Word Alignment Ports ------------
        .gt0_rxbyteisaligned_out        (),
        .gt0_rxbyterealign_out          (),
        .gt0_rxcommadet_out             (gt_rxcommadet_out),
        .gt0_rxmcommaalignen_in         (vcc),
        .gt0_rxpcommaalignen_in         (vcc),
    //------------------- Receive Ports - RX Equalizer Ports -------------------
        .gt0_rxdfelpmreset_in           (gt_rxdfelpmreset_in),
        .gt0_rxmonitorout_out           (),
        .gt0_rxmonitorsel_in            (gnd_vec[1:0]),
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
        .gt0_gtrxreset_in               (gt_gtrxreset_in),
        .gt0_rxpcsreset_in              (gt_rxpcsreset_in[0]),
        .gt0_rxpmareset_in              (gt_rxpmareset_in[0]),
    //---------------- Receive Ports - RX Margin Analysis ports ----------------
        .gt0_rxlpmen_in                 (gt_rxlpmen_in),
    //--------------- Receive Ports - RX Polarity Control Ports ----------------
        .gt0_rxpolarity_in              (gt_rxpolarity_in),
    //----------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        .gt0_rxchariscomma_out          ({gtrx_chariscomma[0],gtrx_chariscomma[1],gtrx_chariscomma[2],gtrx_chariscomma[3]}),
        .gt0_rxcharisk_out              ({gtrx_charisk[0],gtrx_charisk[1],gtrx_charisk[2],gtrx_charisk[3]}),
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
        .gt0_rxresetdone_out            (gt_rxresetdone_out_i[0]),
    //---------------------- TX Configurable Driver Ports ----------------------
        .gt0_txpostcursor_in            (gt_txpostcursor_in[4:0]),
        .gt0_txprecursor_in             (gt_txprecursor_in[4:0]),
    //------------------- TX Initialization and Reset Ports --------------------
        .gt0_gttxreset_in               (gt_gttxreset_in),
        .gt0_txuserrdy_in               (gt_txuserrdy_in),
    //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
        .gt0_txusrclk_in                (gt_clk),
        .gt0_txusrclk2_in               (gt_pcs_clk),
    //---------------- Transmit Ports - Pattern Generator Ports ----------------
        .gt0_txprbsforceerr_in          (gt_txprbsforceerr_in),
    //-------------------- Transmit Ports - TX Buffer Ports --------------------
        .gt0_txbufstatus_out            (gt_txbufstatus_out),
    //------------- Transmit Ports - TX Configurable Driver Ports --------------
        .gt0_txdiffctrl_in              (gt0_txdiffctrl_in),
        .gt0_txinhibit_in               (gttx_inhibit[0]),
    //---------------- Transmit Ports - TX Data Path interface -----------------
        .gt0_txdata_in                  ({gttx_data[7:0],gttx_data[15:8],gttx_data[23:16],gttx_data[31:24]}),
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .gt0_gtxtxn_out                 (srio_txn0),
        .gt0_gtxtxp_out                 (srio_txp0),
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        .gt0_txoutclk_out               (),
        .gt0_txoutclkfabric_out         (),
        .gt0_txoutclkpcs_out            (),
    //------------------- Transmit Ports - TX Gearbox Ports --------------------
        .gt0_txcharisk_in               ({gttx_charisk[0],gttx_charisk[1],gttx_charisk[2],gttx_charisk[3]}),
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
        .gt0_txpcsreset_in              (gt_txpcsreset_in[0]),
        .gt0_txpmareset_in              (gt_txpmareset_in[0]),
        .gt0_txresetdone_out            (gt_txresetdone_out_i[0]),
    //--------------- Transmit Ports - TX Polarity Control Ports ---------------
        .gt0_txpolarity_in              (gt_txpolarity_in),
    //---------------- Transmit Ports - pattern Generator Ports ----------------
        .gt0_txprbssel_in               (gt_txprbssel_in[2:0]),


    //____________________________COMMON PORTS________________________________
     .gt0_qplloutclk_in(gt0_qpll_clk_out),
     .gt0_qplloutrefclk_in(gt0_qpll_out_refclk_out)
    );

    //***********************************************************************//
    //                                                                       //
    //---------------------  Reset Logic  -----------------------------------//
    //                                                                       //
    //***********************************************************************//

    // Upon configuration, GTXTXRESET and GTXRXRESET must be initiated in
    // Sequential mode. None of the GT resets (CPLLRESET, QPLLRESET,
    // GTXTXRESET and GTXRXRESET) can be asserted until a minimum of 500ns
    // after GSR.

      always @(posedge gt_pcs_clk)
      begin
         if (clk_lock && !reset_counter[9])
            reset_counter   <=   #TCQ reset_counter + 1'b1;
      end

      always @(posedge gt_pcs_clk)
      begin
         if(!reset_counter[9])
            reset_pulse   <=   #TCQ 4'b1110;

         else
            reset_pulse   <=   #TCQ {1'b0, reset_pulse[3:1]};

      end

  endmodule
