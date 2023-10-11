`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2023 14:43:12
// Design Name: 
// Module Name: Fracmodulo
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


module Fracmodulo(
    input clk,
    input start,
    input [12:0]num,
    input [12:0]den,
    input [11:0]modu,
    output [12:0]modfrac,
    output busy
    );
    
    wire [12:0]x;
    wire [12:0]y;
    wire [12:0]u;
    wire [12:0]v;
    wire [25:0]m,multm;
    wire [12:0] m1;
    wire [12:0]n, n1, multn;
    wire [12:0]q,qdiv;
    wire [12:0]r, rdiv;
    wire [12:0]a;
    wire [12:0]b;
    wire [25:0]resmod;
    wire [12:0]modfracm;
    wire moddone, moddonem, moddonen, busydiv,startm,startd,startmm, startmn;
    wire R1,R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16,R17, R18,R19, R20, R21,R22, R23, R24;
    
    
    Fracmod_DP datapath(
      .clk(clk),
      .x(x),
      .y(y),
      .u(u),
      .v(v),
      .a(a),
      .b(b),
      .q(q),
      .r(r),
      .m(m),
      .modfrac(modfrac),
      .modfracm(modfracm),
      .multm(multm),
      .multn(multn),
      .m1(m1),
      .n1(n1),
      .n(n),
      .qdiv(qdiv),
      .rdiv(rdiv),
      .den(den),
      .num(num),
      .modu(modu),
      .resmod(resmod),
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
      .R11(R11),
      .R12(R12),
      .R13(R13),
      .R14(R14),
      .R15(R15),
      .R16(R16),
      .R17(R17),
      .R18(R18),
      .R19(R19),
      .R20(R20),
      .R21(R21),
      .R22(R22),
      .R23(R23),
      .R24(R24)
      
    );
  
    Fracmod_FSM control_unit(
      .clk(clk),
      .busy(busy),
      .busydiv(busydiv),
      .start(start),
      .startm(startm),
      .startmm(startmm),
      .startmn(startmn),
      .startd(startd),
      .moddone(moddone),
      .moddonem(moddonem),
      .moddonen(moddonen),
      .den(den),
      .modu(modu),
      .num(num),
      .r(r),
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
      .R11(R11),
      .R12(R12),
      .R13(R13),
      .R14(R14),
      .R15(R15),
      .R16(R16),
      .R17(R17),
      .R18(R18),
      .R19(R19),
      .R20(R20),
      .R21(R21),
      .R22(R22),
      .R23(R23),
      .R24(R24)      
    );
    
    Modulo_topdd modulom(
    .clk(clk),
    .N(m),
    .M(modu),
    .start(startmm),
    .busy(moddonem),
    .mod(m1)    
    );
    
    Modulo_top modulon(
    .clk(clk),
    .N(n),
    .M(modu),
    .start(startmn),
    .busy(moddonen),
    .mod(n1)    
    );
    
    Modulo_topdd modulo(
    .clk(clk),
    .N(resmod),
    .M(modu),
    .start(startm),
    .busy(moddone),
    .mod(modfracm)    
    );
    
    division_core division(
    .i_dividend(b),
    .i_divisor(a),
    .i_clk(clk),
    .start(startd),
    .divdone(busydiv),
    .quotient(qdiv), 
    .remainder(rdiv)    
    );
    
    
endmodule
