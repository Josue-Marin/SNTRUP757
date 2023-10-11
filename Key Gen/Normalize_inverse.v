`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2023 09:39:28
// Design Name: 
// Module Name: Normalize_inverse
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


module Normalize_inverse(
    input clk,
    input [12:0]mem_output,
    output [10:0]mem_address_o,
    output [10:0]mem_address_i,
    output [12:0]mem_input,
    output write_enable,
    input [10:0]degp,
    input [12:0]GCD,
    input [12:0]mod,
    input start,
    output busy
    );
    
    wire startmod1, moddone1, startmf, moddonemf;
    wire [12:0]modulo_out1;
    wire [12:0]modfrac, GCDMod;
    wire R1, R2,R3, R4, R5, R6, R7;
    wire [10:0]i;
    
    Normalize_inverse_DP Datapath (
        .clk(clk),
        .i(i),
        .mem_address_o(mem_address_o),
        .mem_address_i(mem_address_i),
        .mem_input(mem_input),
        .mem_output(mem_output),
        .modulo_out1(modulo_out1),
        .modfrac(modfrac),
        .GCDMod(GCDMod),
        .R1(R1),
        .R2(R2),
        .R3(R3),
        .R4(R4),
        .R5(R5),
        .R6(R6),
        .R7(R7)       
        );

    Normalize_inverse_FSM Control_Unit (
            .clk(clk),
            .start(start),
            .busy(busy),
            .mem_output(mem_output),
            .degp(degp),
            .write_enable(write_enable),
            .startmod1(startmod1),
            .startmf(startmf),
            .moddone1(moddone1),
            .moddonemf(moddonemf),
            .i(i),
            .R1(R1),
            .R2(R2),
            .R3(R3),
            .R4(R4),
            .R5(R5),
            .R6(R6),
            .R7(R7)            
            );
    
    Modulo_top modulogcd(
    .clk(clk),
    .N(GCD),
    .M(mod),
    .start(startmod1),
    .busy(moddone1),
    .mod(modulo_out1)
    );
    
    Fracmodulo fracmod(
    .clk(clk),
    .start(startmf),
    .num(mem_output),
    .den(GCDMod),
    .modu(mod),
    .modfrac(modfrac),
    .busy(moddonemf)   
    );
endmodule


