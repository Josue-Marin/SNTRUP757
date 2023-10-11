`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2023 10:36:32
// Design Name: 
// Module Name: Mvu
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


module Mvu(
  input [10:0]index,
  output reg[25:0]data
  );
  
  always @(index)
      case (index)                  
            0: begin
                data <= 26'b1;
            end 
            default: begin
                data <= 26'b00;  
            end
      endcase
     
endmodule 