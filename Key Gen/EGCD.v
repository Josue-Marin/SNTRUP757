`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.08.2023 17:32:19
// Design Name: 
// Module Name: EGCD
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


module EGCD(
    input clk,
    input [11:0]modu,
    input start,
    output [10:0]mem_address_oA,
    input [12:0]mem_outputA,
    //output memories
    output [12:0]GCD,
    output [10:0]dego,
    output [12:0]mem_input_inverse,
    output [10:0]mem_address_iInv,
    //memories for multiplication
    output [25:0]mem_inputm,
    output [10:0]mem_address_im,
    input [25:0]mem_outputm,
    output [10:0]mem_address_om,
    output write_enablem,
    //memories for division
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
    output [10:0]mem_address_iQ, 
    output [12:0]mem_inputQ,
    output [10:0]mem_address_oQ, 
    input [12:0]mem_outputQ,
    output write_enablemodD,
    output write_enablemodN,
    output write_enablemodNR,
    output write_enableq,
    output write_enablediv,
    output write_enable,
    output egcd_done
    );
    
    //GCD
    assign GCD= Q7 ? GCD:sw[0]? sw[1] ?  mem_outputmem4_1:mem_outputmem3_1 : sw[1] ? mem_outputmem2_1: mem_outputmem1_1;
        
    //mem output Inverse
    assign dego=Q7 ? dego:sw[0]? sw[1] ? degomem4_2:degomem1_2 : sw[1] ? degomem3_2:degomem2_2;
    
    //A input
    assign mem_address_oA=Q1 ? Q2 ? mem_address_oA:mem_address_oNd :mem_address_oDd;
    
    //Inverse general
    wire [10:0]mem_address_oinvg;
    wire [12:0]mem_output_invg=sw[0]? sw[1] ? mem_outputmem4_2:mem_outputmem1_2 :sw[1] ? mem_outputmem3_2:mem_outputmem2_2;
    
    //S general
    wire [10:0]mem_address_iSg;
    wire [25:0]mem_inputSg;
    wire [10:0]mem_address_oSg;
    wire [25:0]mem_outputSg=sw[0]? sw[1] ?  mem_outputmem3_2:mem_outputmem2_2 :sw[1] ? mem_outputmem4_2:mem_outputmem1_2;
    
    //A general
    wire [10:0]mem_address_oAg;
    wire [12:0]mem_outputAg=Q1 ? sw[0]? sw[1] ?  Q3 ? mem_outputmem1_1:mem_outputAg:Q3 ? mem_outputmem4_1:mem_outputAg : sw[1] ?  Q3 ? mem_outputmem3_1:mem_outputAg:Q3 ? mem_outputmem2_1:mem_outputAg: mem_outputA;
    
    //division memories
    wire [10:0]degR;
    wire [10:0]degQ;
    wire [10:0]mem_address_iRd;
    wire [12:0]mem_inputRd;
    wire [10:0]mem_address_oNd;
    wire [12:0]mem_outputNd=Q1 ? sw[0]? sw[1] ?  mem_outputmem4_1:mem_outputmem3_1 : sw[1] ? Q2 ? mem_outputmem2_1:mem_outputA: mem_outputmem1_1:dataV;
    wire [10:0]mem_address_oDd;
    wire [12:0]mem_outputDd=Q1 ? sw[0]? sw[1] ?  mem_outputmem1_1:mem_outputmem4_1 : sw[1] ? mem_outputmem3_1:mem_outputmem2_1:mem_outputA;
    
    //sub memories
    wire [10:0]mem_address_iSs;
    wire [25:0]mem_inputSs;
    wire [10:0]mem_address_oSs;
    wire [25:0]mem_outputSs=sw[0]? sw[1] ?  mem_outputmem3_2:mem_outputmem2_2 :sw[1] ? mem_outputmem4_2:mem_outputmem1_2;
    wire write_enables;
    wire [10:0]mem_address_oM1s;
    wire [25:0]mem_outputM1s=Q4?sw[0]? sw[1] ? mem_outputmem4_2:mem_outputmem1_2 :sw[1] ? mem_outputmem3_2:mem_outputmem2_2: Q5 ? dataU:1'd0;
    wire [10:0]degNs=Q4?sw[0]? sw[1] ? degomem4_2:degomem1_2 : sw[1] ? degomem3_2:degomem2_2:degDs;
    wire [10:0]degDs;
    wire [10:0]outdegs;
    
    //mult memories
    assign mem_address_om=Q6 ? mem_address_omsub:mem_address_omult;
    wire [10:0]mem_address_oam;
    wire [25:0]mem_output_am=Q5? sw[0]? sw[1] ? mem_outputmem2_2:mem_outputmem4_2 : sw[1] ? mem_outputmem1_2:mem_outputmem3_2:dataU;
    wire [10:0]dega=Q5?sw[0]? sw[1] ? degomem2_2:degomem4_2 : sw[1] ? degomem1_2:degomem3_2:degQ;
    wire [10:0]degb=degQ;
        
    //reset memories 1
    wire [25:0]mem_input_resetmem_1;
    wire [10:0]mem_address_iresetmem_1;
    wire reset_donemem_1;
    
    //reset memories 2
    wire [25:0]mem_input_resetmem_2;
    wire [10:0]mem_address_iresetmem_2;
    wire reset_donemem_2;

    //changing memories
      //1-1
    wire [10:0]mem_address_imem1_1= sw[0]? sw[1] ?  mem_address_imem1_1:mem_address_iRd : sw[1] ? mem_address_iresetmem_1: mem_address_imem1_1;
    wire [10:0]mem_address_omem1_1= Q8 ? 11'd0:sw[0]? sw[1] ?  Q3 ? mem_address_oAg:mem_address_oDd:mem_address_omem1_1 : sw[1] ? mem_address_omem1_1:mem_address_oNd;
    wire [12:0]mem_outputmem1_1;
    wire [12:0]mem_inputmem1_1= sw[0]? sw[1] ?  mem_inputmem1_1:mem_inputRd : sw[1] ? mem_input_resetmem_1: mem_inputmem1_1 ;
    wire write_enablemem1_1= sw[0]? sw[1] ?  write_enablemem1_1: write_enablediv:sw[1] ? write_enableresetmem_1:write_enablemem1_1;
    
      //2-1
    wire [10:0]mem_address_imem2_1= sw[0]? sw[1] ?  mem_address_iRd:mem_address_iresetmem_1 : sw[1] ? mem_address_imem2_1: mem_address_imem2_1;
    wire [10:0]mem_address_omem2_1= Q8 ? 11'd0:sw[0]? sw[1] ?  mem_address_omem2_1:mem_address_omem2_1 : sw[1] ? mem_address_oNd:Q3 ? mem_address_oAg:mem_address_oDd;
    wire [12:0]mem_outputmem2_1;
    wire [12:0]mem_inputmem2_1= sw[0]? sw[1] ?  mem_inputRd:mem_input_resetmem_1 : sw[1] ? mem_inputmem2_1:mem_inputmem2_1;
    wire write_enablemem2_1= sw[0]? sw[1] ?  write_enablediv:write_enableresetmem_1 :sw[1] ? write_enablemem2_1:write_enablemem2_1;
    
      //3-1    
    wire [10:0]mem_address_imem3_1= sw[0]? sw[1] ?  mem_address_iresetmem_1:mem_address_imem3_1 : sw[1] ? mem_address_imem3_1:mem_address_iRd ;
    wire [10:0]mem_address_omem3_1= Q8 ? 11'd0:sw[0]? sw[1] ?  mem_address_omem3_1:mem_address_oNd : sw[1] ? Q3 ? mem_address_oAg:mem_address_oDd:mem_address_omem3_1;
    wire [12:0]mem_outputmem3_1;
    wire [12:0]mem_inputmem3_1= sw[0]? sw[1] ?  mem_input_resetmem_1:mem_inputmem3_1 : sw[1] ? mem_inputmem3_1: mem_inputRd;
    wire write_enablemem3_1= sw[0]? sw[1] ? write_enableresetmem_1 :write_enablemem3_1 :sw[1] ? write_enablemem1_1:write_enablediv ;
    
      
    //4-1
    
    wire [10:0]mem_address_imem4_1= sw[0]? sw[1] ?  mem_address_imem4_1:mem_address_imem4_1 : sw[1] ? mem_address_iRd:mem_address_iresetmem_1 ;
    wire [10:0]mem_address_omem4_1= Q8 ? 11'd0:sw[0]? sw[1] ?  mem_address_oNd:Q3 ? mem_address_oAg:mem_address_oDd : sw[1] ? mem_address_imem4_1:mem_address_imem4_1;
    wire [12:0]mem_outputmem4_1;
    wire [12:0]mem_inputmem4_1= sw[0]? sw[1] ? mem_inputmem4_1:mem_inputmem4_1 : sw[1] ? mem_inputRd:mem_input_resetmem_1 ;
    wire write_enablemem4_1= sw[0]? sw[1] ? write_enablemem4_1:write_enablemem4_1 :sw[1] ? write_enablediv:write_enableresetmem_1;
     
    //1-2
        wire [10:0]mem_address_imem1_2= sw[0]? sw[1] ?  mem_address_iresetmem_2:mem_address_imem1_2 :sw[1] ? mem_address_imem1_2:Q3 ? mem_address_iSg:mem_address_iSs;
        wire [10:0]mem_address_omem1_2= sw[0]? sw[1] ?  mem_address_omem1_2:Q7 ? mem_address_oinvg:mem_address_oM1s : sw[1] ? mem_address_oam:Q3 ? mem_address_oSg:mem_address_oSs;
        wire [25:0]mem_outputmem1_2;
        wire [25:0]mem_inputmem1_2= sw[0]? sw[1] ? mem_input_resetmem_2:mem_inputmem1_2 : sw[1] ? mem_inputmem1_2:Q3 ? mem_inputSg:mem_inputSs ;
        wire [10:0]degmem1_2=sw[0]? sw[1] ? 10'd0:degmem1_2 : sw[1] ? degmem1_2:outdegs;
        wire [10:0]degomem1_2;
        wire write_enablemem1_2= sw[0]? sw[1] ?  write_enableresetmem_2:write_enablemem1_2 :sw[1] ? write_enablemem1_2:Q3 ? write_enable:write_enables;
          
    //2-2
        wire [10:0]mem_address_imem2_2= sw[0]? sw[1] ?  mem_address_imem2_2:Q3 ? mem_address_iSg:mem_address_iSs :sw[1] ? mem_address_iresetmem_2:mem_address_imem2_2;
        wire [10:0]mem_address_omem2_2= sw[0]? sw[1] ?  mem_address_oam:Q3 ? mem_address_oSg:mem_address_oSs :sw[1] ? mem_address_omem2_2:Q7 ? mem_address_oinvg:mem_address_oM1s;
        wire [25:0]mem_outputmem2_2;
       wire [25:0]mem_inputmem2_2= sw[0]? sw[1] ? mem_inputmem2_2:Q3 ? mem_inputSg:mem_inputSs : sw[1] ? mem_input_resetmem_2:mem_inputmem1_2;
      wire [10:0]degmem2_2=sw[0]? sw[1] ? degmem2_2:outdegs : sw[1] ? 10'd0:degmem2_2;
       wire [10:0]degomem2_2;
       wire write_enablemem2_2= sw[0]? sw[1] ?  write_enablemem2_2:Q3 ? write_enable:write_enables :sw[1] ? write_enableresetmem_2:write_enablemem2_2;
         
    //3-2
       wire [10:0]mem_address_imem3_2= sw[0]? sw[1] ?  Q3 ? mem_address_iSg:mem_address_iSs:mem_address_iresetmem_2 :sw[1] ? mem_address_imem3_2:mem_address_imem3_2;
       wire [10:0]mem_address_omem3_2= sw[0]? sw[1] ?  Q3 ? mem_address_oSg:mem_address_oSs:mem_address_omem3_2 :sw[1] ? Q7 ? mem_address_oinvg:mem_address_oM1s:mem_address_oam;
       wire [25:0]mem_outputmem3_2;
       wire [25:0]mem_inputmem3_2= sw[0]? sw[1] ? Q3 ? mem_inputSg:mem_inputSs:mem_input_resetmem_2 : sw[1] ? mem_inputmem3_2:mem_inputmem3_2;
       wire [10:0]degmem3_2=sw[0]? sw[1] ? outdegs:10'd0 : sw[1] ? degmem3_2:degmem3_2;
       wire [10:0]degomem3_2;
       wire write_enablemem3_2= sw[0]? sw[1] ?  Q3 ? write_enable:write_enables:write_enableresetmem_2 :sw[1] ? write_enablemem3_2:write_enablemem3_2;
        
    //4-2
       wire [10:0]mem_address_imem4_2= sw[0]? sw[1] ? mem_address_imem4_2:mem_address_imem4_2 :sw[1] ?  Q3 ? mem_address_iSg:mem_address_iSs:mem_address_iresetmem_2;
       wire [10:0]mem_address_omem4_2= sw[0]? sw[1] ? Q7 ? mem_address_oinvg:mem_address_oM1s:mem_address_oam : sw[1] ?  Q3 ? mem_address_oSg:mem_address_oSs:mem_address_omem3_2;
       wire [25:0]mem_outputmem4_2;
       wire [25:0]mem_inputmem4_2= sw[0]? sw[1] ? mem_inputmem4_2:mem_inputmem4_2 : sw[1] ? Q3 ? mem_inputSg:mem_inputSs:mem_input_resetmem_2;
       wire [10:0]degmem4_2=sw[0]? sw[1] ? degmem4_2:degmem4_2 : sw[1] ? outdegs:10'd0;
       wire [10:0]degomem4_2;
       wire write_enablemem4_2= sw[0]? sw[1] ?  write_enablemem4_2:write_enablemem4_2 :sw[1] ?Q3 ? write_enable:write_enables :write_enableresetmem_2;
       
    //vector for multiplication by 1
       wire [10:0]indexU=Q4 ? indexU:Q5 ? mem_address_oM1s:mem_address_oam;
       wire [25:0]dataU;
      
    //general
      
       wire [10:0]mem_address_omult;
       wire [10:0]mem_address_omsub;
       wire [10:0]indexV=Q1 ? indexV:mem_address_oNd;
       wire [12:0]dataV;
       wire [10:0]degAg=degR;
       wire [10:0]degSg=sw[0]? sw[1] ? degomem3_2:degomem2_2 : sw[1] ? degomem4_2:degomem1_2;
       wire [12:0]modulo_out1;
       wire Q1, Q2, Q3, Q4, Q5,Q6, Q7, Q8;
       wire [0:1]sw;    
       wire write_enableresetmem_1, write_enableresetmem_2;
       wire startmod1, startdiv, startsub,startmult, sub_done,moddone1, div_done, mult_done, startresetmem_1, startresetmem_2, restdonemem_1, restdonemem_2;
       wire [10:0]i,k, j;
       wire R1,R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13,R14, R15, R16, R17,R18, R19,R20 ; 
     
    EGCD_DP datapath(
         .clk(clk),
         .mem_address_iS(mem_address_iSg),
         .mem_inputS(mem_inputSg),
         .mem_address_oS(mem_address_oSg),
         .mem_address_oA(mem_address_oAg),
         .modulo_out1(modulo_out1),
         .write_enable(write_enable),
         .mem_address_iInv(mem_address_iInv),
         .mem_input_inverse(mem_input_inverse),
         .mem_output_invg(mem_output_invg),
         .mem_address_oinvg(mem_address_oinvg),
         .sw(sw),
         .i(i),
         .k(k),
         .j(j),
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
         .R20(R20)
    
        );
  
    EGCD_FSM control_unit(
      .clk(clk),
      .start(start),
      .sw(sw),
      .Q1(Q1),
      .Q2(Q2),
      .Q3(Q3),
      .Q4(Q4),
      .Q5(Q5),
      .Q6(Q6),
      .Q7(Q7),
      .Q8(Q8),
      .startresetmem_1(startresetmem_1),
      .startresetmem_2(startresetmem_2),
      .restdonemem_1(restdonemem_1), 
      .restdonemem_2(restdonemem_2),  
      .degA(degAg),
      .degS(degSg),
      .mem_outputA(mem_outputAg),
      .startmod1(startmod1),
      .startdiv(startdiv), 
      .startsub1(startsub),
      .startmult1(startmult), 
      .subdone1(sub_done),
      .moddone1(moddone1), 
      .divdone(div_done), 
      .multdone1(mult_done),
      .egcd_done(egcd_done),
      .dego(dego), 
      .i(i),
      .k(k),
      .j(j),
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
      .R20(R20)    
      );     
      
      Mvfill Mvect(      
      .index(indexV),      
      .data(dataV)    
      );
      
      Mvu Mvud(      
      .index(indexU),      
      .data(dataU)    
      );    
    
      //memories    
      mem1_1 egcdmem1(      
      .clk(clk),      
      .input_data(mem_inputmem1_1),      
      .output_data(mem_outputmem1_1),      
      .read_address(mem_address_omem1_1),      
      .write_address(mem_address_imem1_1),      
      .write_enable(write_enablemem1_1)    
      );  
      
      mem2_1 egcdmem2(      
      .clk(clk),      
      .input_data(mem_inputmem2_1),      
      .output_data(mem_outputmem2_1),      
      .read_address(mem_address_omem2_1),      
      .write_address(mem_address_imem2_1),      
      .write_enable(write_enablemem2_1)    
      );  
      
      mem3_1 egcdmem3(      
      .clk(clk),      
      .input_data(mem_inputmem3_1),     
      .output_data(mem_outputmem3_1),      
      .read_address(mem_address_omem3_1),      
      .write_address(mem_address_imem3_1),
      .write_enable(write_enablemem3_1)    
      ); 
      
      mem4_1 egcdmem4(
      .clk(clk),
      .input_data(mem_inputmem4_1),
      .output_data(mem_outputmem4_1),
      .read_address(mem_address_omem4_1),
      .write_address(mem_address_imem4_1),
      .write_enable(write_enablemem4_1)  
    );  
    
    mem1_2 egcdmem5(
      .clk(clk),
      .input_data(mem_inputmem1_2),
      .output_data(mem_outputmem1_2),
      .read_address(mem_address_omem1_2),
      .write_address(mem_address_imem1_2),
      .write_enable(write_enablemem1_2), 
      .deg(degmem1_2),
      .dego(degomem1_2) 
    );
    
    mem2_2 egcdmem6(
      .clk(clk),
      .input_data(mem_inputmem2_2),
      .output_data(mem_outputmem2_2),
      .read_address(mem_address_omem2_2),
      .write_address(mem_address_imem2_2),
      .write_enable(write_enablemem2_2), 
      .deg(degmem2_2),
      .dego(degomem2_2)  
    );
    
    mem3_2 egcdmem7(
      .clk(clk),
      .input_data(mem_inputmem3_2),
      .output_data(mem_outputmem3_2),
      .read_address(mem_address_omem3_2),
      .write_address(mem_address_imem3_2),
      .write_enable(write_enablemem3_2), 
      .deg(degmem3_2),
      .dego(degomem3_2)  
    );
    
    mem4_2 egcdmem8(
      .clk(clk),
      .input_data(mem_inputmem4_2),
      .output_data(mem_outputmem4_2),
      .read_address(mem_address_omem4_2),
      .write_address(mem_address_imem4_2),
      .write_enable(write_enablemem4_2), 
      .deg(degmem4_2),
      .dego(degomem4_2)  
    );  
    
    //External modules
    
    Modulo_topdd modulo(
    .clk(clk),
    .N(mem_outputSg),
    .M(modu),
    .start(startmod1),
    .busy(moddone1),
    .mod(modulo_out1)    
    );
    
    Subpoly subs(
    .clk(clk),
    .start(startsub),
    .sub_done(sub_done),
    //memory output
    .mem_inputS(mem_inputSs),
    .mem_address_iS(mem_address_iSs),
    .mem_outputS(mem_outputSs),
    .mem_address_oS(mem_address_oSs),
    //Mem input
    .mem_address_oM1(mem_address_oM1s),
    .mem_address_oM2(mem_address_omsub),
    .mem_outputM1(mem_outputM1s),
    .mem_outputM2(mem_outputm),
    .degN(degNs),
    .degD(degDs),
    .deg(outdegs),
    .write_enable(write_enables)
    );
    
    
    divpoly_EGCD division(
    .clk(clk),
    .modu(modu),
    .start(startdiv),
    .mem_address_iQ(mem_address_iQ),
    .mem_address_iR(mem_address_iRd),
    .mem_inputQ(mem_inputQ),
    .mem_inputR(mem_inputRd),
    //input memories
    .mem_address_oN(mem_address_oNd),
    .mem_address_oD(mem_address_oDd),
    .mem_outputN(mem_outputNd),
    .mem_outputD(mem_outputDd),
    .degsubN(degR),
    .degQ(degQ),
    //used by sub and div
    .mem_address_imodN(mem_address_imodN),
    .mem_address_imodD(mem_address_imodD),
    .mem_address_omodN(mem_address_omodN),
    .mem_address_omodD(mem_address_omodD),
    .mem_output_modN(mem_output_modN),
    .mem_output_modD(mem_output_modD),
    .mem_input_modN(mem_input_modN),
    .mem_input_modD(mem_input_modD),
    .mem_address_imodNR(mem_address_imodNR),
    .mem_address_omodNR(mem_address_omodNR),
    .mem_output_modNR(mem_output_modNR),
    .mem_input_modNR(mem_input_modNR),
    .write_enable(write_enablediv),
    .write_enablemodD(write_enablemodD),
    .write_enablemodN(write_enablemodN),
    .write_enablemodNR(write_enablemodNR),
    .write_enableQ(write_enableq),
    .div_done(div_done)
    );
    
    Multpolyn_inv mult(
    .clk(clk),
    .start(startmult),
    .mult_done(mult_done),
    //memory output
    .mem_input(mem_inputm),
    .mem_output(mem_outputm),
    .mem_address_i(mem_address_im),
    .mem_address_o(mem_address_omult),
    .deg(degDs),
    .dega(dega),
    .degb(degb),
    //Mem input
    .mem_address_oa(mem_address_oam),
    .mem_address_ob(mem_address_oQ),
    .mem_output_a(mem_output_am),
    .mem_output_b(mem_outputQ),
    .write_enable(write_enablem)
    );
    
    resetpoly resetmem_1(
      .clk(clk),
      .start(startresetmem_1),
      .mem_input(mem_input_resetmem_1),
      .mem_address_i(mem_address_iresetmem_1),
      .max(11'd756),
      .write_enable(write_enableresetmem_1), 
      .write_done(reset_donemem_1) 
    );
    
    resetpoly resetmem_2(
      .clk(clk),
      .start(startresetmem_2),
      .mem_input(mem_input_resetmem_2),
      .mem_address_i(mem_address_iresetmem_2),
      .max(11'd756),
      .write_enable(write_enableresetmem_2),
      .write_done(reset_donemem_2)   
    );
    
    
    
endmodule
