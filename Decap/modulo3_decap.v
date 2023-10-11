`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2023 21:13:37
// Design Name: 
// Module Name: modulo3_decap
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


module modulo3_decap(
    input clk,
    input [12:0]N,
    input [12:0]q,
    input start,
    output busy,
    output [12:0]p
    );
    
    wire R2, R3;
    wire [12:0] Nmod;
    wire startmod, moddone;
    
    modulo3_decap_DP Datapath (
        .clk(clk),
        .N(N),
        .q(q),
        .Nmod(Nmod),
        .R2(R2),
        .R3(R3)
        );

    modulo3_decap_FSM Control_Unit (
            .clk(clk),
            .start(start),
            .busy(busy),
            .startmod(startmod),
            .moddone(moddone),
            .p(p),
            .N(N),
            .q(q),
            .R2(R2),
            .R3(R3)
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