`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2023 10:46:05
// Design Name: 
// Module Name: RandomNG
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


module RandomNG(
     input [31:0]seed,
     output [12:0]rand       
     );

 //xorshift algorithm
     wire [31:0] temp = seed ^ seed >> 7;
     wire [31:0] temp2 = temp ^ temp << 9;
     wire [31:0] temp3 = temp2 ^ temp2 >>13;
     wire [31:0] temp4 = temp3 ^ temp3 >>21;
     wire [12:0] rand_out = temp4;
     
     assign rand=(rand_out!=13'd0 || rand_out!=13'd1 || rand_out!=13'd2) ? (temp2[10]) ? 13'd0:(temp3[0]) ? 13'd1:-13'd1:(rand_out-12'b01);
     
// always @* begin    
//     if (temp4 == 2'd3) begin
//          rand<= 2'b01;
//     end
//     else begin 
//         rand <= (temp4-2'b01);
//     end
//end    
endmodule
