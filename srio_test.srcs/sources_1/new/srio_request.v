`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2017 13:16:39
// Design Name: 
// Module Name: srio_request
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ps/1ps

module srio_request(
    input log_clk,
    input log_rst,
    
    input dst_id,
    input src_id,
    
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
    output reg [63:0] axis_iotx_tdata,
    output [7:0]      axis_iotx_tkeep,
    output [31:0]     axis_iotx_tuser,
    input             axis_iotx_tready,
    
    input fifo_rd_ready
    );
    
    wire        fifo_EMPTY;
    wire        fifo_FULL;
    wire        fifo_ALMOSTFULL;
    wire        fifo_ALMOSTEMPTY;
    wire [9:0]  rd_data_count;
    wire [8:0]  wr_data_count;
    
    reg         wr_fifo = 1'b0;   // write enable flag
    reg         rd_fifo = 1'b0;   // read enable flag
    wire [63:0] din_fifo;         // buffer of input data (into fifo)
    wire [63:0] dout_fifo;        // buffer of output data (from fifo)
    wire        c_data_in;
    wire        ready_data;
    reg         header_fnd;
    reg         start = 1'b0;        
    reg  [31:0] c_word = 32'b0;           // count of words
    wire        srio_treq_ready;
    wire        srio_treqy_wr;
    wire        valid_fifo;
    reg  [29:0] header_pkt;
        
    assign din_fifo = axis_iotx_tdata; 
    
    always @(posedge log_clk) begin
        if (log_rst) begin
            wr_fifo <= 1'b0;     
            rd_fifo <= 1'b0;                                   
        end else if (fifo_EMPTY) begin
            rd_fifo <= 0;
        end else begin
            rd_fifo <= fifo_rd_ready;
        end         
    end
    
   /* always @(posedge log_clk) begin
        if (rd_fifo) begin
            axis_iotx_tdata <= ( dout_fifo[63:32] << 32 ) | dout_fifo[31:0]; 
        end
    end*/
/*    
    ila_0 ila_ip(
        .clk (log_clk),
        .probe0 (din_fifo),
        .probe1 (dout_fifo),
        .probe2 (wr_fifo),
        .probe3 (rd_fifo)
//         .probe4 (fifo_FULL),
//           .probe5 (fifo_EMPTY)
    );*/
    /*
    fifo_generator_rx_inst fifo_tx_ip(
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
    );*/     
endmodule
