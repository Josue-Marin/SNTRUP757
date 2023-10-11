`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2023 20:01:52
// Design Name: 
// Module Name: Mvts
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


module Mvts(
  input [10:0]index,
  output reg[12:0]data
  );
  parameter p=101;
  
  always @(index)
        case (index)
            (index >= 0 && index <= p): begin
                data <= 13'b1; 
            end
            default: begin
                data <= 13'b00;  
            end
      endcase
     
endmodule 
