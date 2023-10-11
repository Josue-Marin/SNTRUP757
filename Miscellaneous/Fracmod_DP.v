`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2023 14:43:12
// Design Name: 
// Module Name: Fracmod_DP
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


module Fracmod_DP(
    input clk,
    input [12:0] qdiv,
    input [12:0] rdiv,
    input [11:0] modu,
    input [12:0] num,
    input [12:0] den,
    input [12:0]modfracm,
    input [12:0] m1, n1,
    output reg [12:0]a,
    output reg [12:0]b,
    output reg [12:0]x,
    output reg [12:0]y,
    output reg [12:0]u,
    output reg [12:0]v,
    output reg [25:0]m,multm, 
    output reg [12:0]modfrac,
    output reg [12:0]n, multn,
    output reg [25:0]resmod,
    output reg [12:0]q,
    output reg [12:0]r,
    input R1, R2,R3, R4, R5, R6,R7, R8,R9, R10,R11, R12,R13, R14, R15, R16,R17, R18,R19, R20, R21,R22, R23, R24   
    );
    
    wire [12:0] nextv,nety;
    wire [12:0] nextu,nextx;
    wire [25:0] nextm, nextmultm;
    wire [12:0] nextn, nextmultn, nextmodfrac;
    wire [12:0] nextq, nextr;
    wire [12:0] nexta, nextb;
    wire [25:0] nextresmod;
    
    // Registro M
    always @(posedge clk)
        v <= nextv;
    // Parte combinacional de M
    assign nextv = R7 ? (R8? (v):(v)) : (R8? (n)  : (0));
    
    always @(posedge clk)
        multn <= nextmultn;
    // Parte combinacional de M
    assign nextmultn = R22 ? 0:R17 ? multn:(v*qdiv);
    
    always @(posedge clk)
        multm <= nextmultm;
    // Parte combinacional de M
    assign nextmultm = R22 ? 0: R19 ? (multm)  : (u*qdiv);
    
    always @(posedge clk)
        modfrac <= nextmodfrac;
    // Parte combinacional de M
    assign nextmodfrac = R24 ? R23 ? modfrac:13'd1:R23 ?  0:modfracm;
    
    always @(posedge clk)
        x <= nextx;
    // Parte combinacional de M
    assign nextx = R1 ? (R2 ? (x):(x)):(R2? (u):(0));
    
    always @(posedge clk)
        y <= nexty;
    // Parte combinacional de M
    assign nexty = R3 ? R4? (y) : (y) : R4? (v)  : (1);
    
    always @(posedge clk)
        n <= nextn;
    // Parte combinacional de M
    assign nextn = R16 ? R21? (0): (n) : R21? (n1)  : (y-(multn));
    
    always @(posedge clk)
        u <= nextu;
    // Parte combinacional de M
    assign nextu = R5 ? R6? (u): (u) : R6? (m)  : (1);
    
    always @(posedge clk)
        m <= nextm;
    // Parte combinacional de M
    assign nextm = R15 ? R20? (0): (m) : R20? ({13'd0,m1}) : (x-(multm));
    // Registro A
    
    always @(posedge clk)
        q <= nextq;
    // Parte combinacional de M
    assign nextq = R13 ?(q): (qdiv);
    
    always @(posedge clk)
        r <= nextr;
    // Parte combinacional de M
    assign nextr = R14 ?(r): (rdiv) ;
    
    always @(posedge clk)
        a <= nexta;
    // Parte combinacional de M
    assign nexta = R9 ? (R10 ? a: a) : (R10 ? rdiv: den);
    
    always @(posedge clk)
        b <= nextb;
    // Parte combinacional de M
    assign nextb = R11 ? R12 ? b: b  : R12 ? a: modu;
    
    // Registro RP
    always @(posedge clk)
        resmod <= nextresmod;
    // Parte combinacional de RP
    assign nextresmod = R18 ? resmod: num*x;

endmodule