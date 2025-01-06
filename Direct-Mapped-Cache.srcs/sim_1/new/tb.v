`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2025 05:36:58 PM
// Design Name: 
// Module Name: tb
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


module tb();
    reg clk, reset, read_enable, write_enable;
    reg[7:0] address;
    reg[31:0] write_data;
    wire[31:0] read_data;
    wire hit;
    
    top top_inst (
        .clk(clk),
        .reset(reset),
        .address(address),
        .write_data(write_data),
        .read_enable(read_enable),
        .write_enable(write_enable),
        .read_data(read_data),
        .hit(hit)
    );
    
    initial
    begin
        #0 clk=1'b0;
        forever #5 clk=~clk;
    end
    initial
    begin
        reset = 1'b1;
        #50 reset = 1'b0;
        
        #10 write_enable = 1'b1; read_enable = 1'b0; address = 8'h10; write_data = 32'hAAAAAAAA; 
        #50 write_enable = 1'b0; read_enable = 1'b1; // Cache hit
        
        #50 address = 8'h20; // Cache miss
        
        #50 write_enable = 1'b1; read_enable = 1'b0; write_data = 32'hBBBBBBBB;
        #50 write_enable = 1'b0; read_enable = 1'b1; // Cache hit
        
        #50 address = 8'h30; // Cache miss
        
        #50 address = 8'h10; // Cache miss because they use the same index and data for 0x10 was overwritten by data for 0x20

        #100 $finish;
    end

endmodule
