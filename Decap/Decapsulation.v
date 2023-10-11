`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2023 19:30:37
// Design Name: 
// Module Name: Decapsulation
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


module Decapsulation(
    input clk,
    input start,
    output Decapsulation_done,
    input [11:0]q, p, t,
    //private key
      //f
    output [10:0]mem_address_of,
    input  [12:0]mem_outputf,   
    input [10:0]degf,
      //Invg
    output [10:0]mem_address_oInvg,
    input [12:0]mem_outputInvg,
    input [10:0]degInvg,
    //Public key
    output [10:0]mem_address_oh,
    input  [12:0]mem_outputh,   
    input [10:0]degh,
    //Cyphertext
    output [10:0]mem_address_oc,
    input [12:0]mem_outputc,
    input [10:0]degc, 
    input [127:0]C,   
    //output hash
    output [127:0]Cypherdec
    );
    
    assign Cypherdec= Q8 ? CK[127:0]:Q9 ? 128'd1:Cypherdec;
    wire Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, R1, R2, R3, R4, R5,  R6, R7, R8, R9, R10, R11, R12;
    // Ring polynomial
      //e division
    wire [10:0]indexV_e;  
      //r division
    wire [10:0]indexV_rp;
      //mem  
    wire [10:0]indexV=Q1 ? indexV_rp:indexV_e;
    wire [12:0]dataV;
    //vects
    wire [12:0]dataTs;
    //rp
      //lift
    wire [10:0]mem_address_orp_l;
    wire [10:0]mem_address_orp_lN;
    wire [12:0]mem_inputrp_lN;
    wire [10:0]mem_address_irp_lN;
    wire write_enable_lN;
      //division
    wire [12:0]mem_inputrp_div;
    wire [10:0]mem_address_irp_div;
    wire write_enable_div;
      //encapsulation
    wire [10:0]mem_address_orp_ed;
    wire [12:0]mem_outputrp_ed=Q11? dataTs: mem_outputrp;
      //memory
    wire [10:0]degrp;
    wire [10:0]mem_address_orp=Q12 ? mem_address_orp_lN:Q10 ? mem_address_orp_ed:mem_address_orp_l;
    wire [10:0]mem_address_irp=Q12 ? mem_address_irp_lN:mem_address_irp_div;
    wire [12:0]mem_outputrp;
    wire [12:0]mem_inputrp=Q12 ? mem_inputrp_lN:mem_inputrp_div;
    wire write_enablerp=Q12 ? write_enablerp_lN:write_enablerp_div;
    //e
      //mult
    wire [10:0]mem_address_oe_m;
      //division
    wire [10:0]mem_address_ie_div;
    wire [12:0]mem_inpute_div;
    wire write_enable_e_div; 
      //datapath
    wire [10:0]mem_address_oe_DP;
    wire [10:0]mem_address_ie_DP;
    wire [12:0]mem_inpute_DP;
    wire write_enable_e_DP;     
      //memory
    wire [10:0]dege;
    wire [10:0]mem_address_oe=Q2 ? mem_address_oe_m:mem_address_oe_DP;
    wire [10:0]mem_address_ie=Q3 ? mem_address_ie_DP:mem_address_ie_div;
    wire [12:0]mem_outpute;
    wire [12:0]mem_inpute=Q3 ? mem_inpute_DP:mem_inpute_div;
    wire write_enable_e= Q3 ? write_enable_e_DP:write_enable_e_div;       
    //Multiplication output
      // e mult
    wire [10:0]mem_address_oso_e;
    wire [10:0]mem_address_iso_e;
    wire [25:0]mem_input_oso_e;
    wire write_enablem_so_e;
      //e division
    wire [10:0]mem_address_om_dive;
      //DP
    wire [10:0]mem_address_im_DP;
    wire [25:0]mem_inputm_DP;
    wire write_enablemDP; 
      //rp mult
    wire [10:0]mem_address_oso_rp;
    wire [10:0]mem_address_iso_rp;
    wire [25:0]mem_input_oso_rp;
    wire write_enablem_so_rp;
      //rp division
    wire [10:0]mem_address_om_divrp;      
      //memory
    wire [25:0]mem_inputm=Q4 ? Q5 ? mem_input_oso_rp:mem_inputm_DP:mem_input_oso_e;
    wire [10:0]mem_address_im=Q3 ? Q5 ? mem_address_iso_rp:mem_address_im_DP:mem_address_iso_e;
    wire [25:0]mem_outputm;
    wire [10:0]mem_address_om=Q3 ? Q6?mem_address_om_divrp:mem_address_oso_rp:Q6?mem_address_om_dive:mem_address_oso_e;
    wire write_enablem=Q3 ? Q5 ? write_enablem_so_rp:write_enablemDP:write_enablem_so_e;
    wire [10:0]deg_mult=Q1 ? deg_multrp:deg_multe;
    wire [10:0]deg_multe;
    wire [10:0]deg_multrp;    
    //division memories
      //e div
    wire [12:0]mem_inputQ_e;
    wire [10:0]mem_address_iQ_e;
    wire [10:0]mem_address_imodN_e;
    wire [10:0]mem_address_imodD_e;
    wire [10:0]mem_address_omodN_e;
    wire [10:0]mem_address_omodD_e;
    wire [12:0]mem_input_modN_e;
    wire [12:0]mem_input_modD_e;
    wire [10:0]mem_address_imodNR_e;
    wire [10:0]mem_address_omodNR_e;
    wire [12:0]mem_input_modNR_e;
    wire write_enablemodD_e;
    wire write_enablemodN_e;
    wire write_enablemodNR_e;
    wire write_enableq_e;
      //rp div
    wire [12:0]mem_inputQ_rp;
    wire [10:0]mem_address_iQ_rp;
    wire [10:0]mem_address_imodN_rp;
    wire [10:0]mem_address_imodD_rp;
    wire [10:0]mem_address_omodN_rp;
    wire [10:0]mem_address_omodD_rp;
    wire [12:0]mem_input_modN_rp;
    wire [12:0]mem_input_modD_rp;
    wire [10:0]mem_address_imodNR_rp;
    wire [10:0]mem_address_omodNR_rp;
    wire [12:0]mem_input_modNR_rp;
    wire write_enablemodD_rp;
    wire write_enablemodN_rp;
    wire write_enablemodNR_rp;
    wire write_enableq_rp;
      //memories
    wire [12:0]mem_inputQ=Q7 ? mem_inputQ_rp:mem_inputQ_e;
    wire [10:0]mem_address_iQ=Q7 ? mem_address_iQ_rp:mem_address_iQ_e;
    wire [12:0]mem_outputQ;
    wire [10:0]mem_address_oQ;
    wire [10:0]mem_address_imodN=Q7 ? mem_address_imodN_rp:mem_address_imodN_e;
    wire [10:0]mem_address_imodD=Q7 ? mem_address_imodD_rp:mem_address_imodD_e;
    wire [10:0]mem_address_omodN=Q7 ? mem_address_omodN_rp:mem_address_omodN_e;
    wire [10:0]mem_address_omodD=Q7 ? mem_address_omodD_rp:mem_address_omodD_e;
    wire [12:0]mem_output_modN;
    wire [12:0]mem_output_modD;
    wire [12:0]mem_input_modN=Q7 ? mem_input_modN_rp:mem_input_modN_e;
    wire [12:0]mem_input_modD=Q7 ? mem_input_modD_rp:mem_input_modD_e;
    wire [10:0]mem_address_imodNR=Q7 ? mem_address_imodNR_rp:mem_address_imodNR_e;
    wire [10:0]mem_address_omodNR=Q7 ? mem_address_omodNR_rp:mem_address_omodNR_e;
    wire [12:0]mem_output_modNR;
    wire [12:0]mem_input_modNR=Q7 ? mem_input_modNR_rp:mem_input_modNR_e;
    wire write_enablemodD=Q7 ? write_enablemodD_rp:write_enablemodD_e;
    wire write_enablemodN=Q7 ? write_enablemodN_rp:write_enablemodN_e;
    wire write_enablemodNR=Q7 ? write_enablemodNR_rp:write_enablemodNR_e;
    wire write_enableq=Q7 ? write_enableq_rp:write_enableq_e;
    //general
    wire [255:0]CK;
    wire [12:0]mem_inputc_encap;
    wire [12:0]mem_outputc_encap;
    wire [10:0]mem_address_oc_encap;
    wire [10:0]mem_address_ic_encap;
    wire write_enablec_encap;
    wire [10:0]degc_encap;
    wire Encapsulation_done;
    wire start_encap;
    wire mult_done;
    wire div_done;
    wire startmult;
    wire startdiv;
    //lift
    wire startliftN, LiftNdone;
    wire [12:0]liftNout;
    wire startlift, liftdone;
    wire st;
    //modulo
    wire startmod1, moddone1;
    wire [12:0]modulo_out1;
    wire [10:0]i, j, k; 
    //modulo3_decap
    wire startmod3_dc, mod3dcdone;
    wire [12:0]mod3_out;
    
    
    Decapsulation_DP datapath(
    .clk(clk),
    .mem_inputS(mem_inputm_DP),
    .mem_address_iS(mem_address_im_DP),
    .mem_inpute(mem_inpute_DP),
    .mem_address_ie(mem_address_ie_DP),
    .mem_address_oe(mem_address_oe_DP),
    .mod3_out(mod3_out),
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
    
    Decapsulation_FSM state_machine(
    .clk(clk),
    .start(start),
    .startmult(startmult),
    .startdiv(startdiv),
    .startmult_rp(startmult_rp),
    .startdiv_rp(startdiv_rp),
    .write_enablemDP(write_enablemDP),
    .write_enable(write_enable_e_DP),
    .startlift(startlift),
    .liftdone(liftdone),
    .startliftN(startliftN),
    .liftNdone(liftNdone),
    .start_encap(start_encap),
    .st(st),
    .i(i),
    .j(j),
    .deg(dege),
    .startmod3_dc(startmod3_dc),
    .mod3dcdone(mod3dcdone),
    .startmod1(startmod1),
    .moddone1(moddone1),
    .mult_done(mult_done),
    .divdone(div_done),
    .mult_done_rp(mult_done_rp),
    .divdone_rp(div_done_rp),
    .C(C),
    .Cp(CK[255:128]),
    .Encapsulation_done(Encapsulation_done),
    .Q1(Q1),
    .Q2(Q2),
    .Q3(Q3),
    .Q4(Q4),
    .Q5(Q5),
    .Q6(Q6),
    .Q7(Q7),
    .Q8(Q8),
    .Q9(Q9),
    .Q10(Q10),
    .Q11(Q11),
    .Q12(Q12),
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
    .Decapsulation_done(Decapsulation_done)
    );
    
    
    //c*3f    
    Multpolyn multe(
    .clk(clk),
    .start(startmult),
    .mult_done(mult_done),
    //memory output
    .mem_input(mem_input_oso_e),
    .mem_output(mem_outputm),
    .mem_address_i(mem_address_iso_e),
    .mem_address_o(mem_address_oso_e),
    .deg(deg_multe),
    .dega(degc),
    .degb(degf),
    //Mem input
    .mem_address_oa(mem_address_oc),
    .mem_address_ob(mem_address_of),
    .mem_output_a(mem_outputc),
    .mem_output_b(3*mem_outputf),
    .write_enable(write_enablem_so_e)
    );
    
    // calculate r*3f modulo x^p-x-1
    divpoly divisione(
    .clk(clk),
    .modu(q),
    .start(startdiv),
    .mem_address_iQ(mem_address_iQ_e),
    .mem_address_iR(mem_address_ie_div),
    .mem_inputQ(mem_inputQ_e),
    .mem_inputR(mem_inpute_div),
    .degsubN(dege),
    //input memories
    .mem_address_oN(mem_address_om_dive),
    .mem_address_oD(indexV_e),
    .mem_outputN(mem_outputm),
    .mem_outputD(dataV),    
    //used by sub and div
    .mem_address_imodN(mem_address_imodN_e),
    .mem_address_imodD(mem_address_imodD_e),
    .mem_address_omodN(mem_address_omodN_e),
    .mem_address_omodD(mem_address_omodD_e),
    .mem_output_modN(mem_output_modN),
    .mem_output_modD(mem_output_modD),
    .mem_input_modN(mem_input_modN_e),
    .mem_input_modD(mem_input_modD_e),
    .mem_address_imodNR(mem_address_imodNR_e),
    .mem_address_omodNR(mem_address_omodNR_e),
    .mem_output_modNR(mem_output_modNR),
    .mem_input_modNR(mem_input_modNR_e),
    .write_enable(write_enable_e_div),
    .write_enablemodD(write_enablemodD_e),
    .write_enablemodN(write_enablemodN_e),
    .write_enablemodNR(write_enablemodNR_e),
    .write_enableQ(write_enableq_e),
    .div_done(div_done)
    );
    
    Modulo_top moduloe(
    .clk(clk),
    .N(mem_outpute),
    .M(q),
    .start(startmod1),
    .busy(moddone1),
    .mod(modulo_out1)
    
    );
    
    modulo3_decap modulo3(
    .clk(clk),
    .N(mem_outpute),
    .q({1'd0,q}),
    .start(startmod3_dc),
    .busy(mod3dcdone),
    .p(mod3_out)
    );
    
    //e*1/g    
    Multpolyn multrp(
    .clk(clk),
    .start(startmult_rp),
    .mult_done(mult_done_rp),
    //memory output
    .mem_input(mem_input_oso_rp),
    .mem_output(mem_outputm),
    .mem_address_i(mem_address_iso_rp),
    .mem_address_o(mem_address_oso_rp),
    .deg(deg_multrp),
    .dega(dege),
    .degb(degInvg),
    //Mem input
    .mem_address_oa(mem_address_oe_m),
    .mem_address_ob(mem_address_oInvg),
    .mem_output_a(mem_outpute),
    .mem_output_b(mem_outputInvg),
    .write_enable(write_enablem_so_rp)
    );
    
    // calculate e*1/g modulo x^p-x-1
    divpoly divisionrp(
    .clk(clk),
    .modu(12'd3),
    .start(startdiv_rp),
    .mem_address_iQ(mem_address_iQ_rp),
    .mem_address_iR(mem_address_irp_div),
    .mem_inputQ(mem_inputQ_rp),
    .mem_inputR(mem_inputrp_div),
    .degsubN(degrp),
    //input memories
    .mem_address_oN(mem_address_om_divrp),
    .mem_address_oD(indexV_rp),
    .mem_outputN(mem_outputm),
    .mem_outputD(dataV),    
    //used by sub and div
    .mem_address_imodN(mem_address_imodN_rp),
    .mem_address_imodD(mem_address_imodD_rp),
    .mem_address_omodN(mem_address_omodN_rp),
    .mem_address_omodD(mem_address_omodD_rp),
    .mem_output_modN(mem_output_modN),
    .mem_output_modD(mem_output_modD),
    .mem_input_modN(mem_input_modN_rp),
    .mem_input_modD(mem_input_modD_rp),
    .mem_address_imodNR(mem_address_imodNR_rp),
    .mem_address_omodNR(mem_address_omodNR_rp),
    .mem_output_modNR(mem_output_modNR),
    .mem_input_modNR(mem_input_modNR_rp),
    .write_enable(write_enablerp_div),
    .write_enablemodD(write_enablemodD_rp),
    .write_enablemodN(write_enablemodN_rp),
    .write_enablemodNR(write_enablemodNR_rp),
    .write_enableQ(write_enableq_rp),
    .div_done(div_done_rp)
    );
    
    liftN liftR(
    .clk(clk),
    .mem_output(mem_outputrp),
    .mem_address_o(mem_address_orp_lN),
    .mem_input(mem_inputrp_lN),
    .mem_address_i(mem_address_irp_lN),
    .write_enable(write_enablerp_lN),
    .degp(degrp),
    .start(startliftN),
    .busy(liftNdone)
    ); 
    
    Lift_poly checktsmall(
    .clk(clk),
    .mem_output(mem_outputrp),
    .mem_address_o(mem_address_orp_l),
    .degp(degrp),
    .start(startlift),
    .busy(liftdone), 
    .st(st)    
    );
    
    Encapsulation Encap_decap(
    .clk(clk),
    .p(p),
    .q(q),
    .t(t),
    .start(start_encap),
    .Encapsulation_done(Encapsulation_done),
    .mem_address_oh(mem_address_oh),
    .mem_outputh(mem_outputh),
    .degh(degh),
    .mem_address_or_decap(mem_address_orp_ed),
    .mem_outputr_decap(mem_outputrp_ed),
    .degr_decap(degrp),
    .rfd(1'd1),
    .mem_address_ic(mem_address_ic_encap),
    .mem_address_oc(mem_address_oc_encap),
    .mem_inputc(mem_inputc_encap),
    .mem_outputc(mem_outputc_encap),
    .write_enablec(write_enablec_encap),
    .degc(degc_encap),
    .CK(CK)
    );
    
    //memories
    
    Mvts MTS(      
      .index(mem_address_orp_ed),      
      .data(dataTs)    
      );
      
    Mvfill Mvect(      
      .index(indexV),      
      .data(dataV)    
      );
      
    cpoly cp_encap(
    .clk(clk),
    .write_enable(write_enablec_encap),
    .read_address(mem_address_oc_encap), 
    .write_address(mem_address_ic_encap),
    .input_data(mem_inputc_encap),
    .output_data(mem_outputc_encap)
    );
    
    r rprime(
    .clk(clk),
    .write_enable(write_enablerp),
    .read_address(mem_address_orp), 
    .write_address(mem_address_irp),
    .input_data(mem_inputrp),
    .output_data(mem_outputrp)
    );
    
    cpoly e(
    .clk(clk),
    .write_enable(write_enable_e),
    .read_address(mem_address_oe), 
    .write_address(mem_address_ie),
    .input_data(mem_inpute),
    .output_data(mem_outpute)
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