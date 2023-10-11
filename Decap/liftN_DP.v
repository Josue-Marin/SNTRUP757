`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2023 19:49:55
// Design Name: 
// Module Name: liftN_DP
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


module liftN_DP(
    input clk,
    input [12:0]mem_output,
    output reg [10:0]mem_address_o,
    output reg [10:0]mem_address_i,
    output reg [12:0]mem_input,
    output reg [10:0]i,
    input R1, R2,R3, R4, R5, R6, R7
    );
    
    wire [12:0] nextmem_input;
    wire [10:0] nextmem_address_o;
    wire [10:0] nextmem_address_i;
    wire [10:0] nexti;
    
    always @(posedge clk)
        mem_input <= nextmem_input;
    // Parte combinacional de RQ
    assign nextmem_input = R5 ? mem_input:R4 ?  -13'd1: mem_output ;
         
   //Registro M1    
    always @(posedge clk)
        mem_address_i <= nextmem_address_i;
    // Parte combinacional de RQ
    assign nextmem_address_i = R6 ?  mem_address_i: i-1 ;      
         
    //Registro M1    
    always @(posedge clk)
        mem_address_o <= nextmem_address_o;
    // Parte combinacional de RQ
    assign nextmem_address_o = R3 ?  mem_address_o: i ;
    
    always @(posedge clk)
        i <= nexti;
    // Parte combinacional de RQ
    assign nexti = R1 ?  i: R2 ? i+1:0 ;
endmodule