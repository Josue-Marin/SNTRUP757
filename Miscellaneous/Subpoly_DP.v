`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2023 16:09:25
// Design Name: 
// Module Name: Subpoly_DP
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


module Subpoly_DP(
    input clk,
    input R1, R2,R3, R4, R5,R6,R7, R8, R9, R10, R11, R14, R15, R16, R17,R18, R19,R20,R21,R22,
    input [25:0]mem_outputM1,
    input [25:0]mem_outputM2,
    input [10:0]degN, degD,
    output reg[25:0]mem_inputS,
    output reg[10:0]mem_address_iS,
    output reg[10:0]mem_address_oS,
    output reg[10:0]mem_address_oM1,
    output reg[10:0]mem_address_oM2,
    output reg[10:0]j,
    output reg[10:0]i, deg, degch,
    output reg write_enableS 
    );

    wire [25:0] nextmem_inputS;
    wire [10:0] nextmem_addres_iS;
    wire [10:0] nextmem_addres_oS;
    wire [10:0] nextmem_addres_oM1;
    wire [10:0] nextmem_addres_oM2;
    wire [10:0] nexti,nextj, nextdegch;
    wire [10:0] nextdeg;    
    wire nextwrite_enableS;
    
    // Registro M
    always @(posedge clk)
        mem_inputS <= nextmem_inputS;
    // Parte combinacional de M
    assign nextmem_inputS = R9 ? R10 ? (0-mem_outputM2): (mem_outputM1-mem_outputM2) : R10 ? (mem_outputM1): (mem_inputS);
    
    // Registro A
    always @(posedge clk)
        i <= nexti;
    assign nexti = R20 ? i:R1 ? R2 ? (degN+1): (degD) : R2 ? (degD+1): (i+1);
    
    always @(posedge clk)
        mem_address_oM1 <= nextmem_addres_oM1;
    // Parte combinacional de RP
    assign nextmem_addres_oM1 = R5 ? R16 ? mem_address_oM1: mem_address_oM1:R16 ? i : (j);
    
    always @(posedge clk)
        mem_address_oM2 <= nextmem_addres_oM2;
    // Parte combinacional de RP
    assign nextmem_addres_oM2 = R14 ? mem_address_oM2:R6 ? (i): (j);
    
    always @(posedge clk)
        mem_address_iS <= nextmem_addres_iS;
    // Parte combinacional de RP
    assign nextmem_addres_iS =R7 ? R17 ? (mem_address_iS): (mem_address_iS): R17 ? (i): (j);
    
    always @(posedge clk)
    mem_address_oS <= nextmem_addres_oS;
    // Parte combinacional de RP
    assign nextmem_addres_oS = R18 ? (mem_address_oS): (i);
    
    always @(posedge clk)
        degch <= nextdegch;
    // Parte combinacional de M
    assign nextdegch = R21 ? degch:R19 ? (degN):(degD);
    
    always @(posedge clk)
        write_enableS <= nextwrite_enableS;
    // Parte combinacional de RP
    assign nextwrite_enableS = R8 ? (1'b1):(1'b0);
    
    // Registro M
    always @(posedge clk)
        j <= nextj;
    // Parte combinacional de M
    assign nextj =R3 ? R4 ? (j): (degN) : R4 ? (degD): (j-1);
    // Registro M
    always @(posedge clk)
        deg <= nextdeg;
    // Parte combinacional de M
    assign nextdeg = R22 ? deg : R11 ? (i):(i-1);

endmodule