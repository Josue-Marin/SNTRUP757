`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.09.2023 09:44:43
// Design Name: 
// Module Name: Multpolyn_inv
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


module Multpolyn_inv(
    input clk,
    input start,
    output mult_done,
    //Mem output
    output [25:0]mem_input,
    input [25:0]mem_output,
    output [10:0]mem_address_i,
    output [10:0]mem_address_o,
    output [10:0]deg,
    //Mem input
    input [10:0]dega,
    input [10:0]degb,
    output [10:0]mem_address_oa,
    output [10:0]mem_address_ob,
    input [25:0]mem_output_a,
    input [12:0]mem_output_b,
    output write_enable
    );
        
    wire [9:0]i,j;
    wire [10:0]k;    
    wire R1,R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13,R14, R15, R16;
    
    Multpolyn_inv_DP datapath(
      .clk(clk),
      .mem_input(mem_input),
      .mem_address_o(mem_address_o),
      .mem_address_i(mem_address_i),
      .mem_address_ob(mem_address_ob),
      .mem_address_oa(mem_address_oa),
      .write_enable(write_enable),
      .mem_output_a(mem_output_a),
      .mem_output_b(mem_output_b),
      .mem_output(mem_output),
      .deg(deg),
      .i(i),
      .j(j),
      .k(k),
      .R1(R1),
      .R2(R2),
      .R3(R3),
      .R4(R4),
      .R5(R5),
      .R6(R6),
      .R7(R7),
      .R8(R8),
      .R9(R9),
      .R10(R10),
      .R11(R11),
      .R12(R12),
      .R13(R13),
      .R14(R14),
      .R15(R15),
      .R16(R16)
    );
  
    Multpolyn_inv_FSM control_unit(
      .clk(clk),
      .write_enable(write_enable),
      .mult_done(mult_done),
      .mem_output(mem_output),
      .start(start),
      .dega(dega),
      .degb(degb),
      .i(i),
      .j(j),
      .k(k),
      .R1(R1),
      .R2(R2),
      .R3(R3),
      .R4(R4),
      .R5(R5),
      .R6(R6),
      .R7(R7),
      .R8(R8),
      .R9(R9),
      .R10(R10),
      .R11(R11),
      .R12(R12),
      .R13(R13),
      .R14(R14),
      .R15(R15),
      .R16(R16)
      
    );
   
endmodule