`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.09.2023 20:27:09
// Design Name: 
// Module Name: KeyGen_DP
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


module KeyGen_DP(
    input clk,
    input [10:0] deg,
    input [12:0]modulo_out1,
    output reg [12:0]mem_inputR, 
    output reg [10:0]mem_address_iR, 
    output reg [10:0]mem_address_oR,
    output reg [25:0]mem_inputS, 
    output reg [10:0]mem_address_iS,i,
    input R1, R2, R3, R4, R5,  R6, R7
    );
    
    wire [25:0] nextmem_inputS;
    wire [10:0] nextmem_addres_iS;
    wire [12:0] nextmem_inputR;
    wire [10:0] nextmem_addres_iR;
    wire [10:0] nextmem_addres_oR;
    wire [10:0] nexti;
    
    
        // Registro M
    always @(posedge clk)
        mem_inputS <= nextmem_inputS;
    // Parte combinacional de M
    assign nextmem_inputS = R1 ? mem_inputS : deg;
    
    always @(posedge clk)
        mem_address_iS <= nextmem_addres_iS;
    // Parte combinacional de RP
    assign nextmem_addres_iS =R2 ? (mem_address_iS): 26'd2047;
    
        // Registro M
    always @(posedge clk)
        mem_inputR <= nextmem_inputR;
    // Parte combinacional de M
    assign nextmem_inputR = R3 ? mem_inputR : modulo_out1;
    
    // Registro A
    always @(posedge clk)
        i <= nexti;
    assign nexti = R6 ? R7 ? (i): (i) : R7 ? (i+1): (0);
    
    always @(posedge clk)
        mem_address_oR <= nextmem_addres_oR;
    // Parte combinacional de RP
    assign nextmem_addres_oR = R4 ? mem_address_oR: (i);
    
    
    always @(posedge clk)
        mem_address_iR <= nextmem_addres_iR;
    // Parte combinacional de RP
    assign nextmem_addres_iR =R5 ? (mem_address_iR): (i-1);
    
    
endmodule
