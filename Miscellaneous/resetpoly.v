`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.08.2023 21:31:06
// Design Name: 
// Module Name: resetpoly
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


module resetpoly(
  input clk,
  input start,
  output [25:0]mem_input,
  output [10:0]mem_address_i,
  input [10:0]max,
  output write_enable,
  output write_done
  );
  
  
  wire [10:0]i;
  
  wire R1, R4, R6, R7, R9;
  
  resetpoly_DP datapath(
      .clk(clk),
      .mem_input(mem_input),
      .mem_address_i(mem_address_i),
      .write_enable(write_enable),
      .i(i),
      .R1(R1),
      .R4(R4),
      .R6(R6),
      .R7(R7),
      .R9(R9) 
  );
  
  resetpoly_FSM control_unit(
      .clk(clk),
      .write_enable(write_enable),
      .write_done(write_done),
      .start(start),
      .max(max),
      .i(i),
      .R1(R1),
      .R4(R4),
      .R6(R6),
      .R7(R7),
      .R9(R9) 
  );
  
  
    
    
endmodule
    

