`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.09.2023 09:08:05
// Design Name: 
// Module Name: divpoly_EGCD_DP
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


module divpoly_EGCD_DP(
    input clk,
    input R1, R2,R3, R4, R5,R6,R7, R8, R9, R10, R11, R12, R13,R14, R15,R16, R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27,R28, R29,R30, R31, R32, R33, R34, R35, R36, R37, R38, R39, R40,
    input [12:0]mem_outputN,
    input [12:0]mem_outputD,
    input [25:0]mem_output_mult,
    input [12:0]mem_output_tempN,
    input [12:0]mem_output_modD,
    input [10:0]degsubN,
    input [12:0]modN,
    input [12:0]modD,
    input [12:0]modfrac,
    output reg[12:0]mem_inputQ,
    output reg[12:0]mem_inputR,
    output reg[10:0]mem_address_iQ,
    output reg[10:0]mem_address_iR,
    output reg[10:0]mem_address_oN,
    output reg[10:0]mem_address_oD,
    output reg[10:0]degN,degQ,
    output reg[10:0]degD,
    output reg[10:0]mem_address_imodN,
    output reg[10:0]mem_address_imodD,
    output reg[12:0]numm1,
    output reg[12:0]numm2,
    output reg[10:0]mem_address_omodN,
    output reg[10:0]mem_address_omodD,
    output reg[12:0]mem_input_modN,
    output reg[12:0]mem_input_modD,
    output reg[12:0]multN,
    output reg[10:0]mem_address_imult,
    output reg[25:0]mem_input_mult,
    output reg[10:0]mem_address_omult,
    output reg[10:0]mem_address_otempN,
    output reg[10:0]i,j,c,
    output reg[10:0]k
    );

    wire [10:0]nextmem_address_iQ;
    wire [10:0]nextmem_address_iR;
    wire [12:0]nextmem_inputQ;
    wire [12:0]nextmem_inputR;
    wire [10:0]nextmem_address_oN;
    wire [10:0]nextmem_address_oD;
    wire [10:0]nextdegD, nextdegQ;
    wire [10:0]nextdegN;
    wire [10:0]nextmem_address_imodN;
    wire [10:0]nextmem_address_imodD;
    wire [12:0]nextnumm1;
    wire [12:0]nextnumm2;
    wire [10:0]nextmem_address_omodN;
    wire [10:0]nextmem_address_omodD;
    wire [12:0]nextmem_input_modN;
    wire [12:0]nextmem_input_modD;
    wire [12:0]nextmultN;
    wire [10:0]nextmem_address_imult;
    wire [25:0]nextmem_input_mult;
    wire [10:0]nextmem_address_omult;
    wire [10:0]nextmem_address_otempN;
    wire [10:0]nexti,nextj,nextc;
    wire [10:0]nextk;
     
    
    // Registro M
    always @(posedge clk)
        mem_address_iQ <= nextmem_address_iQ;
    // Parte combinacional de M
    assign nextmem_address_iQ = R30 ? mem_address_iQ:j;
    
    // Registro A
    always @(posedge clk)
        i <= nexti;
    assign nexti = R1 ? R2 ? (i): (i) : R2 ? (i+1): (0);
    
    always @(posedge clk)
        j <= nextj;
    // Parte combinacional de M
    assign nextj =R3 ? R4 ? (j): (degN-degD) : R4 ? (j-1): (0);
    
    // Registro M
    always @(posedge clk)
        k <= nextk;
    // Parte combinacional de M
    assign nextk = R5 ? R6 ? (k): (k) : R6 ? (k+1): (0);
    
    always @(posedge clk)
        c <= nextc;
    // Parte combinacional de M
    assign nextc = R7 ? R8 ? (c): (c) : R8 ? (c+1): (0);  
         
    // Registro RP
    always @(posedge clk)
        mem_address_iR <= nextmem_address_iR;
    // Parte combinacional de RP
    assign nextmem_address_iR = R24 ? 11'd2047:R35 ? mem_address_iR: k;
    
    always @(posedge clk)
        mem_inputQ <= nextmem_inputQ;
    // Parte combinacional de RP
    assign nextmem_inputQ = R31 ? mem_inputQ: (multN);
    
    always @(posedge clk)
        mem_inputR <= nextmem_inputR;
    // Parte combinacional de RP
    assign nextmem_inputR = R28 ? degsubN:R36 ? mem_inputR:mem_output_tempN ;
    
    always @(posedge clk)
        mem_address_oN <= nextmem_address_oN;
    // Parte combinacional de RP
    assign nextmem_address_oN = R15 ? R16 ? (mem_address_oN): (k) : R16 ? (c): (11'd2047);
    
    always @(posedge clk)
        mem_address_oD <= nextmem_address_oD;
    // Parte combinacional de RP
    assign nextmem_address_oD = R17 ?  R18 ? (mem_address_oD): (mem_address_oD) : R18 ? (i): (11'd2047);
    
    // Registro M
    always @(posedge clk)
        degD <= nextdegD;
    // Parte combinacional de M
    assign nextdegD =R40 ? degD-1:R11 ? degD : mem_outputD ;
    // Registro M
    always @(posedge clk)
        degN <= nextdegN;
    // Parte combinacional de M
    assign nextdegN = R9 ? R10 ? (degN): (degN) : R10 ? (mem_outputN): (degsubN);
    
    always @(posedge clk)
        degQ <= nextdegQ;
    // Parte combinacional de M
    assign nextdegQ = R39 ? (degQ): (degN-degD);
    
    
    // Registro A
    always @(posedge clk)
        mem_address_imodN <= nextmem_address_imodN;
    assign nextmem_address_imodN = R12 ?  (mem_address_imodN) : (c) ;
            
    // Registro RP
    always @(posedge clk)
        mem_address_imodD <= nextmem_address_imodD;
    // Parte combinacional de RP
    assign nextmem_address_imodD = R13 ? R14 ? (mem_address_imodD): (mem_address_imodD) : R14 ? (i): (c);
    
    always @(posedge clk)
        numm1 <= nextnumm1;
    // Parte combinacional de RP
    assign nextnumm1 = R19 ? numm1:(mem_outputN);
    
    always @(posedge clk)
        numm2 <= nextnumm2;
    // Parte combinacional de RP
    assign nextnumm2 = R20 ? R27 ? (numm2): (numm2) : R27 ? (mem_output_mult): (mem_outputD);
    
    always @(posedge clk)
        mem_address_omodN <= nextmem_address_omodN;
    // Parte combinacional de RP
    assign nextmem_address_omodN = R21 ? (mem_address_omodN): (degN);
    
    always @(posedge clk)
        mem_address_omodD <= nextmem_address_omodD;
    // Parte combinacional de RP
    assign nextmem_address_omodD = R22 ? R23 ? (mem_address_omodD): (mem_address_omodD) : R23 ? (degD): (i);
    
    // Registro M
    always @(posedge clk)
        mem_input_modN <= nextmem_input_modN;
    // Parte combinacional de M
    assign nextmem_input_modN = R26 ? mem_input_modN:modN ;
    // Registro M
    always @(posedge clk)
        mem_input_modD <= nextmem_input_modD;
    // Parte combinacional de M
    assign nextmem_input_modD = R26 ? mem_input_modD:modD ;
    
    always @(posedge clk)
        multN <= nextmultN;
    // Parte combinacional de RP
    assign nextmultN = R29 ? multN: (modfrac);
    
    always @(posedge clk)
        mem_address_imult <= nextmem_address_imult;
    // Parte combinacional de RP
    assign nextmem_address_imult = R32 ? mem_address_imult : i;
    
    always @(posedge clk)
        mem_input_mult <= nextmem_input_mult;
    // Parte combinacional de RP
    assign nextmem_input_mult = R33 ? mem_input_mult : mem_output_modD*multN ;
    
    // Registro M
    always @(posedge clk)
        mem_address_omult <= nextmem_address_omult;
    // Parte combinacional de M
    assign nextmem_address_omult =R34 ? mem_address_omult : c;
    // Registro M
    always @(posedge clk)
        mem_address_otempN <= nextmem_address_otempN;
    // Parte combinacional de M
    assign nextmem_address_otempN = R37 ? R38 ? (mem_address_otempN): (mem_address_otempN) : R38 ? (11'd2047): (k);
endmodule
