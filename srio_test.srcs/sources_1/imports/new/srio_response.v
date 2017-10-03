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
    output            axis_iotx_tlast,
    output reg [63:0] axis_iotx_tdata,
    output     [7:0]  axis_iotx_tkeep,
    output     [31:0] axis_iotx_tuser,
    input             axis_iotx_tready        
    );
    
    // {{{ local parameters (constants) -----------------
    // ftype
    localparam [3:0] NREAD      = 4'h2;
    localparam [3:0] NWRITE     = 4'h5;
    localparam [3:0] SWRITE     = 4'h6;
    localparam [3:0] DOORB      = 4'hA;
    localparam [3:0] MESSG      = 4'hB;
    localparam [3:0] RESP       = 4'hD;
    // ttype
    localparam [3:0] TNWR       = 4'h4;
    localparam [3:0] TNWR_R     = 4'h5;
    localparam [3:0] TNRD       = 4'h4;    
    localparam [3:0] TNDATA     = 4'h0; // no data
    localparam [3:0] MSGRSP     = 4'h1; // response to a message transaction
    localparam [3:0] TWDATA     = 4'h8; // with data    
    
    localparam RESERVE          = 1'b0;
    localparam ERROR            = 1'b1;
    // FSM    
    localparam [2:0] IDLE_S     = 3'h00;
    localparam [2:0] WAIT_REQ_S = 3'h01; // wait request    
    localparam [2:0] SEND_HD_S  = 3'h02; // send header
    localparam [2:0] SEND_DT_S  = 3'h04; // send data
    // }}} End local parameters -------------
    
    // {{{ wire declarations ----------------
    wire        fifo_EMPTY;       // fifo is empty, flag
    wire        fifo_FULL;        // fifo is full, flag
    wire        wr_fifo;          // write enable flag
    reg         rd_fifo;          // read enable flag
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
    wire [7:0]  response_size;
    wire [1:0]  response_prio;

    reg         response_tlast = 1'b0;
    
    reg  [8:0]  current_bit_cnt;
    reg  [7:0]  srcTID;  
    reg         first_bit;   // first byte (header) in request packet 
    wire        end_request; // end of request packet
    reg         need_response;
    
    reg         only_header_sent;    
    
    reg  [2:0]  delay;
    
    reg  [2:0]  next_state, state;
    // }}} End wire declarations ------------   
    assign din_fifo = axis_iorx_tdata;
    
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
    assign axis_iotx_tlast  = response_tlast;

    assign response_prio = ( request_prio == 2'h03 ) ? ( 2'h03 ):
                                                       ( request_prio + 2'b01 ); // the priority of the answer should be greater by one
    assign response_size = request_size;     
    assign wr_fifo = treq_advance_condition && d_treq_advance_condition && ( !fifo_FULL );         
    assign end_request = d_treq_advance_condition && first_bit;
    
    always @( posedge log_clk or posedge log_rst ) begin
        if( log_rst ) begin
            d_rd_fifo    <= 1'b0;
            dd_rd_fifo   <= 1'b0;
            ddd_rd_fifo  <= 1'b0;
            dddd_rd_fifo <= 1'b0;
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
        end else if( end_request )begin
            need_response <= 1'b0;
        end
    end        
       
    // count the number of bytes transferred
    always @( posedge log_clk or posedge log_rst ) begin
        if( log_rst ) 
            current_bit_cnt <= 6'h0;
        else if( tresp_advance_condition && axis_iotx_tlast ) 
            current_bit_cnt <= 6'h0;
        else if( tresp_advance_condition && ( !axis_iotx_tlast ) )//head_sent )  // TODO: !!!
            current_bit_cnt <= current_bit_cnt + 4'h08;                
    end
    
    // find the last bytes of packet    
    always @( * ) begin//posedge log_clk or posedge log_rst ) begin
        if( log_rst ) 
            response_tlast <= 1'b0;    
        else if( ( ( current_bit_cnt - 1 ) == response_size ) && tresp_advance_condition ) // TODO: !!!
            response_tlast <= 1'b1;
        else if( only_header_sent )
            response_tlast <= 1'b1;
        else if( axis_iotx_tready || ( !axis_iotx_tvalid ) ) 
            response_tlast <= 1'b0;        
    end
   
    always @( posedge log_clk or posedge log_rst) begin
        if( log_rst ) 
            axis_iotx_tvalid <= 1'b0;
        else if( end_request && need_response ) 
            axis_iotx_tvalid <= 1'b1;
        else if( tresp_advance_condition && axis_iotx_tlast ) 
            axis_iotx_tvalid <= 1'b0;        
    end
    
    always @( posedge log_clk or posedge log_rst ) begin
        if( log_rst )
            srcTID <= 8'h00;
        else if( axis_iotx_tlast && axis_iotx_tvalid ) 
            srcTID <= srcTID + 1'h01;
    end
       
    // {{{ FSM logic ------------
    // state register
    always @( posedge log_clk or posedge log_rst ) begin
        if( log_rst ) 
            state <= IDLE_S;
        else 
            state <= next_state;
    end
    
    // next-state logic
    always @( state, need_response, end_request, axis_iotx_tlast, request_ftype ) begin
        next_state = IDLE_S;
        case( state )
            IDLE_S: begin
                next_state = WAIT_REQ_S;
            end
            
            WAIT_REQ_S: begin
                if( need_response && end_request ) 
                    next_state = SEND_HD_S;
                else
                    next_state = WAIT_REQ_S;
            end
            
            SEND_HD_S: begin
                if( request_ftype == NREAD ) 
                    next_state = SEND_DT_S;                    
                else
                    next_state = WAIT_REQ_S;                
            end
            
            SEND_DT_S: begin
                if( !axis_iotx_tlast )
                    next_state = SEND_DT_S;
                else
                    next_state = WAIT_REQ_S;
            end
            
            default: begin
                next_state = IDLE_S;
            end            
        endcase
    end
        
    // output logic
    always @( state ) begin
        case( state )
            IDLE_S: begin                           // 0
              //  axis_iotx_tdata     <= 64'h00;                
            end
            
            WAIT_REQ_S: begin                       // 1
                axis_iotx_tdata      <= 64'h00;                
                only_header_sent     <= 1'b0;
                rd_fifo              <= 1'b0;            
            end
            
            SEND_HD_S: begin                        // 2
                if( request_ftype != NREAD ) begin
                    axis_iotx_tdata  <= { srcTID, RESP, TNDATA, 1'b0, response_prio, 
                                                                1'b0, 8'h00, RESERVE, 35'h0 };
                    only_header_sent <= 1'b1;
                end else begin
                    rd_fifo          <= ( ( !fifo_EMPTY ) && axis_iotx_tready );                      
                    axis_iotx_tdata  <= { request_tid, RESP, TWDATA, 1'b0, response_prio, 
                                                               1'b0, 8'h00, RESERVE, 35'h0 };                                      
                end          
            end
            
            SEND_DT_S: begin                        // 4
                if( axis_iotx_tready )
                    axis_iotx_tdata  <= dout_fifo;                                           
                if( fifo_EMPTY || ( !axis_iotx_tready ) )
                    rd_fifo          <= 1'b0;
                else
                    rd_fifo          <= 1'b1;
            end
            
            default: begin
             //   axis_iotx_tdata     <= 64'h00;               
            end
            
        endcase
    end       
    // }}} End of FSM logic ------------
    
    // {{{ Include other modules ------------
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

        .probe8  ( only_header_sent         ),
        
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
        
        .probe21 ( state                    ),
        .probe22 ( next_state               ),
        .probe23 ( fifo_EMPTY               ),
        .probe24 ( response_size            ),
        .probe25 ( fifo_FULL                )
        
    );
           
    fifo_generator_rx_inst fifo_rx_ip(
        .rst     ( log_rst    ),      // input
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
    // }}} End of Include other modules ------------
    
endmodule
