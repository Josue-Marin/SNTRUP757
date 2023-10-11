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


module small_poly(
  input clk,
  input start,
  input [12:0]mem_output,
  output [12:0]mem_input,
  output [10:0]mem_address_i,
  output [10:0]mem_address_o,
  output [10:0] deg,
  output write_enable,
  output write_done
  );
  
  
  wire [12:0]rand;
  wire [31:0]seed;
  wire [10:0]i;
  
  wire R1,R2, R3, R4, R5, R6, R7, R8, R9, R10, R11;
  
  spoly_DP datapath(
      .clk(clk),
      .mem_input(mem_input),
      .mem_address_o(mem_address_o),
      .mem_address_i(mem_address_i),
      .write_enable(write_enable),
      .deg(deg),
      .rand(rand),
      .seed(seed),
      .i(i),
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
      .R11(R11)  
  );
  
  spoly_FSM control_unit(
      .clk(clk),
      .write_enable(write_enable),
      .mem_output(mem_output),
      .write_done(write_done),
      .start(start),
      .i(i),
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
      .R11(R11)  
  );
  
  RandomNG randut(
       .seed(seed),
       .rand(rand)
  );
  
//  g gpoly(
//      .clk(clk),
//      .output_data(mem_output),
//      .input_data(mem_input),
//      .read_address(mem_address_o),
//      .write_address(mem_address_i),
//      .write_enable(write_enable)  
//  );
    
    
endmodule
