`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2023 19:31:57
// Design Name: 
// Module Name: Modulo3_DP
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


module Modulo3_DP(
    input clk,
    input signed[12:0]N,
    input [3:0]M,
    output reg [12:0]mod,
    output reg [12:0]V,
    output reg signed [12:0]nega,
    output reg [3:0]C,
    output reg [12:0]M1,
    input R1, R2,R3, R4, R5, R6,R7, R8,R9, R10   
    );
    
    wire [12:0] nextmod;
    wire [12:0] nextM1;
    wire [12:0] nextnega;
    wire [3:0] nextC;
    wire [12:0] nextV;
    
    // Registro M
    always @(posedge clk)
        V <= nextV;
    // Parte combinacional de M
    assign nextV = R3 ? (R1 ? V-M1: V )  : (R1 ? nega:N);
    
    // Registro A
    always @(posedge clk)
        C <= nextC;
    assign nextC = R7 ? C:M;
    
        
    //Registro M1    
    always @(posedge clk)
        M1 <= nextM1;
    // Parte combinacional de RQ
    assign nextM1 = R5 ? (R6 ? (R4 ? {M,9'd0}: {1'b0, M1[12:1]}) : 0):(R6 ? (R4 ? {M,9'd0}: {M1[11:0], 1'b0}) : M1);
    
    always @(posedge clk)
        nega <= nextnega;
    // Parte combinacional de RQ
    assign nextnega = R9 ? R10?(nega+M):(nega+M1):R10?nega:N;
    
    // Registro RP
    always @(posedge clk)
        mod <= nextmod;
    // Parte combinacional de RP
    assign nextmod = R2 ? (R8 ? mod: V) :(R8 ?nega:nega-M);
  

endmodule
