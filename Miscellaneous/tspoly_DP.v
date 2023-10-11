`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.05.2023 13:31:12
// Design Name: 
// Module Name: tspoly_DP
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


module tspoly_DP(
    input clk,
    input R1, R2,R3, R4, R5, R8, R9, R10, R11, R12, R13, R14,R15, R16, R17,R18, R19, R20, R21,R22,R23,R24,R25,R26, R27,
    input [12:0]rand,
    input [31:0]rand1,
    output reg[12:0]mem_input,
    output reg[10:0]mem_address_i,
    output reg[10:0]mem_address_o,
    output reg[31:0]seed,
    output reg[10:0]i,j,k,zc,minco,Ad,deg, c,
    output reg write_enable 
    );
    
    wire [12:0] nextmem_input;
    wire [10:0] nextmem_addres_i;
    wire [10:0] nextmem_addres_o;
    wire [31:0] nextseed;
    wire [10:0] nexti,nextj,nextk,nextzc,nextminco, nextAd, nextdeg, nextc;   
    wire nextwrite_enable;
    
    // Registro M
    always @(posedge clk)
        mem_input <= nextmem_input;
    // Parte combinacional de M
    assign nextmem_input = R17 ? R18 ? (c+2): (rand) : R18 ? (0): (mem_input);
    
    // Registro A
    always @(posedge clk)
        i <= nexti;
    assign nexti = R1 ? R2 ? (i-1): (i+1) : R2 ? (i): (0);
    
        
    //Registro M1    
    always @(posedge clk)
        seed <= nextseed;
    // Parte combinacional de RQ
    assign nextseed = R3 ? (rand+i+{i,9'd510,rand}):rand1;
    
    // Registro RP
    always @(posedge clk)
        mem_address_o <= nextmem_addres_o;
    // Parte combinacional de RP
    assign nextmem_addres_o = R23 ? R15 ? R16 ? mem_address_o: (j) : R16 ? (k): (i):c;
    
    always @(posedge clk)
        mem_address_i <= nextmem_addres_i;
    // Parte combinacional de RP
    assign nextmem_addres_i = R27 ? R19 ? R20 ? (j): (i) : R20 ? (Ad): (mem_address_i): 2047;
    
    always @(posedge clk)
        write_enable <= nextwrite_enable;
    // Parte combinacional de RP
    assign nextwrite_enable = R8 ? (1'b1):(1'b0);
    
    // Registro M
    always @(posedge clk)
        j <= nextj;
    // Parte combinacional de M
    assign nextj =R11 ? R12 ? (j): (j+1) : R12 ? (0): (j);
    // Registro M
    always @(posedge clk)
        k <= nextk;
    // Parte combinacional de M
    assign nextk = R9 ? R10 ? (k): (k+1) : R10 ? (0): (k);
    
    
    // Registro M
    always @(posedge clk)
        minco <= nextminco;
    // Parte combinacional de M
    assign nextminco = R4 ? R5 ? (minco): (minco+1) : R5 ? (0): (minco);
    
    // Registro M
    always @(posedge clk)
        zc <= nextzc;
    // Parte combinacional de M
    assign nextzc =R13 ? R14 ? (zc): (zc+1) : R14 ? (0): (zc);
    
    // Registro M
    always @(posedge clk)
        Ad <= nextAd;
    // Parte combinacional de M
    assign nextAd = R21 ? R22 ? Ad:Ad : R22 ? i : j;
    
    always @(posedge clk)
        c <= nextc;
    assign nextc = R24 ? R25 ? (c): (c) : R25 ? (11'd756): (c-1);
    
    always @(posedge clk)
        deg <= nextdeg;
    assign nextdeg = R26 ? (deg): (c+2);

endmodule
