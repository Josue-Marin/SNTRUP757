`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.08.2023 21:31:06
// Design Name: 
// Module Name: resetpoly_DP
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


module resetpoly_DP(
    input clk,
    input R1, R4, R6, R7, R9,
    output reg[25:0]mem_input,
    output reg[10:0]mem_address_i,
    output reg[10:0]i,
    output reg write_enable   
    );
    
  wire [25:0] nextmem_input;
  wire [10:0] nextmem_addres_i;
  wire [10:0] nexti;
  wire nextwrite_enable;
    
    // Registro M
    always @(posedge clk)
        mem_input <= nextmem_input;
    // Parte combinacional de M
    assign nextmem_input = 0;
    
    // Registro A
    always @(posedge clk)
        i <= nexti;
    assign nexti = R7? R1 ? (i):i : R1 ? (i+11'b1):10'b0;
        
    always @(posedge clk)
        mem_address_i <= nextmem_addres_i;
    // Parte combinacional de RP
    assign nextmem_addres_i =R9? R4 ? (mem_address_i):(mem_address_i) : R4 ? (i):(0);
    
    always @(posedge clk)
        write_enable <= nextwrite_enable;
    // Parte combinacional de RP
    assign nextwrite_enable = R6 ? (1'b1):(1'b0);
  

endmodule
