`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.09.2023 11:39:42
// Design Name: 
// Module Name: KeyGen_FSM
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


module KeyGen_FSM(
    input clk, start,
    input dd,
    input [10:0]i, degR,
    input moddone1,write_dones, mult_done, divdone, EGCD_done3f, EGCD_doneg, normf, normg,
    output reg startnormf, startnormg,write_enable, startmod1,write_enablemultDP, startdiv, startEGCD3f, startEGCDg, startmult, starttspoly, startspoly,
    output reg Q1, Q2, Q3, Q4, Q5, Q6, R1, R2, R3, R4, R5, R6, R7,
    output reg KeyGen_done
    );
    
    parameter Inicio  = 4'b0000;
    parameter Polygen = 4'b0001;
    parameter egcdstart= 4'b1000;
    parameter egcdtemp1= 4'b1001;
    parameter NormalizeI=4'b1111;
    parameter Normalize= 4'b1110;
    
//    parameter egcdtemp2= 4'b1010;
    parameter egcdI=4'b0010;
    parameter multI=4'b0011;
    parameter As1=4'b0100;
    parameter As2  = 4'b0101;
    parameter hI=4'b0110;
    parameter temp1 = 4'b1010;
    parameter mod1=4'b1011;
    parameter mant=4'b1100;
    parameter preg1=4'b1101;
    parameter salida = 4'b0111;


    reg [3:0] presente = Inicio; // Registro de Estado - Valor inicial
    reg [3:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente,  degR, i,normf, normg, moddone1, dd, write_dones, mult_done, divdone, EGCD_done3f, EGCD_doneg, start)
        case (presente)
            Inicio:
                if(start)
                    futuro <= Polygen;            
                else
                    futuro <= Inicio;
        
            Polygen:
                if(dd)
                    futuro <= egcdstart;            
                else
                    futuro <= Polygen;
            egcdstart:
                futuro <= egcdtemp1;
            egcdtemp1:
                futuro <= egcdI;            
//            egcdstart:
//                futuro <= egcdI;
            egcdI:
                if(EGCD_done3f)
                    futuro <= NormalizeI;            
                else
                    futuro <= egcdI;
            NormalizeI:
                futuro <= Normalize; 
            Normalize:
                if(normf)
                    futuro <= multI;            
                else
                    futuro <= Normalize;
            multI:
                  if(mult_done)
                    futuro <= As1;            
                else
                    futuro <= multI;
            As1:
                futuro <= As2;
            As2:
                futuro <= hI;
            hI:
                if(divdone)
                    futuro <= temp1;
                else
                    futuro <= hI;
            temp1:
                futuro <= mod1;
            mod1:
                    futuro <= mant;
            mant:
                if(moddone1)
                    futuro <= preg1;
                else
                    futuro <= mant;
            preg1:
                if((i-1)>degR)
                    futuro <= salida;
                else
                    futuro <= mod1;
            salida:
                futuro <= Inicio;
            default:
                futuro <= Inicio;
        endcase
    
    // Lógica de salida
    always @(presente)
        case (presente)
            Inicio : begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b0;
                Q4<=1'b0;
                Q5<=1'b0;
                Q6<=1'b0;
                startnormf<=1'b0;
                startnormg<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                starttspoly<=1'b0;
                startspoly<=1'b0;
                startEGCD3f<=1'b0;
                startEGCDg<=1'b0;
                startmult<=1'b0;
                write_enablemultDP<=1'b0; 
                startdiv <= 1'b0;
                KeyGen_done <= 1'b0;
            end
            Polygen : begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b0;
                Q4<=1'b0;
                Q5<=1'b0;
                Q6<=1'b0;
                startnormf<=1'b0;
                startnormg<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                starttspoly<=1'b1;
                startspoly<=1'b1;
                startEGCD3f<=1'b0;
                startEGCDg<=1'b0;
                startmult<=1'b0;
                write_enablemultDP<=1'b0; 
                startdiv <= 1'b0;
                KeyGen_done <= 1'b0;
            end
            egcdtemp1: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                startmod1 <= 1'b0;
                Q1<=1'b1;
                Q2<=1'b0;
                Q3<=1'b0;
                Q4<=1'b0;
                Q5<=1'b0;
                Q6<=1'b0;
                startnormf<=1'b0;
                startnormg<=1'b0;
                write_enable<=1'b0;
                starttspoly<=1'b0;
                startspoly<=1'b0;
                startEGCD3f<=1'b0;
                startEGCDg<=1'b0;
                startmult<=1'b0;
                write_enablemultDP<=1'b0; 
                startdiv <= 1'b0;
                KeyGen_done <= 1'b0;
            end
            egcdstart: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                startmod1 <= 1'b0;
                Q1<=1'b1;
                Q2<=1'b0;
                Q3<=1'b0;
                Q4<=1'b0;
                Q5<=1'b0;
                Q6<=1'b0;
                startnormf<=1'b0;
                startnormg<=1'b0;
                write_enable<=1'b0;
                starttspoly<=1'b0;
                startspoly<=1'b0;
                startEGCD3f<=1'b1;
                startEGCDg<=1'b1;
                startmult<=1'b0;
                write_enablemultDP<=1'b0; 
                startdiv <= 1'b0;
                KeyGen_done <= 1'b0;
            end
            egcdI: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                startmod1 <= 1'b0;
                Q1<=1'b1;
                Q2<=1'b0;
                Q3<=1'b0;
                Q4<=1'b0;
                Q5<=1'b1;
                Q6<=1'b0;
                startnormf<=1'b0;
                startnormg<=1'b0;
                write_enable<=1'b0;
                starttspoly<=1'b0;
                startspoly<=1'b0;
                startEGCD3f<=1'b0;
                startEGCDg<=1'b0;
                startmult<=1'b0;
                write_enablemultDP<=1'b0; 
                startdiv <= 1'b0;
                KeyGen_done <= 1'b0;
            end
            NormalizeI: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                startmod1 <= 1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b0;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b1;
                write_enable<=1'b0;
                startnormf<=1'b1;
                startnormg<=1'b1;
                starttspoly<=1'b0;
                startspoly<=1'b0;
                startEGCD3f<=1'b0;
                startEGCDg<=1'b0;
                startmult<=1'b0;
                write_enablemultDP<=1'b0; 
                startdiv <= 1'b0;
                KeyGen_done <= 1'b0;
            end
            Normalize: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                startmod1 <= 1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b0;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b1;
                write_enable<=1'b0;
                startnormf<=1'b0;
                startnormg<=1'b0;
                starttspoly<=1'b0;
                startspoly<=1'b0;
                startEGCD3f<=1'b0;
                startEGCDg<=1'b0;
                startmult<=1'b0;
                write_enablemultDP<=1'b0; 
                startdiv <= 1'b0;
                KeyGen_done <= 1'b0;
            end
            
            multI: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                Q6<=1'b0;
                startnormf<=1'b0;
                startnormg<=1'b0;
                startmod1 <= 1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b0;
                Q4<=1'b1;
                Q5<=1'b1;
                write_enable<=1'b0;
                starttspoly<=1'b0;
                startspoly<=1'b0;
                startEGCD3f<=1'b0;
                startEGCDg<=1'b0;
                startmult<=1'b1;
                write_enablemultDP<=1'b0; 
                startdiv <= 1'b0;
                KeyGen_done <= 1'b0;
            end
            As1: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                startmod1 <= 1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b0;
                Q5<=1'b1;
                Q6<=1'b0;
                startnormf<=1'b0;
                startnormg<=1'b0;
                write_enable<=1'b0;
                starttspoly<=1'b0;
                startspoly<=1'b0;
                startEGCD3f<=1'b0;
                startEGCDg<=1'b0;
                startmult<=1'b0;
                write_enablemultDP<=1'b1; 
                startdiv <= 1'b0;
                KeyGen_done <= 1'b0;
            end
            As2: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                startmod1 <= 1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b0;
                Q5<=1'b1;
                Q6<=1'b0;
                startnormf<=1'b0;
                startnormg<=1'b0;
                write_enable<=1'b0;
                starttspoly<=1'b0;
                startspoly<=1'b0;
                startEGCD3f<=1'b0;
                startEGCDg<=1'b0;
                startmult<=1'b0;
                write_enablemultDP<=1'b1; 
                startdiv <= 1'b0;
                KeyGen_done <= 1'b0;
            end                 
            hI: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                startmod1 <= 1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b0;
                startnormf<=1'b0;
                startnormg<=1'b0;
                write_enable<=1'b0;
                starttspoly<=1'b0;
                startspoly<=1'b0;
                startEGCD3f<=1'b0;
                startEGCDg<=1'b0;
                startmult<=1'b0;
                write_enablemultDP<=1'b0; 
                startdiv <= 1'b1;
                KeyGen_done <= 1'b0;
            end
            temp1: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                startmod1 <= 1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b0;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b0;
                startnormf<=1'b0;
                startnormg<=1'b0;
                write_enable<=1'b0;
                starttspoly<=1'b0;
                startspoly<=1'b0;
                startEGCD3f<=1'b0;
                startEGCDg<=1'b0;
                startmult<=1'b0;
                write_enablemultDP<=1'b0; 
                startdiv <= 1'b0;
                KeyGen_done <= 1'b0;
            end
            mod1: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b0;
                R3<= 1'b0;
                startmod1 <= 1'b1;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b0;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b0;
                startnormf<=1'b0;
                startnormg<=1'b0;
                write_enable<=1'b1;
                starttspoly<=1'b0;
                startspoly<=1'b0;
                startEGCD3f<=1'b0;
                startEGCDg<=1'b0;
                startmult<=1'b0;
                write_enablemultDP<=1'b0; 
                startdiv <= 1'b0;
                KeyGen_done <= 1'b0;
            end
            mant: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b0;
                startmod1 <= 1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b0;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b0;
                startnormf<=1'b0;
                startnormg<=1'b0;
                write_enable<=1'b0;
                starttspoly<=1'b0;
                startspoly<=1'b0;
                startEGCD3f<=1'b0;
                startEGCDg<=1'b0;
                startmult<=1'b0;
                write_enablemultDP<=1'b0; 
                startdiv <= 1'b0;
                KeyGen_done <= 1'b0;
            end
            preg1: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b0;
                R4<= 1'b1;
                R3<= 1'b0;
                startmod1 <= 1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b0;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b0;
                startnormf<=1'b0;
                startnormg<=1'b0;
                write_enable<=1'b1;
                starttspoly<=1'b0;
                startspoly<=1'b0;
                startEGCD3f<=1'b0;
                startEGCDg<=1'b0;
                startmult<=1'b0;
                write_enablemultDP<=1'b0; 
                startdiv <= 1'b0;
                KeyGen_done <= 1'b0;
            end
            
            salida: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                startmod1 <= 1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b0;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b0;
                startnormf<=1'b0;
                startnormg<=1'b0;
                write_enable<=1'b0;
                starttspoly<=1'b0;
                startspoly<=1'b0;
                startEGCD3f<=1'b0;
                startEGCDg<=1'b0;
                startmult<=1'b0;
                write_enablemultDP<=1'b0; 
                startdiv <= 1'b0;
                KeyGen_done <= 1'b1;
            end
            default: begin 
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b0;
                Q4<=1'b0;
                Q5<=1'b0;
                Q6<=1'b0;
                startnormf<=1'b0;
                startnormg<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                starttspoly<=1'b0;
                startspoly<=1'b0;
                startEGCD3f<=1'b0;
                startEGCDg<=1'b0;
                startmult<=1'b0;
                write_enablemultDP<=1'b0; 
                startdiv <= 1'b0;
                KeyGen_done <= 1'b0;
            end
      endcase

endmodule
