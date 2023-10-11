`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2023 15:59:30
// Design Name: 
// Module Name: hash_data
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


module hash_data(
    input clk,
    input [12:0]mem_output,
    output [10:0]mem_address_o,
    input [10:0]degp,
    input start,
    output [9840:0]hash_data,
    output busy
    );
    
//    wire width=12*degp;
    wire R1,R2, R3, R4, R5;
    wire [10:0] i;
    
    hash_data_DP Datapath (
        .clk(clk),
        .i(i),
        .mem_address_o(mem_address_o),
        .mem_output(mem_output),
        .hash_data(hash_data),
        .degp(degp),
        .R1(R1),
        .R2(R2),
        .R3(R3),
        .R4(R4),
        .R5(R5)
        );

    hash_data_FSM Control_Unit (
        .clk(clk),
        .start(start),
        .busy(busy),
        .mem_output(mem_output),
        .degp(degp),
        .i(i),
        .R1(R1),
        .R2(R2),
        .R3(R3),
        .R4(R4),
        .R5(R5)
        );
            
    
endmodule