`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.09.2023 11:39:42
// Design Name: 
// Module Name: KeyGen
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


module KeyGen(
    input clk,
    input start,
    output KeyGen_done,
    input [11:0]q, p, t,
    //output memories
      //f
    output [10:0]mem_address_if,
    output [10:0]mem_address_of,
    output [12:0]mem_inputf,
    input  [12:0]mem_outputf,
    output write_enablef,
      //h, Invg
    output [10:0]mem_address_ih,
    output [10:0]mem_address_iInvg,
    output [10:0]mem_address_oInvg,
    input  [12:0]mem_outputInvg,  
    output [10:0]mem_address_oh,
    input  [12:0]mem_outputh,   
    output [12:0]mem_inputh,
    output [12:0]mem_inputInvg,
    output write_enableh, write_enableInvg,    
    output [10:0]degf, degh, degInvg
    );
    
    assign mem_address_ih=Q3 ? mem_address_ih_div:mem_address_ihgen;
    assign mem_inputh=Q3 ? mem_inputh_div:mem_inputhgen;
    assign write_enableh=Q3 ? write_enableh_div:write_enablehgen;
    assign mem_address_iInvg= Q6 ? mem_address_inormg:mem_address_iInvg_EGCD;
    assign mem_inputInvg= Q6 ? mem_input_normg:mem_inputInvg_EGCD;
    assign write_enableInvg= Q6 ? write_enablenormg:write_enableInvg_EGCD;
    
    wire Q1, Q2, Q3, Q4, Q5,Q6, R1, R2, R3, R4, R5,  R6, R7;
    //modulo 
    wire startmod1, moddone1;
    wire [12:0]modulo_out1;
    wire [10:0]i;
    wire [12:0]GCDg;
    wire [12:0]GCDf; 
    //g inverse
    wire [10:0] mem_address_iInvg_EGCD;
    wire [12:0] mem_inputInvg_EGCD;
    wire write_enableInvg_EGCD;
    //memories to inside key gen
      //h, f
    wire [10:0]mem_address_of3;
    wire [12:0]mem_outputf3;
    wire [12:0]mem_inputf3=dd ? mem_inputf:3*mem_inputf;
    wire [10:0]mem_address_ih_div;
    wire [10:0]mem_address_ihgen;
    wire [12:0]mem_inputh_div;
    wire [12:0]mem_inputhgen;
    wire write_enableh_div, write_enablehgen;
      //g
    wire [10:0]mem_address_ogp;
    wire [10:0]mem_address_ogEGCD;
    wire [10:0]mem_address_ogmult;
    wire [10:0]degg;
    wire [12:0]mem_inputg;
    wire [12:0]mem_outputg;
    wire [10:0]mem_address_ig;
    wire [10:0]mem_address_og=Q2 ? mem_address_ogmult:Q1 ? mem_address_ogEGCD:mem_address_ogp;
      //1/3f mult
    wire [10:0]mem_address_oInv3f_mult;    
      //1/3f EGCD
    wire [12:0]mem_inputInv3f_EGCD;
    wire [10:0]mem_address_iInv3f_EGCD;
    wire write_enableInv3f_EGCD;
      //1/3f      
    wire [10:0]mem_address_oInv3f=Q6 ? mem_address_o_normf:mem_address_oInv3f_mult;
    wire [10:0]degInv3f;
    wire [12:0]mem_inputInv3f=Q6 ? mem_input_normf:mem_inputInv3f_EGCD;
    wire [12:0]mem_outputInv3f;
    wire [10:0]mem_address_iInv3f=Q6 ? mem_address_i_normf:mem_address_iInv3f_EGCD;
    wire write_enableInv3f=Q6 ? write_enablenormf:write_enableInv3f_EGCD;
    // memories EGCD g
    wire [25:0]mem_inputm2;
    wire [10:0]mem_address_im2;
    wire [25:0]mem_outputm2;
    wire [10:0]mem_address_om2;
    wire write_enablem2;
    wire [12:0]mem_inputQ2;
    wire [10:0]mem_address_iQ2;
    wire [12:0]mem_outputQ2;
    wire [10:0]mem_address_oQ2;
    wire [10:0]mem_address_imodN2;
    wire [10:0]mem_address_imodD2;
    wire [10:0]mem_address_omodN2;
    wire [10:0]mem_address_omodD2;
    wire [12:0]mem_output_modN2;
    wire [12:0]mem_output_modD2;
    wire [12:0]mem_input_modN2;
    wire [12:0]mem_input_modD2;
    wire [10:0]mem_address_imodNR2;
    wire [10:0]mem_address_omodNR2;
    wire [12:0]mem_output_modNR2;
    wire [12:0]mem_input_modNR2;
    wire write_enablemodD2;
    wire write_enablemodN2;
    wire write_enablemodNR2;
    wire write_enableq2;    
    //Division memories 
       //mod
    wire [10:0]indexV;
    wire [12:0]dataV;
      //For EGCD 1/3f
    wire [10:0]mem_address_ofEGCD;
    wire [12:0]mem_outputf_EGCD= Q5? 3*mem_outputf:mem_outputf;
    wire [12:0]mem_inputQ_EGCD;
    wire [10:0]mem_address_iQ_EGCD;
    wire [10:0]mem_address_oQ_EGCD;
    wire [10:0]mem_address_imodN_EGCD;
    wire [10:0]mem_address_imodD_EGCD;
    wire [10:0]mem_address_omodN_EGCD;
    wire [10:0]mem_address_omodD_EGCD;
    wire [12:0]mem_input_modN_EGCD;
    wire [12:0]mem_input_modD_EGCD;
    wire [10:0]mem_address_imodNR_EGCD;
    wire [10:0]mem_address_omodNR_EGCD;
    wire [12:0]mem_input_modNR_EGCD;
    wire write_enablemodD_EGCD;
    wire write_enablemodN_EGCD;
    wire write_enablemodNR_EGCD;
    wire write_enableq_EGCD;
      //For Division
    wire [12:0]mem_inputQ_div;
    wire [10:0]mem_address_iQ_div;
    wire [10:0]mem_address_oQ_div;
    wire [10:0]mem_address_imodN_div;
    wire [10:0]mem_address_imodD_div;
    wire [10:0]mem_address_omodN_div;
    wire [10:0]mem_address_omodD_div;
    wire [12:0]mem_input_modN_div;
    wire [12:0]mem_input_modD_div;
    wire [10:0]mem_address_imodNR_div;
    wire [10:0]mem_address_omodNR_div;
    wire [12:0]mem_input_modNR_div;
    wire write_enablemodD_div;
    wire write_enablemodN_div;
    wire write_enablemodNR_div;
    wire write_enableq_div;
      //for the memory
    wire [12:0]mem_inputQ=Q3 ? mem_inputQ_div:mem_inputQ_EGCD;
    wire [10:0]mem_address_iQ=Q3 ? mem_address_iQ_div:mem_address_iQ_EGCD;
    wire [12:0]mem_outputQ;
    wire [10:0]mem_address_oQ=Q3 ? mem_address_oQ:mem_address_oQ_EGCD;
    wire [10:0]mem_address_imodN=Q3 ? mem_address_imodN_div:mem_address_imodN_EGCD;
    wire [10:0]mem_address_imodD=Q3 ? mem_address_imodD_div:mem_address_imodD_EGCD;
    wire [10:0]mem_address_omodN=Q3 ? mem_address_omodN_div:mem_address_omodN_EGCD;
    wire [10:0]mem_address_omodD=Q3 ? mem_address_omodD_div:mem_address_omodD_EGCD;
    wire [12:0]mem_output_modN;
    wire [12:0]mem_output_modD;
    wire [12:0]mem_input_modN=Q3 ? mem_input_modN_div:mem_input_modN_EGCD;
    wire [12:0]mem_input_modD=Q3 ? mem_input_modD_div:mem_input_modD_EGCD;
    wire [10:0]mem_address_imodNR=Q3 ? mem_address_imodNR_div:mem_address_imodNR_EGCD;
    wire [10:0]mem_address_omodNR=Q3 ? mem_address_omodNR_div:mem_address_omodNR_EGCD;
    wire [12:0]mem_output_modNR;
    wire [12:0]mem_input_modNR=Q3 ? mem_input_modNR_div:mem_input_modNR_EGCD;
    wire write_enablemodD=Q3 ? write_enablemodD_div:write_enablemodD_EGCD;
    wire write_enablemodN=Q3 ? write_enablemodN_div:write_enablemodN_EGCD;
    wire write_enablemodNR=Q3 ? write_enablemodNR_div:write_enablemodNR_EGCD;
    wire write_enableq=Q3 ? write_enableq_div:write_enableq_EGCD;
    //multiplication memories
      //for EGCD
    wire [25:0]mem_inputm_EGCD;
    wire [10:0]mem_address_im_EGCD;
    wire [10:0]mem_address_om_EGCD;
    wire write_enablemultEGCD;
      //for multiplication
    wire [25:0]mem_inputso;
    wire [10:0]mem_address_iso;
    wire [10:0]mem_address_oso;
    wire write_enablemultso;
      //for the DP
    wire [25:0]mem_inputmgen;
    wire [10:0]mem_address_imgen;
    wire write_enablemultDP;
      //for division
    wire [10:0]mem_address_oso_div; 
      //for the memory
    wire [25:0]mem_inputm=Q3? Q4?mem_inputm:mem_inputmgen:Q4?mem_inputso:mem_inputm_EGCD;
    wire [10:0]mem_address_im=Q3? Q4?mem_address_im:mem_address_imgen:Q4?mem_address_iso:mem_address_im_EGCD;
    wire [25:0]mem_outputm;
    wire [10:0]mem_address_om=Q3? Q4?mem_address_oso_div:mem_address_om:Q4?mem_address_oso:mem_address_om_EGCD;
    wire write_enablem=Q3? Q4?write_enablem:write_enablemultDP:Q4?write_enablemultso:write_enablemultEGCD;
    wire [10:0]deg_mult;
    //Normalize
    wire startNormg, normg;
    wire startNormf, normf;
    wire [12:0]mem_input_normg;
    wire [12:0]mem_input_normf;
    wire [10:0]mem_address_o_normf;
    wire [10:0]mem_address_i_normf;
    wire [10:0]mem_address_inormg;
    wire write_enablenormf;
    wire write_enablenormg;
    //general
    wire write_enableg;
    wire write_enablediv;
    wire write_donets;
    wire write_dones;
    wire dd;
    wire EGCD_done3f;
    wire EGCD_doneg;
    wire mult_done;
    wire div_done; 
    wire startEGCD3f;
    wire startEGCDg;
    wire startmult;
    wire startdiv;
    
    KeyGen_DP datapath(
    .clk(clk),
    .mem_inputS(mem_inputmgen),
    .mem_address_iS(mem_address_imgen),
    .mem_inputR(mem_inputhgen),
    .mem_address_iR(mem_address_ihgen),
    .mem_address_oR(mem_address_oh),
    .modulo_out1(modulo_out1),
    .deg(deg_mult),
    .i(i),
    .R1(R1),
    .R2(R2),
    .R3(R3),
    .R4(R4),
    .R5(R5),
    .R6(R6),
    .R7(R7)
    );
    
    KeyGen_FSM state_machine(
    .clk(clk),
    .starttspoly(starttspoly),
    .startspoly(startspoly),
    .start(start),
    .startEGCD3f(startEGCD3f),
    .startEGCDg(startEGCDg),
    .startmult(startmult),
    .startdiv(startdiv),
    .write_enablemultDP(write_enablemultDP),
    .write_enable(write_enablehgen),
    .startnormf(startNormf),
    .startnormg(startNormg),
    .normf(normf),
    .normg(normg),
    .dd(dd),
    .i(i),
    .degR(degh),
    .startmod1(startmod1),
    .moddone1(moddone1),
    .write_dones(write_dones),
    .EGCD_done3f(EGCD_done3f),
    .EGCD_doneg(EGCD_doneg),
    .mult_done(mult_done),
    .divdone(div_done),
    .Q1(Q1),
    .Q2(Q2),
    .Q3(Q3),
    .Q4(Q4),
    .Q5(Q5),
    .Q6(Q6),
    .R1(R1),
    .R2(R2),
    .R3(R3),
    .R4(R4),
    .R5(R5),
    .R6(R6),
    .R7(R7),
    .KeyGen_done(KeyGen_done)
    );
    
    //Generate tsmall polynomial f
    tsmall_poly tspoly(
    .clk(clk),
    .start(starttspoly),
    .rand1(32'd2935687455),    
    .mem_input(mem_inputf),
    .mem_address_i(mem_address_if),
    .mem_address_o(mem_address_of),
    .mem_output(mem_outputf),
    .write_enable(write_enablef),
    .deg(degf),
    .dd(dd),
    .write_done(write_donets)   
    );
      
    //Generate small polynomial g
    small_poly spoly(
    .clk(clk),
    .start(startspoly),
    .mem_output(mem_outputg),
    .mem_input(mem_inputg),
    .mem_address_i(mem_address_ig),
    .mem_address_o(mem_address_ogp),
    .write_enable(write_enableg),
    .deg(degg),
    .write_done(write_dones)
    );
    
    //Inverse of 3f in order to multiply g*1/3f
    EGCD Inverse3f(
    .clk(clk),
    .modu(q),
    .start(startEGCD3f),    
    //
    .GCD(GCDf),
    .dego(degInv3f),
    .mem_input_inverse(mem_inputInv3f_EGCD),
    .mem_address_iInv(mem_address_iInv3f_EGCD),
    //input memories
    .mem_address_oA(mem_address_of3),
    .mem_outputA(mem_outputf3),
    //mult
    .mem_inputm(mem_inputm_EGCD),
    .mem_address_im(mem_address_im_EGCD),
    .mem_outputm(mem_outputm),
    .mem_address_om(mem_address_om_EGCD),
    .write_enablem(write_enablemultEGCD),
    //used by sub and div
    .mem_address_iQ(mem_address_iQ_EGCD),
    .mem_inputQ(mem_inputQ_EGCD),
    .mem_address_oQ(mem_address_oQ_EGCD),
    .mem_outputQ(mem_outputQ),
    .mem_address_imodN(mem_address_imodN_EGCD),
    .mem_address_imodD(mem_address_imodD_EGCD),
    .mem_address_omodN(mem_address_omodN_EGCD),
    .mem_address_omodD(mem_address_omodD_EGCD),
    .mem_output_modN(mem_output_modN),
    .mem_output_modD(mem_output_modD),
    .mem_input_modN(mem_input_modN_EGCD),
    .mem_input_modD(mem_input_modD_EGCD),
    .mem_address_imodNR(mem_address_imodNR_EGCD),
    .mem_address_omodNR(mem_address_omodNR_EGCD),
    .mem_output_modNR(mem_output_modNR),
    .mem_input_modNR(mem_input_modNR_EGCD),
    .write_enablemodD(write_enablemodD_EGCD),
    .write_enablemodN(write_enablemodN_EGCD),
    .write_enablemodNR(write_enablemodNR_EGCD),
    .write_enableq(write_enableq_EGCD),
    .write_enablediv(write_enablediv),
    .write_enable(write_enableInv3f_EGCD),
    .egcd_done(EGCD_done3f)
    );
    
    //Inverse of g
    EGCD Inverseg(
    .clk(clk),
    .modu(12'd3),
    .start(startEGCDg),    
    //
    .GCD(GCDg),
    .dego(degInvg),
    .mem_input_inverse(mem_inputInvg_EGCD),
    .mem_address_iInv(mem_address_iInvg_EGCD),
    //input memories
    .mem_address_oA(mem_address_ogEGCD),
    .mem_outputA(mem_outputg),
    //mult
    .mem_inputm(mem_inputm2),
    .mem_address_im(mem_address_im2),
    .mem_outputm(mem_outputm2),
    .mem_address_om(mem_address_om2),
    .write_enablem(write_enablem2),
    //used by sub and div
    .mem_address_iQ(mem_address_iQ2),
    .mem_inputQ(mem_inputQ2),
    .mem_address_oQ(mem_address_oQ2),
    .mem_outputQ(mem_outputQ2),
    .mem_address_imodN(mem_address_imodN2),
    .mem_address_imodD(mem_address_imodD2),
    .mem_address_omodN(mem_address_omodN2),
    .mem_address_omodD(mem_address_omodD2),
    .mem_output_modN(mem_output_modN2),
    .mem_output_modD(mem_output_modD2),
    .mem_input_modN(mem_input_modN2),
    .mem_input_modD(mem_input_modD2),
    .mem_address_imodNR(mem_address_imodNR2),
    .mem_address_omodNR(mem_address_omodNR2),
    .mem_output_modNR(mem_output_modNR2),
    .mem_input_modNR(mem_input_modNR2),
    .write_enablemodD(write_enablemodD2),
    .write_enablemodN(write_enablemodN2),
    .write_enablemodNR(write_enablemodNR2),
    .write_enableq(write_enableq2),
    .write_enablediv(write_enable2),
    .write_enable(write_enableInvg_EGCD),
    .egcd_done(EGCD_doneg)
    );
    
    //g*1/3f    
    Multpolyn mult(
    .clk(clk),
    .start(startmult),
    .mult_done(mult_done),
    //memory output
    .mem_input(mem_inputso),
    .mem_output(mem_outputm),
    .mem_address_i(mem_address_iso),
    .mem_address_o(mem_address_oso),
    .deg(deg_mult),
    .dega(degg),
    .degb(degInv3f),
    //Mem input
    .mem_address_oa(mem_address_ogmult),
    .mem_address_ob(mem_address_oInv3f_mult),
    .mem_output_a(mem_outputg),
    .mem_output_b(mem_outputInv3f),
    .write_enable(write_enablemultso)
    );
    
    // calculate h
    divpoly division(
    .clk(clk),
    .modu(q),
    .start(startdiv),
    .mem_address_iQ(mem_address_iQ_div),
    .mem_address_iR(mem_address_ih_div),
    .mem_inputQ(mem_inputQ_div),
    .mem_inputR(mem_inputh_div),
    .degsubN(degh),
    //input memories
    .mem_address_oN(mem_address_oso_div),
    .mem_address_oD(indexV),
    .mem_outputN(mem_outputm),
    .mem_outputD(dataV),    
    //used by sub and div
    .mem_address_imodN(mem_address_imodN_div),
    .mem_address_imodD(mem_address_imodD_div),
    .mem_address_omodN(mem_address_omodN_div),
    .mem_address_omodD(mem_address_omodD_div),
    .mem_output_modN(mem_output_modN),
    .mem_output_modD(mem_output_modD),
    .mem_input_modN(mem_input_modN_div),
    .mem_input_modD(mem_input_modD_div),
    .mem_address_imodNR(mem_address_imodNR_div),
    .mem_address_omodNR(mem_address_omodNR_div),
    .mem_output_modNR(mem_output_modNR),
    .mem_input_modNR(mem_input_modNR_div),
    .write_enable(write_enableh_div),
    .write_enablemodD(write_enablemodD_div),
    .write_enablemodN(write_enablemodN_div),
    .write_enablemodNR(write_enablemodNR_div),
    .write_enableQ(write_enableq_div),
    .div_done(div_done)
    );
    
    Normalize_inverse Nf(
    .clk(clk),
    .mem_output(mem_outputInv3f),
    .mem_address_o(mem_address_o_normf),
    .mem_input(mem_input_normf),
    .mem_address_i(mem_address_i_normf),
    .write_enable(write_enablenormf),
    .degp(degInv3f),
    .GCD(GCDf),
    .mod({1'b0,q}),
    .start(startNormf),
    .busy(normf)
    );
    
    Normalize_inverse Ng(
    .clk(clk),
    .mem_output(mem_outputInvg),
    .mem_address_o(mem_address_oInvg),
    .mem_input(mem_input_normg),
    .mem_address_i(mem_address_inormg),
    .write_enable(write_enablenormg),
    .degp(degInvg),
    .GCD(GCDg),
    .mod(13'd3),
    .start(startNormf),
    .busy(normg)
    );
    
    Modulo_top modulo(
    .clk(clk),
    .N(mem_outputh),
    .M(q),
    .start(startmod1),
    .busy(moddone1),
    .mod(modulo_out1)
    
    );
    
    //general memories
    F f3poly(
    .clk(clk),
    .write_enable(write_enablef),
    .read_address(mem_address_of3), 
    .write_address(mem_address_if),
    .input_data(mem_inputf3),
    .output_data(mem_outputf3)
    );
    
    Mvfill Mvect(      
      .index(indexV),      
      .data(dataV)    
      );
          
    g gpoly(
    .clk(clk),
    .write_enable(write_enableg),
    .read_address(mem_address_og), 
    .write_address(mem_address_ig),
    .input_data(mem_inputg),
    .output_data(mem_outputg)
    );
    
    
    mem_Inv3f Inv3f(
    .clk(clk),
    .write_enable(write_enableInv3f),
    .read_address(mem_address_oInv3f), 
    .write_address(mem_address_iInv3f),
    .input_data(mem_inputInv3f),
    .output_data(mem_outputInv3f)
    );
    
    //memories 3f-Inverse, mutipliation and division
    ModpolyD divmodD(
    .clk(clk),
    .write_enable(write_enablemodD),
    .read_address(mem_address_omodD), 
    .write_address(mem_address_imodD),
    .input_data(mem_input_modD),
    .output_data(mem_output_modD)    
    );
    
    ModpolyN divmodN(
    .clk(clk),
    .write_enable(write_enablemodN),
    .read_address(mem_address_omodN), 
    .write_address(mem_address_imodN),
    .input_data(mem_input_modN),
    .output_data(mem_output_modN)    
    );
    
    ModpolyNR divmodNR(
    .clk(clk),
    .write_enable(write_enablemodNR),
    .read_address(mem_address_omodNR), 
    .write_address(mem_address_imodNR),
    .input_data(mem_input_modNR),
    .output_data(mem_output_modNR)    
    );
    
    TempdivQ divQ(
    .clk(clk),
    .write_enable(write_enableq), 
    .write_address(mem_address_iQ),
    .input_data(mem_inputQ),
    .read_address(mem_address_oQ),
    .output_data(mem_outputQ)    
    );
    
    TempN divtempN(
    .clk(clk),
    .write_enable(write_enablem),
    .read_address(mem_address_om), 
    .write_address(mem_address_im),
    .input_data(mem_inputm),
    .output_data(mem_outputm)    
    );
    
    //memories g-Inverse
    ModpolyD divmodD2(
    .clk(clk),
    .write_enable(write_enablemodD2),
    .read_address(mem_address_omodD2), 
    .write_address(mem_address_imodD2),
    .input_data(mem_input_modD2),
    .output_data(mem_output_modD2)    
    );
    
    ModpolyN divmodN2(
    .clk(clk),
    .write_enable(write_enablemodN2),
    .read_address(mem_address_omodN2), 
    .write_address(mem_address_imodN2),
    .input_data(mem_input_modN2),
    .output_data(mem_output_modN2)    
    );
    
    ModpolyNR divmodNR2(
    .clk(clk),
    .write_enable(write_enablemodNR2),
    .read_address(mem_address_omodNR2), 
    .write_address(mem_address_imodNR2),
    .input_data(mem_input_modNR2),
    .output_data(mem_output_modNR2)    
    );
    
    TempdivQ divQ2(
    .clk(clk),
    .write_enable(write_enableq2), 
    .write_address(mem_address_iQ2),
    .input_data(mem_inputQ2),
    .read_address(mem_address_oQ2),
    .output_data(mem_outputQ2)    
    );
    
    TempN divtempN2(
    .clk(clk),
    .write_enable(write_enablem2),
    .read_address(mem_address_om2), 
    .write_address(mem_address_im2),
    .input_data(mem_inputm2),
    .output_data(mem_outputm2)    
    );   
    
endmodule
