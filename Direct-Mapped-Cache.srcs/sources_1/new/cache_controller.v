`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2025 05:19:22 PM
// Design Name: 
// Module Name: cache_controller
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

`define CACHE_SIZE 8
`define BLOCK_SIZE 32

// Cache controller, handling read/write operations and tag matching for cache hits
module cache_controller(clk, reset, address, write_data, read_enable, write_enable, read_data, hit);
    input clk, reset, read_enable, write_enable;
    input [7:0] address;                            // 8-bit address input (5 bits for tag, 3 bits for index)
    input [`BLOCK_SIZE-1:0] write_data;
    output reg[`BLOCK_SIZE-1:0] read_data;
    output reg hit;
    
    // Extract index and tag from the address
    wire[2:0] index = address[2:0];
    wire[4:0] tag = address[7:3];
    
    wire[`BLOCK_SIZE-1:0] cache_read_data;
    wire valid;
    reg[4:0] tag_store[`CACHE_SIZE-1:0];
    
    cache_memory cache (
        .clk(clk),
        .reset(reset),
        .write_data(write_data),
        .index(index),
        .write_enable(write_enable),
        .read_data(cache_read_data),
        .valid(valid)
    );
    
    always@(posedge clk or posedge reset) begin
        if(reset) begin
            hit <= 0;
        end
        else if (read_enable) begin
            // When read is enabled check for a cache hit 
            if(valid && tag_store[index] == tag) begin
                hit <= 1;
                read_data <= cache_read_data;
            end
            else begin
                hit <= 0;
            end
        end
        else if(write_enable) begin
            tag_store[index] <= tag;
        end
    end
endmodule
