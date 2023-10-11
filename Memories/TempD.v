`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2023 17:24:27
// Design Name: 
// Module Name: TempD
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


module TempD(
    input clk,
    input write_enable, read_enable,
    input read_address, 
    input write_address,
    input input_data,
    output output_data
    );
    
   parameter RAM_WIDTH = 12;
   parameter RAM_ADDR_BITS = 11;

   (* ram_style="distributed" *)
   reg [RAM_WIDTH-1:0] TempD [(2**RAM_ADDR_BITS)-1:0];

   reg [RAM_WIDTH-1:0] output_data;

   wire [RAM_ADDR_BITS-1:0] read_address, write_address;
   wire [RAM_WIDTH-1:0] input_data;

   always @(posedge clk)
      if (write_enable) 
         TempD[write_address] <= input_data;
   
   always @(posedge clk)
         output_data <= TempD[read_address];

endmodule
