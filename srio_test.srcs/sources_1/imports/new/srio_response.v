//`timescale 1ns / 1ps
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
// TODO: 
//      1 - Add FSM;
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ps/1ps

module srio_response(
    input             log_clk,
    input             log_rst,

    input      [15:0] dst_id,
    input      [15:0] src_id,
    input             id_override,
    
    // Regs with request data (from DSP to FPGA)
    input             axis_iorx_tvalid,
    output            axis_iorx_tready,
    input             axis_iorx_tlast,
    input      [63:0] axis_iorx_tdata,
    input      [7:0]  axis_iorx_tkeep,
    input      [31:0] axis_iorx_tuser,
    
    // Regs with response data (from FPGA to DSP)
    output reg        axis_iotx_tvalid,
    output reg        axis_iotx_tlast,
    output reg [63:0] axis_iotx_tdata,
    output     [7:0]  axis_iotx_tkeep,
    output     [31:0] axis_iotx_tuser,
    input             axis_iotx_tready        
    );
    
    // {{{ local parameters (constants) -----------------
    // ftype
    localparam [3:0] NREAD  = 4'h2;
    localparam [3:0] NWRITE = 4'h5;
    localparam [3:0] SWRITE = 4'h6;
    localparam [3:0] DOORB  = 4'hA;
    localparam [3:0] MESSG  = 4'hB;
    localparam [3:0] RESP   = 4'hD;
    // ttype
    localparam [3:0] TNWR   = 4'h4;
    localparam [3:0] TNWR_R = 4'h5;
    localparam [3:0] TNRD   = 4'h4;    
    localparam [3:0] TNDATA = 4'h0; // no data
    localparam [3:0] MSGRSP = 4'h1; // response to a message transaction
    localparam [3:0] TWDATA = 4'h8; // with data    
    
    localparam RESERVE = 1'b0;
    localparam ERROR  = 1'b1;
    // FSM
    
    // }}} End local parameters -------------
    
    // {{{ wire declarations ----------------
    wire        fifo_EMPTY;       // fifo is empty, flag
    wire        fifo_FULL;        // fifo is full, flag
    wire        wr_fifo;          // write enable flag
    wire        rd_fifo;          // read enable flag
    reg         d_rd_fifo, dd_rd_fifo, ddd_rd_fifo, dddd_rd_fifo; // delay read enable flag
    wire [63:0] din_fifo;         // buffer of input data (into fifo)
    wire [63:0] dout_fifo;        // buffer of output data (from fifo)
    
    wire        treq_advance_condition  = axis_iorx_tready && axis_iorx_tvalid;
    wire        tresp_advance_condition = axis_iotx_tready && axis_iotx_tvalid;
    reg         d_treq_advance_condition;
                  
    // incoming packet fields
    wire [7:0]  request_tid;
    wire [3:0]  request_ftype;
    wire [3:0]  request_ttype;
    wire [7:0]  request_size;
    wire [1:0]  request_prio;
    wire [33:0] request_addr;
    // outgoing packet fields
    wire [7:0]  response_tid;
    wire [3:0]  response_ftype;
    wire [3:0]  response_ttype;
    wire [7:0]  response_size;
    wire [1:0]  response_prio;
    reg  [63:0] response_data;
    
    reg  [7:0]  current_bit_cnt;
    reg  [7:0]  srcTID;  
    reg         first_bit;
    reg         first_packet_transfer;
    reg         need_response;
    wire [63:0] header_pkt;
    reg         head_sent;
    wire        end_request; // end of request packet
    reg  [2:0]  delay;
    // }}} End wire declarations ------------
    
    assign din_fifo = axis_iorx_tdata;//{ axis_iorx_tdata[31:0], axis_iorx_tdata[63:32]}; 
    
    // get data from received packet
    assign request_tid   = axis_iorx_tdata[63:56];
    assign request_ftype = axis_iorx_tdata[55:52]; 
    assign request_ttype = axis_iorx_tdata[51:48];
    assign request_size  = axis_iorx_tdata[43:36];
    assign request_prio  = axis_iorx_tdata[46:45] + 2'b01; 
    assign request_addr  = axis_iorx_tdata[33:0];

    assign axis_iorx_tready = ( !fifo_FULL );
    
    assign axis_iotx_tkeep  = 8'hFF;
    assign axis_iotx_tuser  = { 8'h00, 8'hFF, 8'h00, 8'hCB };
    //assign axis_iotx_tvalid = ;
    //assign axis_iotx_tlast  = tl;
    //assign axis_iotx_tdata = response_data;

    assign response_prio = ( request_prio == 2'h03 ) ? ( 2'h03 ):
                                                       ( request_prio + 2'b01 ); // the priority of the answer should be greater by one
    assign response_size = request_size; 
    
    assign wr_fifo = treq_advance_condition && d_treq_advance_condition && ( !fifo_FULL ); 
    assign rd_fifo = need_response && ( axis_iotx_tready || !axis_iotx_tvalid ) && ( request_ftype == NREAD ) && ( !fifo_EMPTY );
    
    assign end_request = d_treq_advance_condition && first_bit;
    /*
    always @( posedge log_clk or posedge log_rst ) begin
        if( log_rst )
            rd_fifo <= 1'b0;         
        else if( !fifo_EMPTY )
            rd_fifo <= 1'b
    end*/
    
    always @( posedge log_clk or posedge log_rst ) begin
        if( log_rst ) begin
            d_rd_fifo    <= 1'b0;
            dd_rd_fifo   <= 1'b0;
        end else begin
            d_rd_fifo    <= rd_fifo;
            dd_rd_fifo   <= d_rd_fifo;
            ddd_rd_fifo  <= dd_rd_fifo;
            dddd_rd_fifo <= ddd_rd_fifo;
        end
    end
           
    // for writing into fifo only payload data (without header)
    always @( posedge log_clk or posedge log_rst ) begin
        if( log_rst ) begin
            d_treq_advance_condition <= 1'b0;
        end else begin
            d_treq_advance_condition <= treq_advance_condition;
        end
    end
        
    // find the header of packet
    always @( posedge log_clk or posedge log_rst ) begin
        if( log_rst ) begin
            first_bit <= 1'b1;
        end else if( treq_advance_condition && axis_iorx_tlast ) begin
            first_bit <= 1'b1;
        end else if( treq_advance_condition ) begin
            first_bit <= 1'b0;
        end 
    end
    
    // check incoming packet, is it necessary to send an answer?
    always @( posedge log_clk or posedge log_rst ) begin
        if( log_rst ) begin
            need_response <= 1'b0;
        end else if( first_bit && treq_advance_condition ) begin
            need_response <= ( request_ftype == NREAD ) ||
                             ( request_ftype == DOORB ) ||
                             ( request_ftype == MESSG ) ||
                             ( ( request_ftype == NWRITE ) && ( request_ttype == TNWR_R ) );
        end else begin
            need_response <= 1'b0;
        end
    end        
       
    // count the number of bytes transferred
    always @( posedge log_clk or posedge log_rst ) begin
        if( log_rst ) 
            current_bit_cnt <= 6'h0;
        else if( tresp_advance_condition && axis_iotx_tlast ) 
            current_bit_cnt <= 6'h0;
        else if( tresp_advance_condition && first_packet_transfer )//head_sent )  // TODO: !!!
            current_bit_cnt <= current_bit_cnt + 1'b1;                
    end
    
    always @( posedge log_clk or posedge log_rst ) begin
        if( log_rst )
            delay <= 2'h00;
        else if( head_sent )
            delay <= delay + 1'h01;
        else
            delay <= 2'h00;
    end
    
    // find the last bytes of packet    
    always @( posedge log_clk or posedge log_rst ) begin
        if( log_rst ) 
            axis_iotx_tlast <= 1'b0;    
        else if( ( current_bit_cnt == request_size - 1 ) && tresp_advance_condition ) // TODO: !!!
            axis_iotx_tlast <= 1'b1;
        else if( first_packet_transfer )
            axis_iotx_tlast <= 1'b1;
        else if( axis_iotx_tready || ( !axis_iotx_tvalid ) ) 
            axis_iotx_tlast <= 1'b0;        
    end
   
    always @( posedge log_clk or posedge log_rst) begin
        if( log_rst ) 
            axis_iotx_tvalid <= 1'b0;
        else if( end_request && need_response ) 
            axis_iotx_tvalid <= 1'b1;
        else if( tresp_advance_condition && axis_iotx_tlast ) 
            axis_iotx_tvalid <= 1'b0;        
    end
    
    // TODO: !!!
    // set response packet 
    always @( posedge log_clk ) begin
        if( log_rst ) begin
            srcTID                <= 8'h00;
            head_sent             <= 1'b0;
            axis_iotx_tdata       <= 64'h00000;     
            first_packet_transfer <= 1'b0;
            //axis_iotx_tlast <= 1'b0;   
        end else if( end_request && need_response ) begin // end_request
            axis_iotx_tdata       <= { srcTID, RESP, TWDATA, 1'b0, response_prio, 1'b0, 8'h00, RESERVE, 35'h0 };//1'b0, request_addr };
            srcTID                <= srcTID + 1'b1;
            head_sent             <= 1'b1;               
        end else if( /*delay[2]*/d_rd_fifo ) begin//d_rd_fifo ) 
            axis_iotx_tdata       <= dout_fifo;  
            first_packet_transfer <= 1'b1;          
        end else if( axis_iotx_tlast && axis_iotx_tvalid  ) begin
            axis_iotx_tdata       <= 64'h00;
            head_sent             <= 1'b0;        
        end
    end   
/*
    always @( posedge log_clk ) begin
        if( head_sent ) 
            axis_iotx_tdata <= dout_fifo;        
    end
  */          
  
  
    // FSM
  
    
    dbg_ila ila_ip(
        .clk     ( log_clk                  ),    
                
        .probe0  ( din_fifo                 ),
        .probe1  ( dout_fifo                ),
        .probe2  ( wr_fifo                  ),
        .probe3  ( rd_fifo                  ),
        
        .probe4  ( axis_iorx_tlast          ),
        .probe5  ( axis_iorx_tvalid         ),
        .probe6  ( axis_iorx_tready         ),                                
        .probe7  ( axis_iorx_tdata          ),            

        .probe8  ( d_rd_fifo               ),
        
        .probe9  ( axis_iotx_tlast          ),
        .probe10 ( axis_iotx_tvalid         ),
        .probe11 ( axis_iotx_tready         ),        
        .probe12 ( axis_iotx_tdata          ),
     
                                
        .probe13 ( first_bit                ),
        .probe14 ( need_response            ),
        .probe15 ( treq_advance_condition   ),
        .probe16 ( d_treq_advance_condition ),
        .probe17 ( end_request              ),

        .probe18 ( srcTID                   ),
        .probe19 ( current_bit_cnt          ),
        .probe20 ( tresp_advance_condition  ),
        
        .probe21 ( axis_iorx_tuser          ),
        .probe22 ( axis_iotx_tuser          )
    );
           
    fifo_generator_rx_inst fifo_rx_ip(
        .srst    ( log_rst    ),      // input
        .clk     ( log_clk    ),      // input
        .din     ( din_fifo   ),      // input
        .wr_en   ( wr_fifo    ),      // input
        .rd_en   ( rd_fifo    ),      // input
        .dout    ( dout_fifo  ),
        .full    ( fifo_FULL  ),
        .empty   ( fifo_EMPTY )        
        //.rd_data_count (rd_data_count),
        //.wr_data_count (wr_data_count),
        //.prog_full     (fifo_ALMOSTFULL),
        //.prog_empty    (fifo_ALMOSTEMPTY)
    );
    
    
endmodule
