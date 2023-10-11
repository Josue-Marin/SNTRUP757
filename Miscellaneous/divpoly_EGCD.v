`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.09.2023 09:08:05
// Design Name: 
// Module Name: divpoly_EGCD
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


module divpoly_EGCD(
    input clk,
    input [11:0]modu,
//    input sw1,sw2,
//    input Q1, 
    input start,
    //output memories
    output [10:0]degQ,
    output [10:0]mem_address_iQ,
    output [10:0]mem_address_iR,
    output [12:0]mem_inputQ,
    output [12:0]mem_inputR,
    output [10:0]degsubN,
    //input memories
    output [10:0]mem_address_oN,
    output [10:0]mem_address_oD,
    input [12:0]mem_outputN,
    input [12:0]mem_outputD,
    //used by sub and div
    output [10:0]mem_address_imodN,
    output [10:0]mem_address_imodD,
    output [10:0]mem_address_omodD,
    output [10:0]mem_address_omodN,
    input [12:0]mem_output_modN,
    input [12:0]mem_output_modD,
    output [12:0]mem_input_modN,
    output [12:0]mem_input_modD,
    output [10:0]mem_address_imodNR,
    output [10:0]mem_address_omodNR,
    input [12:0]mem_output_modNR,
    output [12:0]mem_input_modNR,
    output write_enablemodD,
    output write_enablemodN,
    output write_enablemodNR,
    output write_enableQ,
    output write_enable, 
    output div_done
    );
    
    
    //variable module memories
    assign mem_address_omodD= Q1 ? mem_address_omodDsub:mem_address_omodDg;
    assign mem_address_omodN= y1 ? mem_address_omodN:Q1 ? mem_address_omodNsub:mem_address_omodNg;
    assign mem_address_imodN= y1 ? mem_address_iresetmodN:mem_address_imodNg;
    assign mem_input_modN= y1 ? mem_input_resetmodN:mem_input_modNg;
    assign write_enablemodN= y1 ? write_enableresetmodN:write_enablemodNg;
    assign mem_address_imodNR= y1 ? mem_address_imodNg:mem_address_iresetmodN;
    assign mem_address_omodNR= y1 ? Q1 ? mem_address_omodNsub:mem_address_omodNg:mem_address_omodNR;
    assign mem_input_modNR= y1 ? mem_input_modNg:mem_input_resetmodN;
    assign write_enablemodNR=y1 ? write_enablemodNg:write_enableresetmodN;
    //variable inputN
    assign mem_address_oN= y0 ? mem_address_oN:mem_address_oNg;
    //mem Q
    assign mem_address_iQ= y2 ?  mem_address_iQg:mem_address_iresetq;
    assign mem_inputQ= y2 ?  mem_inputQg:mem_input_resetq;
    assign write_enableQ= y2 ? write_enable:write_enableresetq;
    //variable memories for N
    wire [10:0]mem_address_otempN= y1 ? mem_address_oNg:mem_address_otempNg;
    wire [12:0]mem_output_tempN;
    wire [10:0]mem_address_itempN= y1 ? mem_address_iresetN:mem_address_itempNsub;
    wire [12:0]mem_input_tempN= y1 ? mem_input_resetN:mem_input_tempNsub;
    wire write_enabletempN=y1 ? write_enableresetN:write_enablesub;
    wire [10:0]mem_address_oNgen=y1 ? mem_address_otempNg:mem_address_oNg;
    wire [12:0]mem_output_Ngen;
    wire [10:0]mem_address_iNgen= y1 ? mem_address_itempNsub:mem_address_iresetN;
    wire [12:0]mem_input_Ngen=y1 ? mem_input_tempNsub:mem_input_resetN;
    wire write_enableNgen=y1 ? write_enablesub:write_enableresetN;
    //divgen
      //mod 
      wire [10:0]mem_address_omodDg;
      wire [10:0]mem_address_imodNg;   
      wire [10:0]mem_address_omodNg;
      wire [12:0]mem_input_modNg;
      wire [12:0]mem_output_modNg=y1 ? mem_output_modNR: mem_output_modN;
      //Ninput
      wire [10:0]mem_address_oNg;  
      wire [12:0]mem_outputNg= y0 ? y1 ? mem_output_tempN:mem_output_Ngen:mem_outputN;
      //tempN
      wire [10:0]mem_address_otempNg;  
      wire [12:0]mem_output_tempNg= y1?mem_output_Ngen:mem_output_tempN;
    //sub 
      //mod  
      wire [10:0]mem_address_omodDsub;
      wire [10:0]mem_address_omodNsub;
      wire [12:0]mem_output_modNsub=y1 ? mem_output_modNR: mem_output_modN;
      //tempN
      wire [10:0]mem_address_itempNsub;  
      wire [12:0]mem_input_tempNsub;    
    //resetN 
    wire [12:0]mem_input_resetN;
    wire [10:0]mem_address_iresetN;
    wire reset_doneN;
    //resetmodpolyN
    wire [12:0]mem_input_resetmodN;
    wire [10:0]mem_address_iresetmodN;
    wire reset_donemodN;
    //Q gen
    wire [10:0]mem_address_iQg;
    wire [12:0]mem_inputQg;
    //
    wire write_enableresetN;
    wire write_enableresetmodN;
    wire write_enableresetq;
    wire write_enablesub;
    wire write_enablemodNg;
    wire Q1, y0, y1, y2, y3;
    wire [10:0]degD;
    wire [10:0]degN;
    wire [12:0]numm1;
    wire [12:0]numm2;
    wire [12:0]multN;
    wire [10:0]mem_address_imult;
    wire [25:0]mem_input_mult;
    wire [10:0]mem_address_omult;
    wire [25:0]mem_output_mult;     
    wire startD, startM, startN, startsub, startresetN, startresetmodN,subdone,moddoneD, moddoneM, moddoneN, startmf, moddonemf, modpolydone;
    wire startresetq;
    wire [12:0]mem_input_reset1;
    wire [10:0]mem_address_iresetq;
    wire reset_doneq;
    wire [10:0]i,j,c;
    wire [10:0]k;
    wire [23:0]modN;
    wire [12:0]modD, modM;
    wire [23:0]modDg=y3 ? modM:modD;
    wire [12:0]modfrac;
    wire R1,R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13,R14, R15,R16, R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27,R28, R29,R30, R31, R32, R33, R34, R35, R36, R37, R38, R39, R40;
  
    divpoly_EGCD_DP datapath(
      .clk(clk),
      .mem_address_iQ(mem_address_iQg),
      .mem_address_iR(mem_address_iR),
      .mem_inputQ(mem_inputQg),
      .mem_inputR(mem_inputR),
      .mem_address_oN(mem_address_oNg),
      .mem_address_oD(mem_address_oD),
      .degD(degD),
      .degN(degN),
      .degQ(degQ),
      .mem_address_imodN(mem_address_imodNg),
      .mem_address_imodD(mem_address_imodD),
      .numm1(numm1),
      .numm2(numm2),
      .mem_address_omodD(mem_address_omodDg),
      .mem_address_omodN(mem_address_omodNg),
      .mem_input_modN(mem_input_modNg),
      .mem_input_modD(mem_input_modD),
      .multN(multN),
      .mem_address_imult(mem_address_imult),
      .mem_input_mult(mem_input_mult),
      .mem_address_omult(mem_address_omult),
      .mem_address_otempN(mem_address_otempNg),
      .mem_outputN(mem_outputNg),
      .mem_outputD(mem_outputD),
      .mem_output_tempN(mem_output_tempNg),
      .mem_output_mult(mem_output_mult),
      .mem_output_modD(mem_output_modD),
      .degsubN(degsubN),
      .modfrac(modfrac),
      .modD(modDg),
      .modN(modN),
      .c(c),
      .i(i),
      .j(j),
      .k(k),
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
      .R24(R24),
      .R25(R25),
      .R26(R26),
      .R27(R27),
      .R28(R28),
      .R29(R29),
      .R30(R30),
      .R31(R31),
      .R32(R32),
      .R33(R33),
      .R34(R34),
      .R35(R35),
      .R36(R36),
      .R37(R37),
      .R38(R38),
      .R39(R39),
      .R40(R40)
    );
  
    divpoly_EGCD_FSM control_unit(
      .clk(clk),
      .write_enable(write_enable),
      .write_enablemodN(write_enablemodNg),
      .write_enablemodD(write_enablemodD),
      .mem_output_modD(mem_output_modD),
      .div_done(div_done),
      .start(start),
      .startD(startD),
      .startN(startN),
      .startM(startM),
      .startmf(startmf),
      .startsub(startsub),
      .moddoneD(moddoneD),
      .moddoneM(moddoneM),
      .moddoneN(moddoneN),
      .moddonemf(moddonemf),
      .reset_doneN(reset_doneN),
      .reset_donemodN(reset_donemodN),
      .modpolydone(modpolydone),
      .startresetN(startresetN),
      .startresetmodN(startresetmodN),
      .startresetq(startresetq),
      .subdone(subdone),
      .degsubN(degsubN),
      .Q1(Q1),
      .y0(y0),
      .y1(y1),
      .y2(y2),
      .y3(y3),
      .i(i),
      .c(c),
      .degD(degD),
      .degN(degN),
      .k(k),
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
      .R24(R24),
      .R25(R25),
      .R26(R26),
      .R27(R27),
      .R28(R28),
      .R29(R29),
      .R30(R30),
      .R31(R31),
      .R32(R32),
      .R33(R33),
      .R34(R34),
      .R35(R35),
      .R36(R36),
      .R37(R37),
      .R38(R38),
      .R39(R39),
      .R40(R40)
    );
    
    resetpoly resetN(
      .clk(clk),
      .start(startresetN),
      .mem_input(mem_input_resetN),
      .mem_address_i(mem_address_iresetN),
      .write_enable(write_enableresetN), 
      .max(11'd756),
      .write_done(reset_doneN) 
    );
    
    resetpoly resetmodpolyN(
      .clk(clk),
      .start(startresetmodN),
      .mem_input(mem_input_resetmodN),
      .mem_address_i(mem_address_iresetmodN),
      .write_enable(write_enableresetmodN),
      .max(11'd756),
      .write_done(reset_donemodN)   
    );
    
    Reset_polyQ resetq(
      .clk(clk),
      .start(startresetq),
      .mem_input(mem_input_resetq),
      .mem_address_i(mem_address_iresetq),
      .write_enable(write_enableresetq),
      .max(11'd756),
      .write_done(reset_doneq)   
    );
  
 

     division_mult multdiv(
      .clk(clk),
      .input_data(mem_input_mult),
      .output_data(mem_output_mult),
      .read_address(mem_address_omult),
      .write_address(mem_address_imult),
      .write_enable(write_enable)  
    );
    
     TempN divtempN(
    .clk(clk),
    .write_enable(write_enabletempN),
    .read_address(mem_address_otempN), 
    .write_address(mem_address_itempN),
    .input_data(mem_input_tempN),
    .output_data(mem_output_tempN)    
    );
    
    Ngen Ngeneral(
    .clk(clk),
    .write_enable(write_enableNgen),
    .read_address(mem_address_oNgen), 
    .write_address(mem_address_iNgen),
    .input_data(mem_input_Ngen),
    .output_data(mem_output_Ngen)    
    );
   
    Subpolydiv divsubp(
     .clk(clk),
     .degN(degN),
     .degD(degD),
     .start(startsub),
     .sub_done(subdone),
     .deg(degsubN),
     //memory output
     .mem_inputS(mem_input_tempNsub),
     .mem_address_iS(mem_address_itempNsub),
     //Mem input
     .mem_address_oM1(mem_address_omodNsub),
     .mem_address_oM2(mem_address_omodDsub),
     .mem_outputM1(mem_output_modNsub),
     .mem_outputM2(mem_output_modD),
     .write_enable(write_enablesub)    
    );
    
    Modulo_top modulodivN(
    .clk(clk),
    .N(numm1),
    .M(modu),
    .start(startN),
    .busy(moddoneN),
    .mod(modN)    
    );
    
     Modulo_top modulodivD(
    .clk(clk),
    .N(numm2),
    .M(modu),
    .start(startD),
    .busy(moddoneD),
    .mod(modD)    
    );
    
    Modulo_topdd modulomult(
    .clk(clk),
    .N(mem_output_mult),
    .M(modu),
    .start(startM),
    .busy(moddoneM),
    .mod(modM)    
    );
    
    
    Fracmodulo modulomultn(
    .clk(clk),
    .start(startmf),
    .num(mem_output_modNg),
    .den(mem_output_modD),
    .modu(modu),
    .modfrac(modfrac),
    .busy(moddonemf)    
    );

endmodule