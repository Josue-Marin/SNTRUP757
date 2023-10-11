`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.09.2023 02:43:59
// Design Name: 
// Module Name: Encapsulation_DP
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


module Encapsulation_DP(
    input clk,
    input [10:0] degm,
    input [12:0]modulo_out1,
    input [12:0]round_out1,
    output reg [12:0]mem_inputc, 
    output reg [10:0]mem_address_ic, 
    output reg [10:0]mem_address_oc,
    output reg [25:0]mem_inputS, 
    output reg [10:0]mem_address_iS,i,j,
    input R1, R2, R3, R4, R5,  R6, R7, R8, R9, R10, R11, R12
    );
    
    wire [25:0] nextmem_inputS;
    wire [10:0] nextmem_addres_iS;
    wire [12:0] nextmem_inputc;
    wire [10:0] nextmem_addres_ic;
    wire [10:0] nextmem_addres_oc;
    wire [10:0] nexti, nextj;
    
    
        // Registro M
    always @(posedge clk)
        mem_inputS <= nextmem_inputS;
    // Parte combinacional de M
    assign nextmem_inputS = R1 ? mem_inputS : degm;
    
    always @(posedge clk)
        mem_address_iS <= nextmem_addres_iS;
    // Parte combinacional de RP
    assign nextmem_addres_iS =R2 ? (mem_address_iS): 26'd2047;
    
        // Registro M
    always @(posedge clk)
        mem_inputc <= nextmem_inputc;
    // Parte combinacional de M
    assign nextmem_inputc = R8 ? round_out1: R3 ? mem_inputc : modulo_out1;
    
    // Registro A
    always @(posedge clk)
        i <= nexti;
    assign nexti = R6 ? R7 ? (i): (i) : R7 ? (i+1): (0);
    
    // Registro A
    always @(posedge clk)
        j <= nextj;
    assign nextj = R9 ? R10 ? (j): (j) : R10 ? (j+1): (0);
    
    
    always @(posedge clk)
        mem_address_oc <= nextmem_addres_oc;
    // Parte combinacional de RP
    assign nextmem_addres_oc = R11? j:R4 ? mem_address_oc: (i);
    
    
    always @(posedge clk)
        mem_address_ic <= nextmem_addres_ic;
    // Parte combinacional de RP
    assign nextmem_addres_ic =R12 ? j-1:R5 ? (mem_address_ic): (i-1);
    
    
endmodule
