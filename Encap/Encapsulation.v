`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.09.2023 00:16:14
// Design Name: 
// Module Name: Encapsulation
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


module Encapsulation(
    input clk,
    input start,
    output Encapsulation_done,
    input [11:0]q, p, t,
    //public key
    output [10:0]mem_address_oh,
    input  [12:0]mem_outputh,   
    input [10:0]degh,
    //r from decap
    output [10:0]mem_address_or_decap,
    input  [12:0]mem_outputr_decap,   
    input [10:0]degr_decap,
    input rfd,
    //output c
    output [10:0]mem_address_oc,
    output [10:0]mem_address_ic,
    input [12:0]mem_outputc,
    output [12:0]mem_inputc,
    output write_enablec,
    output [10:0]degc,    
    //output hash
    output [255:0]CK
    );

    wire Q1, Q2, Q3, Q4, R1, R2, R3, R4, R5,  R6, R7, R8, R9, R10, R11, R12;
    //r from decap
    assign mem_address_or_decap=Q4 ? mem_address_or_hash:Q1 ? mem_address_or_m:mem_address_or_decap;
    //general r
    wire [12:0]mem_outputr_gen=rfd ? mem_outputr_decap:mem_outputr;
    wire [10:0]indexV;
    wire [12:0]dataV;
    //r
    wire [10:0]degr;
    wire [10:0]mem_address_or=Q4 ? mem_address_or_hash:Q1 ? mem_address_or_m:mem_address_or_ts;
    wire [10:0]mem_address_ir;
    wire [12:0]mem_outputr;
    wire [12:0]mem_inputr;
    wire write_enabler;
      //for tsmall generator
    wire [10:0]mem_address_or_ts;
      //for multiplication
    wire [10:0]mem_address_or_m;
    wire [10:0]mem_address_or_hash;
    
    //c
    assign mem_address_oc=Q3 ? mem_address_oc_DP:mem_address_oc;
    assign mem_address_ic=Q3 ? mem_address_ic_DP:mem_address_ic_div;
    assign mem_inputc=Q3 ? mem_inputc_DP:mem_inputc_div;
    assign write_enablec=Q3 ?  write_enablec_DP:write_enablec_div;
      //division
    wire [10:0]mem_address_ic_div;
    wire [12:0]mem_inputc_div;
    wire write_enablec_div;
      //DP
    wire [10:0]mem_address_oc_DP;
    wire [10:0]mem_address_ic_DP;
    wire [12:0]mem_inputc_DP;
    wire write_enablec_DP;
    //Multiplication output
      //multiplication
    wire [10:0]mem_address_oso;
    wire [10:0]mem_address_iso;
    wire [25:0]mem_input_oso;
    wire write_enablem_so;
      //division
    wire [10:0]mem_address_om_div;
      //DP
    wire [10:0]mem_address_im_DP;
    wire [25:0]mem_inputm_DP;
    wire write_enablemDP;
      //memory
    wire [25:0]mem_inputm=Q3? mem_inputm_DP:mem_input_oso;
    wire [10:0]mem_address_im=Q3? mem_address_im_DP:mem_address_iso;
    wire [25:0]mem_outputm;
    wire [10:0]mem_address_om=Q2? mem_address_om_div:mem_address_oso;
    wire write_enablem=Q3 ? write_enablemDP:write_enablem_so;
    wire [10:0]deg_mult;
        
    //division memories
    wire [12:0]mem_inputQ;
    wire [10:0]mem_address_iQ;
    wire [12:0]mem_outputQ;
    wire [10:0]mem_address_oQ;
    wire [10:0]mem_address_imodN;
    wire [10:0]mem_address_imodD;
    wire [10:0]mem_address_omodN;
    wire [10:0]mem_address_omodD;
    wire [12:0]mem_output_modN;
    wire [12:0]mem_output_modD;
    wire [12:0]mem_input_modN;
    wire [12:0]mem_input_modD;
    wire [10:0]mem_address_imodNR;
    wire [10:0]mem_address_omodNR;
    wire [12:0]mem_output_modNR;
    wire [12:0]mem_input_modNR;
    wire write_enablemodD;
    wire write_enablemodN;
    wire write_enablemodNR;
    wire write_enableq;
    //general
    wire write_donets;
    wire dd;
    wire mult_done;
    wire div_done;
    wire startmult;
    wire startdiv;
    wire starthash;
    wire hash_done;
    //modulo
    wire startmod1, moddone1;
    wire [12:0]modulo_out1;
    wire [10:0]i, j; 
    //round
    wire startround1, rounddone1;
    wire [12:0]round_out1;
    
    
    Encapsulation_DP datapath(
    .clk(clk),
    .mem_inputS(mem_inputm_DP),
    .mem_address_iS(mem_address_im_DP),
    .mem_inputc(mem_inputc_DP),
    .mem_address_ic(mem_address_ic_DP),
    .mem_address_oc(mem_address_oc_DP),
    .round_out1(round_out1),
    .modulo_out1(modulo_out1),
    .degm(deg_mult),
    .i(i),
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
    .R12(R12)    
    );
    
    Encapsulation_FSM state_machine(
    .clk(clk),
    .starttspoly(starttspoly),
    .start(start),
    .startmult(startmult),
    .startdiv(startdiv),
    .write_enablemDP(write_enablemDP),
    .write_enable(write_enablec_DP),
    .dd(dd),
    .rfd(rfd),
    .i(i),
    .j(j),
    .deg(degc),
    .startround1(startround1),
    .rounddone1(rounddone1),
    .startmod1(startmod1),
    .moddone1(moddone1),
    .mult_done(mult_done),
    .divdone(div_done),
    .hash_done(hash_done),
    .starthash(starthash),
    .Q1(Q1),
    .Q2(Q2),
    .Q3(Q3),
    .Q4(Q4),
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
    .Encapsulation_done(Encapsulation_done)
    );
    
    //Generate tsmall polynomial r
    tsmall_polly_r tspolyr(
    .clk(clk),
    .start(starttspoly),
    .rand1(32'd3578962544),    
    .mem_input(mem_inputr),
    .mem_address_i(mem_address_ir),
    .mem_address_o(mem_address_or_ts),
    .mem_output(mem_outputr),
    .write_enable(write_enabler),
    .deg(degr),
    .dd(dd),
    .write_done(write_donets)   
    );
    
    //h*r    
    Multpolyn mult(
    .clk(clk),
    .start(startmult),
    .mult_done(mult_done),
    //memory output
    .mem_input(mem_input_oso),
    .mem_output(mem_outputm),
    .mem_address_i(mem_address_iso),
    .mem_address_o(mem_address_oso),
    .deg(deg_mult),
    .dega(degh),
    .degb(degr),
    //Mem input
    .mem_address_oa(mem_address_oh),
    .mem_address_ob(mem_address_or_m),
    .mem_output_a(mem_outputh),
    .mem_output_b(mem_outputr_gen),
    .write_enable(write_enablem_so)
    );
    
    // calculate h*r modulo x^p-x-1
    divpoly division(
    .clk(clk),
    .modu(q),
    .start(startdiv),
    .mem_address_iQ(mem_address_iQ),
    .mem_address_iR(mem_address_ic_div),
    .mem_inputQ(mem_inputQ),
    .mem_inputR(mem_inputc_div),
    .degsubN(degc),
    //input memories
    .mem_address_oN(mem_address_om_div),
    .mem_address_oD(indexV),
    .mem_outputN(mem_outputm),
    .mem_outputD(dataV),    
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
    .write_enable(write_enablec_div),
    .write_enablemodD(write_enablemodD),
    .write_enablemodN(write_enablemodN),
    .write_enablemodNR(write_enablemodNR),
    .write_enableQ(write_enableq),
    .div_done(div_done)
    );
    
    Modulo_top modulo(
    .clk(clk),
    .N(mem_outputc),
    .M(q),
    .start(startmod1),
    .busy(moddone1),
    .mod(modulo_out1)
    
    );
    
    Round_poly round(
    .clk(clk),
    .N(mem_outputc),
    .q({1'd0,q}),
    .start(startround1),
    .busy(rounddone1),
    .RoN(round_out1)
    
    );
    
    Hashgen hash(
    .clk(clk),
    .start(starthash),
    .prueba_fin(hash_done),
    .mem_address_oc(mem_address_or_hash),
    .mem_outputc(mem_outputr_gen),
    .degc(degr),
    .digest_256(CK)
    );
    
    //memories
    Mvfill Mvect(      
      .index(indexV),      
      .data(dataV)    
      );
    
    r rpoly(
    .clk(clk),
    .write_enable(write_enabler),
    .read_address(mem_address_or), 
    .write_address(mem_address_ir),
    .input_data(mem_inputr),
    .output_data(mem_outputr)
    );
    
    
      //division and multiplication
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
    
    
endmodule
