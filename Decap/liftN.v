`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2023 19:49:55
// Design Name: 
// Module Name: liftN
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


module liftN(
    input clk,
    input [12:0]mem_output,
    output [10:0]mem_address_o,
    output [10:0]mem_address_i,
    output [12:0]mem_input,
    output write_enable,
    input [10:0]degp,
    input start,
    output busy
    );
    
    wire R1, R2,R3, R4, R5, R6, R7;
    wire [10:0]i;
    
    liftN_DP Datapath (
        .clk(clk),
        .i(i),
        .mem_address_o(mem_address_o),
        .mem_address_i(mem_address_i),
        .mem_input(mem_input),
        .mem_output(mem_output),
        .R1(R1),
        .R2(R2),
        .R3(R3),
        .R4(R4),
        .R5(R5),
        .R6(R6),
        .R7(R7)       
        );

    liftN_FSM Control_Unit (
            .clk(clk),
            .start(start),
            .busy(busy),
            .mem_output(mem_output),
            .degp(degp),
            .write_enable(write_enable),
            .i(i),
            .R1(R1),
            .R2(R2),
            .R3(R3),
            .R4(R4),
            .R5(R5),
            .R6(R6),
            .R7(R7)            
            );
endmodule
