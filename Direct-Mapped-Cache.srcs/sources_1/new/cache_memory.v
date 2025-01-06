`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2025 04:58:35 PM
// Design Name: 
// Module Name: cache_memory
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

`define CACHE_SIZE 8    // Number of cache blocks in the cache memory
`define BLOCK_SIZE 32   // Size of each cache block

// Simple cache memory with read/write and validation functionality
module cache_memory(clk, reset, write_data, index, write_enable, read_data, valid);
    input clk, reset, write_enable;
    input [2:0] index;                              // Index to select the cache block (3 bits for 8 entries)
    input [`BLOCK_SIZE-1:0] write_data;
    output reg[`BLOCK_SIZE-1:0] read_data;          // Valid bit to indicate if the read data is valid
    output reg valid;
    
    reg[`BLOCK_SIZE-1:0] cache_data [`CACHE_SIZE-1:0];
    reg[`CACHE_SIZE-1:0] valid_bits;
        
    always@(posedge clk or posedge reset) begin
        if(reset) begin
            valid_bits <= 0;                        // On reset, invalidate all cache blocks
        end
        else if(write_enable) begin
            cache_data[index] <= write_data;
            valid_bits[index] <= 1'b1;
        end
    end
    
    always@(posedge clk) begin
        if(valid_bits[index]) begin
            read_data <= cache_data[index];
            valid <= 1'b1;
        end
        else begin
            valid <= 1'b0;
        end
    end
endmodule
