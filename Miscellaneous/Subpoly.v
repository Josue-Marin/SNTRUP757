`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2023 16:09:25
// Design Name: 
// Module Name: Subpoly
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


module Subpoly(
    input clk,
    input start,
    //output memory
    output [25:0]mem_inputS,
    output [10:0]mem_address_iS,
    input [25:0]mem_outputS,
    output [10:0]mem_address_oS,
    //input memories    
    output [10:0]mem_address_oM1,
    output [10:0]mem_address_oM2,
    input [25:0]mem_outputM1,
    input [25:0]mem_outputM2,
    input [10:0] degN, degD,
    output write_enable,
    output sub_done,
    output [10:0] deg
    );

    wire [10:0]j;
    wire [10:0]i, degch;
    wire t,s;
    wire R1,R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R14, R15, R16, R17, R18, R19, R20, R21, R22;
  
    Subpoly_DP datapath(
      .clk(clk),
      .mem_inputS(mem_inputS),
      .mem_address_iS(mem_address_iS),
      .mem_address_oS(mem_address_oS),
      .mem_address_oM1(mem_address_oM1),
      .mem_address_oM2(mem_address_oM2),
      .write_enableS(write_enable),
      .degch(degch),
      .mem_outputM1(mem_outputM1),
      .mem_outputM2(mem_outputM2),
      .degN(degN),
      .degD(degD),
      .i(i),
      .deg(deg),
      .j(j),
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
      .R14(R14),
      .R15(R15),
      .R16(R16),
      .R17(R17),
      .R18(R18),
      .R19(R19), 
      .R20(R20), 
      .R21(R21),
      .R22(R22)
    );
  
    Subpoly_FSM control_unit(
      .clk(clk),
      .sub_done(sub_done),
      .mem_inputS(mem_inputS),
      .mem_outputS(mem_outputS),
      .start(start),
      .degch(degch),
      .degN(degN),
      .degD(degD),
      .i(i),
      .j(j),
      .t(t),
      .s(s),
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
      .R14(R14),
      .R15(R15),
      .R16(R16),
      .R17(R17),
      .R18(R18),
      .R19(R19), 
      .R20(R20), 
      .R21(R21),
      .R22(R22)      
    );

  


endmodule