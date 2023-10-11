`timescale 1ns / 1ps

module c(
    input clk,
    input write_enable,
    input read_address, 
    input write_address,
    input input_data,
    output output_data
    );
    
   parameter RAM_WIDTH = 12;
   parameter RAM_ADDR_BITS = 10;

   (* ram_style="distributed" *)
   reg [RAM_WIDTH-1:0] c [(2**RAM_ADDR_BITS)-1:0];

   wire [RAM_WIDTH-1:0] output_data;

   wire [RAM_ADDR_BITS-1:0] read_address, write_address;
   wire [RAM_WIDTH-1:0] input_data;

   always @(posedge clk)
      if (write_enable)
         c[write_address] <= input_data;

   assign output_data = c[read_address];
endmodule
