`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.09.2023 09:44:43
// Design Name: 
// Module Name: Multpolyn_inv_DP
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


module Multpolyn_inv_DP(
    input clk,
    input R1, R2,R3, R4, R5,R6,R7, R8, R9, R10, R11, R12, R13,R14,R15,R16,
    input [25:0]mem_output,
    input [25:0]mem_output_a,
    input [12:0]mem_output_b,
    output reg[25:0]mem_input,
    output reg[10:0]mem_address_i,
    output reg[10:0]mem_address_o,
    output reg [10:0]mem_address_ob,
    output reg [10:0]mem_address_oa,
    output reg[9:0]i,j,
    output reg[10:0]k, deg,
    output reg write_enable 
    );

    wire [25:0] nextmem_input;
    wire [10:0] nextmem_addres_i;
    wire [10:0] nextmem_addres_o;
    wire [10:0] nextmem_addres_ob;
    wire [10:0] nextmem_addres_oa;
    wire [9:0] nexti,nextj;
    wire [10:0] nextk, nextdeg;    
    wire nextwrite_enable;
    
    // Registro M
    always @(posedge clk)
        mem_input <= nextmem_input;
    // Parte combinacional de M
    assign nextmem_input = R12 ? R13 ? (mem_input): (mem_input) : R13 ? (mem_output+(mem_output_a*mem_output_b)): (0);
    
    // Registro A
    always @(posedge clk)
        i <= nexti;
    assign nexti = R1 ? R2 ? (i): (i) : R2 ? (i+1): (0);
    
    always @(posedge clk)
        deg <= nextdeg;
    assign nextdeg = R15 ? deg:mem_address_o+1;
            
    // Registro RP
    always @(posedge clk)
        mem_address_o <= nextmem_addres_o;
    // Parte combinacional de RP
    assign nextmem_addres_o = R16 ? mem_address_o-1:R5 ? mem_address_o: (i+j);
    
    always @(posedge clk)
        mem_address_oa <= nextmem_addres_oa;
    // Parte combinacional de RP
    assign nextmem_addres_oa = R10 ? mem_address_oa: (i);
    
    always @(posedge clk)
        mem_address_ob <= nextmem_addres_ob;
    // Parte combinacional de RP
    assign nextmem_addres_ob = R11 ? mem_address_ob: (j);
    
    always @(posedge clk)
        mem_address_i <= nextmem_addres_i;
    // Parte combinacional de RP
    assign nextmem_addres_i = R6 ? R7 ? (mem_address_i): (mem_address_i) : R7 ? (i+j): (k);
    
    always @(posedge clk)
        write_enable <= nextwrite_enable;
    // Parte combinacional de RP
    assign nextwrite_enable = R14 ? (1'b1):(1'b0);
    
    // Registro M
    always @(posedge clk)
        j <= nextj;
    // Parte combinacional de M
    assign nextj =R3 ? R4 ? (j): (j) : R4 ? (j+1): (0);
    // Registro M
    always @(posedge clk)
        k <= nextk;
    // Parte combinacional de M
    assign nextk = R8 ? R9 ? (k): (k) : R9 ? (k+1): (0);
    

endmodule
