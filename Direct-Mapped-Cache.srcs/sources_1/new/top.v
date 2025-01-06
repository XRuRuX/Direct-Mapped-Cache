`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2025 05:34:34 PM
// Design Name: 
// Module Name: top
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

// Top module integrating the cache controller
module top(clk, reset, address, write_data, read_enable, write_enable, read_data, hit);
    input clk, reset, read_enable, write_enable;
    input [7:0] address;
    input [31:0] write_data;
    output[31:0] read_data;
    output hit;
    
    cache_controller controller (
        .clk(clk),
        .reset(reset),
        .address(address),
        .write_data(write_data),
        .read_enable(read_enable),
        .write_enable(write_enable),
        .read_data(read_data),
        .hit(hit)
    );
    
endmodule
