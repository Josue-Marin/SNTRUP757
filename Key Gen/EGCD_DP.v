`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.08.2023 17:32:19
// Design Name: 
// Module Name: EGCD_DP
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


module EGCD_DP(
    input clk,
    input [12:0] modulo_out1, mem_output_invg,
    input R1, R2,R3, R4, R5,R6,R7, R8, R9, R10, R11, R12, R13,R14, R15, R16, R17,R18, R19,R20,
    output reg [10:0]mem_address_iInv,
    output reg [12:0]mem_input_inverse,
    output reg [10:0]mem_address_oinvg,
    output reg [10:0]mem_address_iS,
    output reg [25:0]mem_inputS,
    output reg [10:0]mem_address_oS,
    output reg [10:0]mem_address_oA,
    output reg[10:0]k,i,j,
    output reg [0:1]sw,
    output reg write_enable
    );
    
    wire [12:0] nextmem_input_inverse;
    wire [10:0] nextmem_addres_iInv;
    wire [10:0] nextmem_addres_oinvg; 
    wire [25:0] nextmem_inputS;
    wire [10:0] nextmem_addres_iS;
    wire [10:0] nextmem_addres_oS;
    wire [10:0] nextmem_addres_oA;
    wire [10:0] nexti, nextk, nextj;
    wire [0:1] nextsw; 
    wire nextwrite_enable;
    
    always @(posedge clk)
        mem_input_inverse <= nextmem_input_inverse;
    // Parte combinacional de M
    assign nextmem_input_inverse =  R16 ? mem_input_inverse:mem_output_invg ;
    
    always @(posedge clk)
        mem_address_iInv <= nextmem_addres_iInv;
    // Parte combinacional de RP
    assign nextmem_addres_iInv =  R17 ? mem_address_iInv:j ;
    
    always @(posedge clk)
        mem_address_oinvg <= nextmem_addres_oinvg;
    // Parte combinacional de RP
    assign nextmem_addres_oinvg = R18 ?  mem_address_oinvg:j ;
    
    always @(posedge clk)
        j <= nextj;
    assign nextj = R19 ? R20 ? (j): (j) : R20 ? (j+1): (0);
    
    // Registro M
    always @(posedge clk)
        mem_inputS <= nextmem_inputS;
    // Parte combinacional de M
    assign nextmem_inputS = R14 ? mem_inputS : {13'd0,modulo_out1};
    
    // Registro A
    always @(posedge clk)
        i <= nexti;
    assign nexti = R1 ? R2 ? (i): (i) : R2 ? (i+1): (0);
    
    always @(posedge clk)
        mem_address_oS <= nextmem_addres_oS;
    // Parte combinacional de RP
    assign nextmem_addres_oS = R10 ? mem_address_oS: (i);
    
    always @(posedge clk)
        mem_address_oA <= nextmem_addres_oA;
    // Parte combinacional de RP
    assign nextmem_addres_oA = R13 ? mem_address_oA: (k);
    
    always @(posedge clk)
        mem_address_iS <= nextmem_addres_iS;
    // Parte combinacional de RP
    assign nextmem_addres_iS =R9 ? (mem_address_iS): (i-1);
    
    always @(posedge clk)
        write_enable <= nextwrite_enable;
    // Parte combinacional de RP
    assign nextwrite_enable = R15 ? (1'b1):(1'b0);
    
    // Registro M
    always @(posedge clk)
        k <= nextk;
    // Parte combinacional de M
    assign nextk =R5 ? R6 ? (k): (k) : R6 ? (k+1): 0;
    
    always @(posedge clk)
        sw <= nextsw;
    // Parte combinacional de M
    assign nextsw =R7 ? R8 ? (sw): (sw) : R8 ? (sw+1): 0;


endmodule
