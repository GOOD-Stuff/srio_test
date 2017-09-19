`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2017 13:16:39
// Design Name: 
// Module Name: srio_response
// Project Name: 
// Target Devices: xc7k325tffg676-1
// Tool Versions: Vivado - 2016.3
// Description: This module responsible of response on DSP SRIO request;
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: 
//                          
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ps/1ps

module srio_response(
    input             log_clk,
    input             log_rst,

    input  [15:0]     dst_id,
    input  [15:0]     src_id,
    input             id_override,
    
    // Regs with request data (from DSP to FPGA)
    input             axis_iorx_tvalid,
    input             axis_iorx_tready,
    input             axis_iorx_tlast,
    input  [63:0]     axis_iorx_tdata,
    input  [7:0]      axis_iorx_tkeep,
    input  [31:0]     axis_iorx_tuser,
    
    // Regs with response data (from FPGA to DSP)
    output            axis_iotx_tvalid,
    output            axis_iotx_tlast,
    output [63:0]     axis_iotx_tdata,
    output [7:0]      axis_iotx_tkeep,
    output [31:0]     axis_iotx_tuser,
    input             axis_iotx_tready
        
    );
    
    wire        fifo_EMPTY;       // fifo is empty, flag
    wire        fifo_FULL;        // fifo is full, flag
    reg         wr_fifo = 1'b0;   // write enable flag
    reg         rd_fifo = 1'b0;   // read enable flag
    wire [63:0] din_fifo;         // buffer of input data (into fifo)
    wire [63:0] dout_fifo;        // buffer of output data (from fifo)
                  
    // incoming packet fields
    wire [7:0]  current_tid;
    wire [3:0]  current_ftype;
    wire [3:0]  current_ttype;
    wire [7:0]  current_size;
    wire [1:0]  current_prio;
    wire [33:0] current_addr;
    // outgoing packet fields
    wire [7:0]  response_tid;
    wire [3:0]  response_ftype;
    wire [3:0]  response_ttype;
    wire [7:0]  response_size;
    wire [1:0]  response_prio;
    reg         first_packet_transfer;
    wire [63:0] header_pkt;
    
    assign din_fifo = { axis_iorx_tdata[63:32], axis_iorx_tdata[31:0]};//( axis_iorx_tdata[63:32] << 32 ) | axis_iorx_tdata[31:0]; // temporary. Will need to be flipped    
    // get data from received packet
    assign current_tid   = axis_iorx_tdata[63:56];
    assign current_ftype = axis_iorx_tdata[55:52]; 
    assign current_ttype = axis_iorx_tdata[51:48];
    assign current_size  = axis_iorx_tdata[43:36];
    assign current_prio  = axis_iorx_tdata[46:45] + 2'b01;
    assign current_addr  = axis_iorx_tdata[33:0];
    
    always @(posedge log_clk) begin
        if (log_rst) begin
            wr_fifo <= 1'b0;     
            rd_fifo <= 1'b0;                                   
        end else if (fifo_FULL) begin
            rd_fifo <= 1'b1;
            wr_fifo <= 1'b0;
        end else if (fifo_EMPTY) begin
            rd_fifo <= 1'b0;
            wr_fifo <= axis_iorx_tvalid;
        end        
    end
    
    // find the header of packet
  /*  always @(posedge log_clk) begin 
        if (log_rst) begin
            axis_iotx_tdata <= 
        end
    end*/
    
    
    ila_0 ila_ip(
            .clk (log_clk),
            .probe0 (din_fifo),
            .probe1 (dout_fifo),
            .probe2 (wr_fifo),
            .probe3 (rd_fifo),
            .probe4 (axis_iorx_tlast),
            .probe5 (current_ftype),
            .probe6 (current_ttype)
    );
           
    fifo_generator_rx_inst fifo_rx_ip(
        .srst          (log_rst),      // input
        .clk           (log_clk),
        .din           (din_fifo),     // input
        .wr_en         (wr_fifo),      // input
        .rd_en         (rd_fifo),      // input
        .dout          (dout_fifo),
        .full          (fifo_FULL),
        .empty         (fifo_EMPTY)        
        //.rd_data_count (rd_data_count),
        //.wr_data_count (wr_data_count),
        //.prog_full     (fifo_ALMOSTFULL),
        //.prog_empty    (fifo_ALMOSTEMPTY)
    );
    
    
endmodule
