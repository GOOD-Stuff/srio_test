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
    input clk,
    input reset,
    input SourceID,
    input DestID,
    output axis_iotx_tvalid,
    output axis_iotx_tlast,
    output [63:0] axis_iotx_tdata,
    output [7:0] axis_iotx_tkeep,
    output [31:0] axis_iotx_tuser,
    input axis_iotx_tready
    );
endmodule
