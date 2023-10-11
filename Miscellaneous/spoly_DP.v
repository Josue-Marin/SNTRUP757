`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2023 11:20:11
// Design Name: 
// Module Name: spoly_FSM
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


module spoly_DP(
    input clk,
    input R1, R2,R3, R4, R5, R6, R7, R8, R9, R10, R11,
    input [12:0]rand,
    output reg[12:0]mem_input,
    output reg[10:0]mem_address_i,
    output reg[10:0]mem_address_o,
    output reg[31:0]seed,
    output reg[10:0]i,deg,
    output reg write_enable   
    );
    
  wire [12:0] nextmem_input;
  wire [10:0] nextmem_addres_i;
  wire [10:0] nextmem_addres_o;
  wire [31:0] nextseed;
  wire [10:0] nexti, nextdeg;
  wire nextwrite_enable;
    
    // Registro M
    always @(posedge clk)
        mem_input <= nextmem_input;
    // Parte combinacional de M
    assign nextmem_input = R8? R3 ? (mem_address_o)  : (deg) : R3 ? (mem_input)  : (rand);
    
    // Registro A
    always @(posedge clk)
        i <= nexti;
    assign nexti = R7? R1 ? (i):i-1 : R1 ? (i+11'b1):10'b0;
    
    always @(posedge clk)
        deg <= nextdeg;
    assign nextdeg = R11 ? deg:mem_address_o+1;
        
    //Registro M1    
    always @(posedge clk)
        seed <= nextseed;
    // Parte combinacional de RQ
    assign nextseed = R2 ? 32'd3147258369 :(rand+i+{i,6'd854,rand,3'd2});
    
    // Registro RP
    always @(posedge clk)
        mem_address_o <= nextmem_addres_o;
    // Parte combinacional de RP
    assign nextmem_addres_o =R10?  R5 ? i:i :  R5 ? mem_address_o:0;
    
    always @(posedge clk)
        mem_address_i <= nextmem_addres_i;
    // Parte combinacional de RP
    assign nextmem_addres_i =R9? R4 ? (mem_address_i):(11'd2047) : R4 ? (i):(0);
    
    always @(posedge clk)
        write_enable <= nextwrite_enable;
    // Parte combinacional de RP
    assign nextwrite_enable = R6 ? (1'b1):(1'b0);
  

endmodule

