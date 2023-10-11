`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2023 21:13:37
// Design Name: 
// Module Name: modulo3_decap_DP
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


module modulo3_decap_DP(
    input clk,
    input [12:0]N,
    input [12:0]q,
    output reg [12:0]Nmod,
    input R2,R3  
    );
    
    wire [12:0] nextNmod;
    
    // Registro M
    always @(posedge clk)
        Nmod <= nextNmod;
    // Parte combinacional de M
    assign nextNmod = R2 ?  R3 ? Nmod:N-q:N ;
endmodule