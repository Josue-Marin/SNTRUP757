`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.09.2023 08:26:22
// Design Name: 
// Module Name: Hashgen_DP
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


module Hashgen_DP(
    input clk,
    output reg [4:0]sw,counter,
    input  R8, R9, R10, R11 
    );
    
    wire [4:0] nextsw;
    wire [4:0] nextcounter;  
    
    // Registro A
    always @(posedge clk)
        sw <= nextsw;
    assign nextsw = R8 ? R9 ? (sw): (sw) : R9 ? (sw+1): (0);
    
    always @(posedge clk)
        counter <= nextcounter;
    assign nextcounter = R10 ? R11 ? (counter): (counter) : R11 ? (counter+1): (0);
endmodule

