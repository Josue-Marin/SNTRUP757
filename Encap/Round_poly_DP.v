`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2023 09:14:37
// Design Name: 
// Module Name: Round_poly_DP
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


module Round_poly_DP(
    input clk,
    input [12:0]N,
    input [12:0]q,
    output reg [12:0]RoN,
    output reg [12:0]num,
    output reg [12:0]Nmod,
    input R1, R2,R3, R4, R5, R6, R7   
    );
    
    wire [12:0] nextNmod;
    wire [12:0] nextRoN;
    wire [12:0] nextnum;
    
    // Registro M
    always @(posedge clk)
        Nmod <= nextNmod;
    // Parte combinacional de M
    assign nextNmod = R2 ?  R3 ? Nmod:N-q :R3 ? num:N ;
    
    // Registro A
    always @(posedge clk)
        RoN <= nextRoN;
    assign nextRoN = R7 ? R4 ? RoN:Nmod-2 :R4 ? R5 ? Nmod-1:N-1 : R5 ? num: N;    
        
    //Registro M1    
    always @(posedge clk)
        num <= nextnum;
    // Parte combinacional de RQ
    assign nextnum = R1 ?  num: R6 ? Nmod+1: N+1 ;

endmodule
