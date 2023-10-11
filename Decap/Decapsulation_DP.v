`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2023 19:30:37
// Design Name: 
// Module Name: Decapsulation_DP
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


module Decapsulation_DP(
    input clk, 
    input [10:0] degm,
    input [12:0]modulo_out1,
    input [12:0]mod3_out,
    output reg [12:0]mem_inpute, 
    output reg [10:0]mem_address_ie, 
    output reg [10:0]mem_address_oe,
    output reg [25:0]mem_inputS, 
    output reg [10:0]mem_address_iS,i,j,
    input R1, R2, R3, R4, R5,  R6, R7, R8, R9, R10, R11, R12
    );
    
    wire [25:0] nextmem_inputS;
    wire [10:0] nextmem_addres_iS;
    wire [12:0] nextmem_inpute;
    wire [10:0] nextmem_addres_ie;
    wire [10:0] nextmem_addres_oe;
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
        mem_inpute <= nextmem_inpute;
    // Parte combinacional de M
    assign nextmem_inpute = R8 ? mod3_out: R3 ? mem_inpute : modulo_out1;
    
    // Registro A
    always @(posedge clk)
        i <= nexti;
    assign nexti = R6 ? R7 ? (i): (i) : R7 ? (i+1): (0);
    
    // Registro A
    always @(posedge clk)
        j <= nextj;
    assign nextj = R9 ? R10 ? (j): (j) : R10 ? (j+1): (0);
    
    
    always @(posedge clk)
        mem_address_oe <= nextmem_addres_oe;
    // Parte combinacional de RP
    assign nextmem_addres_oe = R11? j:R4 ? mem_address_oe: (i);
    
    
    always @(posedge clk)
        mem_address_ie <= nextmem_addres_ie;
    // Parte combinacional de RP
    assign nextmem_addres_ie =R12 ? j-1:R5 ? (mem_address_ie): (i-1);
    
    
endmodule