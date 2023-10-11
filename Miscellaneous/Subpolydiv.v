`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.08.2023 11:22:16
// Design Name: 
// Module Name: Subpolydiv
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


module Subpolydiv(
    input clk,
    input start,
    //output memory
    output [12:0]mem_inputS,
    output [10:0]mem_address_iS,
    //input memories    
    output [10:0]mem_address_oM1,
    output [10:0]mem_address_oM2,
    input [12:0]mem_outputM1,
    input [12:0]mem_outputM2,
    input [10:0] degN, degD,
    output write_enable,
    output sub_done,
    output [10:0] deg
    );

    wire [10:0]j;
    wire [10:0]i;
    wire R1,R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15,f;
  
    Subpolydiv_DP datapath(
      .clk(clk),
      .mem_inputS(mem_inputS),
      .mem_address_iS(mem_address_iS),
      .mem_address_oM1(mem_address_oM1),
      .mem_address_oM2(mem_address_oM2),
      .write_enableS(write_enable),
      .mem_outputM1(mem_outputM1),
      .mem_outputM2(mem_outputM2),
      .degN(degN),
      .degD(degD),
      .i(i),
      .deg(deg),
      .j(j),
      .f(f),
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
      .R15(R15)
    );
  
    subpolydiv_FSM control_unit(
      .clk(clk),
      .sub_done(sub_done),
      .mem_inputS(mem_inputS),
      .start(start),
      .degN(degN),
      .i(i),
      .j(j),
      .f(f),
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
      .R15(R15)     
    );
  


endmodule
