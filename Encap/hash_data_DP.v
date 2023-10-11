`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2023 15:59:30
// Design Name: 
// Module Name: hash_data_DP
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


module hash_data_DP(
    input clk,
    input [12:0]mem_output,
    input [10:0]degp,
    output reg [10:0]mem_address_o,
    output reg [10:0]i,
    output reg [9840:0] hash_data,
    input R1, R2,R3, R4, R5
    );
    
//    wire width=12*degp;
    wire [9840:0] nexthash_data;
    wire [10:0] nextmem_address_o;
    wire [10:0] nexti;
    
    always @(posedge clk)
        hash_data <= nexthash_data;
    // Parte combinacional de RQ
    assign nexthash_data = R5 ? hash_data:R4 ?  {hash_data,mem_output}: mem_output;
         
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
