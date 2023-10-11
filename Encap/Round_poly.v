`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2023 10:22:55
// Design Name: 
// Module Name: Modulo
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


module Round_poly(
    input clk,
    input [12:0]N,
    input [12:0]q,
    input start,
    output busy,
    output [12:0]RoN
    );
    
    wire R1,R2, R3, R4, R5, R6, R7;
    wire [12:0] Nmod;
    wire [12:0] num;
    wire [12:0] p;
    wire f,startmod, moddone;
    
    Round_poly_DP Datapath (
        .clk(clk),
        .N(N),
        .q(q),
        .RoN(RoN),
        .Nmod(Nmod),
        .num(num),
        .R1(R1),
        .R2(R2),
        .R3(R3),
        .R4(R4),
        .R5(R5),
        .R6(R6),
        .R7(R7)
        );

    Round_poly_FSM Control_Unit (
            .clk(clk),
            .start(start),
            .busy(busy),
            .startmod(startmod),
            .moddone(moddone),
            .p(p),
            .N(N),
            .q(q),
            .f(f),
            .R1(R1),
            .R2(R2),
            .R3(R3),
            .R4(R4),
            .R5(R5),
            .R6(R6),
            .R7(R7)
            );
            
     Modulo_top3 modulodivD(
    .clk(clk),
    .N(Nmod),
    .M(4'd3),
    .start(startmod),
    .busy(moddone),
    .mod(p)    
    );
    
endmodule
