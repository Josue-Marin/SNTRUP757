`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2023 10:14:08
// Design Name: 
// Module Name: g
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


module g(
    input clk,
    input write_enable,
    input read_address, 
    input write_address,
    input input_data,
    output output_data
    );
    
    parameter RAM_WIDTH = 13;
   parameter RAM_ADDR_BITS = 11;

   (* ram_style="distributed" *)
   reg [RAM_WIDTH-1:0] g [(2**RAM_ADDR_BITS)-1:0];

   wire [RAM_WIDTH-1:0] output_data;

   wire [RAM_ADDR_BITS-1:0] read_address, write_address;
   wire [RAM_WIDTH-1:0] input_data;

   always @(posedge clk)
      if (write_enable)
         g[write_address] <= input_data;

   assign output_data = g[read_address];
endmodule
