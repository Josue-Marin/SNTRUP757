`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.09.2023 08:26:22
// Design Name: 
// Module Name: Hashgen
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


module Hashgen(
    input clk,
    input start,
    output prueba_fin,
    output [10:0]mem_address_oc,
    input  [12:0]mem_outputc,
    input [10:0]degc,
    output [255:0]digest_256
    );
    
    assign digest_256= digest_reg[255:0];
    wire [511:0]digest_reg;
    wire digest_valid_reg;
    wire [9840:0]hash_data1;
    wire Q1;
    wire [4:0]sw, counter;
    wire [1023:0] blocktt=sw[3]? hash_data1[9215:8192]:sw[0] ? sw[1] ? sw[2] ? hash_data1[8191:7168]:hash_data1[7167:6144]:sw[2] ? hash_data1[6143:5120]:hash_data1[5119:4096]:sw[1] ? sw[2] ? hash_data1[4095:3072]:hash_data1[3071:2048]:sw[2] ? hash_data1[2047:1024]:hash_data1[1023:0]; 
    wire next;
    wire init;
    wire reset=Q1 ? 1'b1:1'b0;
    wire work_factor;
    wire ready;
    wire fetch_done;
    wire startfetch, R8, R9, R10, R11 ;
    
    Hashgen_FSM state_machine(
    .clk(clk),
    .start(start),
    .startfetch(startfetch),
    .Q1(Q1),
    .R8(R8),
    .R9(R9),
    .R10(R10),
    .R11(R11),
    .next(next),
    .init(init),
    .ready(ready),
    .work_factor(work_factor),
    .counter(counter),    
    .prueba_fin(prueba_fin),
    .fetch_done(fetch_done)
    );
    
    Hashgen_DP datapath(
    .clk(clk),
    .counter(counter),
    .sw(sw),
    .R8(R8),
    .R9(R9),
    .R10(R10),
    .R11(R11)
    );
        
    hash_data  hash(
    .clk(clk),
    .start(startfetch),
    .mem_address_o(mem_address_oc),
    .mem_output(mem_outputc),
    .degp(degc),
    .hash_data(hash_data1),
    .busy(fetch_done)
    );
    
    
    sha512_core sha512(
    .clk(clk),
    .reset_n(reset),
    .init(init),
    .next(next),
    .mode(2'd3),
    .work_factor(work_factor),
    .work_factor_num(0),
    .block(blocktt),
    .ready(ready),
    .digest(digest_reg),
    .digest_valid(digest_valid_reg)
    ); 
    
endmodule
