`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2023 10:10:36
// Design Name: 
// Module Name: Lift_poly_DP
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


module Lift_poly_DP(
    input clk,
    input [12:0]mem_output,
    output reg [10:0]mem_address_o, zerocount,
    output reg [10:0]i,
    input R1, R2,R3, R4, R5
    );
    
    wire [10:0] nextzerocount;
    wire [10:0] nextmem_address_o;
    wire [10:0] nexti;
    
    always @(posedge clk)
        zerocount <= nextzerocount;
    // Parte combinacional de RQ
    assign nextzerocount = R5 ? zerocount:R4 ?  zerocount+1: 0 ;
         
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
