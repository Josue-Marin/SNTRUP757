`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2023 16:26:36
// Design Name: 
// Module Name: TempN
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


module TempN(
    input clk,
    input write_enable,
    input read_address, 
    input write_address,
    input input_data,
    output output_data
    );
    
   parameter RAM_WIDTH = 26;
   parameter RAM_ADDR_BITS = 11;

   (* ram_style="distributed" *)
   reg [RAM_WIDTH-1:0] TempN [(2**RAM_ADDR_BITS)-1:0];

   wire [RAM_WIDTH-1:0] output_data;

   wire [RAM_ADDR_BITS-1:0] read_address, write_address;
   wire [RAM_WIDTH-1:0] input_data;

   always @(posedge clk)
      if (write_enable)
         TempN[write_address] <= input_data;

   assign output_data = TempN[read_address];
endmodule

