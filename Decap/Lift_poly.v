`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2023 10:10:36
// Design Name: 
// Module Name: Lift_poly
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


module Lift_poly(
    input clk,
    input [12:0]mem_output,
    output [10:0]mem_address_o,
    input [10:0]degp,
    input start,
    output busy, st
    );
    
    wire R1,R2, R3, R4, R5;
    wire [10:0] i, zerocount;
    
    Lift_poly_DP Datapath (
        .clk(clk),
        .i(i),
        .mem_address_o(mem_address_o),
        .mem_output(mem_output),
        .zerocount(zerocount),
        .R1(R1),
        .R2(R2),
        .R3(R3),
        .R4(R4),
        .R5(R5)
        );

    Lift_poly_FSM Control_Unit (
        .clk(clk),
        .start(start),
        .busy(busy),
        .mem_output(mem_output),
        .st(st),
        .degp(degp),
        .zerocount(zerocount),
        .i(i),
        .R1(R1),
        .R2(R2),
        .R3(R3),
        .R4(R4),
        .R5(R5)
        );
            
    
endmodule