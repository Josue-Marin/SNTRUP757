`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.08.2023 11:22:42
// Design Name: 
// Module Name: Subpolydiv_DP
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


module Subpolydiv_DP(
    input clk,
    input R1, R2,R3, R4, R5,R6,R7, R8, R9, R10, R11, R12, R13, R14, R15,
    input [12:0]mem_outputM1,
    input [12:0]mem_outputM2,
    input [10:0]degN, degD,
    output reg[12:0]mem_inputS,
    output reg[10:0]mem_address_iS,
    output reg[10:0]mem_address_oM1,
    output reg[10:0]mem_address_oM2,
    output reg[10:0]j,
    output reg[10:0]i, deg,
    output reg write_enableS, f 
    );

    wire [12:0] nextmem_inputS;
    wire [10:0] nextmem_addres_iS;
    wire [10:0] nextmem_addres_oM1;
    wire [10:0] nextmem_addres_oM2;
    wire [10:0] nexti,nextj;
    wire [10:0] nextdeg;    
    wire nextwrite_enableS,nextf;
    
    // Registro M
    always @(posedge clk)
        mem_inputS <= nextmem_inputS;
    // Parte combinacional de M
    assign nextmem_inputS = R9 ? R10 ? (mem_inputS): (mem_outputM1-mem_outputM2) : R10 ? (mem_outputM1): (mem_inputS);
    
    // Registro A
    always @(posedge clk)
        i <= nexti;
    assign nexti = R1 ? R2 ? (i): (i) : R2 ? (degN): (i-1);
    
    always @(posedge clk)
        f <= nextf;
    assign nextf = R12 ? R13 ? (f): (f) : R13 ? (1): (0);
    
    always @(posedge clk)
        mem_address_oM1 <= nextmem_addres_oM1;
    // Parte combinacional de RP
    assign nextmem_addres_oM1 = R5 ?  mem_address_oM1 : (i);
    
    always @(posedge clk)
        mem_address_oM2 <= nextmem_addres_oM2;
    // Parte combinacional de RP
    assign nextmem_addres_oM2 = R6 ? mem_address_oM2: (j);
    
    always @(posedge clk)
        mem_address_iS <= nextmem_addres_iS;
    // Parte combinacional de RP
    assign nextmem_addres_iS =R7 ? (mem_address_iS): (i);
    
    always @(posedge clk)
        write_enableS <= nextwrite_enableS;
    // Parte combinacional de RP
    assign nextwrite_enableS = R8 ? (1'b1):(1'b0);
    
    // Registro M
    always @(posedge clk)
        j <= nextj;
    // Parte combinacional de M
    assign nextj =R3 ? R4 ? (j): (j) : R4 ? (degD): (j-1);
    // Registro M
    always @(posedge clk)
        deg <= nextdeg;
    // Parte combinacional de M
    assign nextdeg = R15 ? R11 ? (deg):(i+1):11'd2047;

endmodule
