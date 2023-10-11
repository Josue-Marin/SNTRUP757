`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2023 09:40:33
// Design Name: 
// Module Name: small_poly
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


module tsmall_poly(
    input clk,
    input start,
    input [31:0]rand1,
    output [12:0]mem_input,
    output [10:0]mem_address_i,
    output [10:0]mem_address_o,
    input [12:0]mem_output,
    output [10:0]deg,
    output write_enable,
    output write_done,dd
    );
   
  wire [12:0]rand;
  wire [31:0]seed;
  wire [10:0]i,j,k,zc,minco,Ad,c;  
  wire R1,R2, R3, R4, R5,  R8, R9, R10, R11, R12, R13, R14,R15, R16, R17,R18, R19, R20, R21,R22,R23,R24,R25,R26, R27 ;
  
  tspoly_DP datapath(
      .clk(clk),
      .mem_input(mem_input),
      .mem_address_o(mem_address_o),
      .mem_address_i(mem_address_i),
      .write_enable(write_enable),
      .rand(rand),
      .rand1(rand1),
      .seed(seed),
      .i(i),
      .j(j),
      .k(k),
      .c(c),
      .deg(deg),
      .zc(zc),
      .minco(minco),
      .Ad(Ad),
      .R1(R1),
      .R2(R2),
      .R3(R3),
      .R4(R4),
      .R5(R5),
      .R8(R8),
      .R9(R9),
      .R10(R10),
      .R11(R11),
      .R12(R12),
      .R13(R13),
      .R14(R14),
      .R15(R15),
      .R16(R16),
      .R17(R17),
      .R18(R18),
      .R19(R19),
      .R20(R20),
      .R21(R21),
      .R22(R22),
      .R23(R23),
      .R24(R24),
      .R25(R25),
      .R26(R26),
      .R27(R27)
  );
  
  tspoly_FSM control_unit(
      .clk(clk),
      .write_enable(write_enable),
      .mem_output(mem_output),
      .write_done(write_done),
      .start(start),
      .i(i),
      .j(j),
      .k(k),
      .zc(zc),
      .minco(minco),
      .dd(dd),
      .R1(R1),
      .R2(R2),
      .R3(R3),
      .R4(R4),
      .R5(R5),
      .R8(R8),
      .R9(R9),
      .R10(R10),
      .R11(R11),
      .R12(R12),
      .R13(R13),
      .R14(R14),
      .R15(R15),
      .R16(R16),
      .R17(R17),
      .R18(R18),
      .R19(R19),
      .R20(R20),
      .R21(R21),
      .R22(R22),
      .R23(R23),
      .R24(R24),
      .R25(R25),
      .R26(R26),
      .R27(R27)
  );
  
  RandomNgts randut(
       .seed(seed),
       .rand(rand)
  );
  
//  F fpoly(
//      .clk(clk),
//      .output_data(mem_outputf),
//      .input_data(mem_inputf),
//      .read_address(mem_address_of),
//      .write_address(mem_address_if),
//      .write_enable(write_enable)  
//  );
  
//  r rpoly(
//      .clk(clk),
//      .output_data(mem_outputr),
//      .input_data(mem_inputr),
//      .read_address(mem_address_or),
//      .write_address(mem_address_ir),
//      .write_enable(write_enable)  
//  );
  
endmodule