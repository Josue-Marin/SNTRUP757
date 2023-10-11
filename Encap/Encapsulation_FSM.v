`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.09.2023 02:43:59
// Design Name: 
// Module Name: Encapsulation_FSM
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


module Encapsulation_FSM(
    input clk, start,
    input dd, rfd,
    input [10:0]i, deg, j,
    input moddone1, rounddone1, hash_done, mult_done, divdone,
    output reg write_enable, startmod1,write_enablemDP, startdiv, starthash, startmult, starttspoly, startround1,
    output reg Q1, Q2, Q3, Q4, Q5, R1, R2, R3, R4, R5, R6, R7,R8,R9,R10,R11, R12,
    output reg Encapsulation_done
    );
    
    parameter Inicio  = 5'b00000;
    parameter rfdecapq= 5'b10000;
    parameter Polygen = 5'b00001;
    parameter multI=5'b00010;
    parameter As1=5'b00011;
    parameter As2= 5'b00100;
    parameter cI=5'b00101;
    parameter temp1 = 5'b00110;
    parameter mod1=5'b00111;
    parameter mant=5'b01000;
    parameter pregM=5'b01001;
    parameter tempR = 5'b01010;
    parameter round1=5'b01011;
    parameter mantR=5'b01100;
    parameter pregR=5'b01101; 
    parameter hashI=5'b01110;
    parameter salida =5'b01111;


    reg [5:0] presente = Inicio; // Registro de Estado - Valor inicial
    reg [5:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente,  deg, i, j, rfd, moddone1, dd, mult_done, divdone, hash_done, rounddone1, start)
        case (presente)
            Inicio:
                if(start)
                    futuro <= Polygen;            
                else
                    futuro <= Inicio;
            rfdecapq:
                if(rfd)
                    futuro <= multI;            
                else
                    futuro <= Polygen;        
            Polygen:
                if(dd)
                    futuro <= multI;            
                else
                    futuro <= Polygen;
            multI:
                  if(mult_done)
                    futuro <= As1;            
                else
                    futuro <= multI;
            As1:
                futuro <= As2;
            As2:
                futuro <= cI;
            cI:
                if(divdone)
                    futuro <= temp1;
                else
                    futuro <= cI;
            temp1:
                futuro <= mod1;
            mod1:
                    futuro <= mant;
            mant:
                if(moddone1)
                    futuro <= pregM;
                else
                    futuro <= mant;
            pregM:
                if((i-1)>deg)
                    futuro <= tempR;
                else
                    futuro <= mod1;
            tempR:
                futuro <= round1;
            round1:
                    futuro <= mantR;
            mantR:
                if(rounddone1)
                    futuro <= pregR;
                else
                    futuro <= mantR;
            pregR:
                if((j-1)>deg)
                    futuro <= hashI;
                else
                    futuro <= round1;
            hashI:
                if(hash_done)
                    futuro <= salida;
                else
                    futuro <= hashI;             
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
                R8<= 1'b0;
                R9 <=1'b0;
                R10 <=1'b0;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b0;
                Q4<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                startround1 <= 1'b0;
                starttspoly<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                starthash <= 1'b0;
                write_enablemDP<=1'b0;                
                Encapsulation_done <= 1'b0;
            end
            Polygen : begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b0;
                Q4<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                startround1 <= 1'b0;
                starttspoly<=1'b1;
                startmult<=1'b0;
                startdiv <= 1'b0;
                starthash <= 1'b0;
                write_enablemDP<=1'b0;                
                Encapsulation_done <= 1'b0;
            end
            multI: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b0;
                Q3<=1'b0;
                Q4<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                startround1 <= 1'b0;
                starttspoly<=1'b0;
                startmult<=1'b1;
                startdiv <= 1'b0;
                starthash <= 1'b0;
                write_enablemDP<=1'b0;                
                Encapsulation_done <= 1'b0;
            end
            As1: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                startround1 <= 1'b0;
                starttspoly<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                starthash <= 1'b0;
                write_enablemDP<=1'b1;                
                Encapsulation_done <= 1'b0;
            end
            As2: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                startround1 <= 1'b0;
                starttspoly<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                starthash <= 1'b0;
                write_enablemDP<=1'b1;                
                Encapsulation_done <= 1'b0;
            end                 
            cI: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b0;
                Q4<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                startround1 <= 1'b0;
                starttspoly<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b1;
                starthash <= 1'b0;
                write_enablemDP<=1'b0;                
                Encapsulation_done <= 1'b0;
            end
            temp1: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                startround1 <= 1'b0;
                starttspoly<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                starthash <= 1'b0;
                write_enablemDP<=1'b0;                
                Encapsulation_done <= 1'b0;
            end
            mod1: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b0;
                R3<= 1'b0;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b0;
                write_enable<=1'b1;
                startmod1 <= 1'b1;
                startround1 <= 1'b0;
                starttspoly<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                starthash <= 1'b0;
                write_enablemDP<=1'b0;                
                Encapsulation_done <= 1'b0;
            end
            mant: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b0;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                startround1 <= 1'b0;
                starttspoly<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                starthash <= 1'b0;
                write_enablemDP<=1'b0;                
                Encapsulation_done <= 1'b0;
            end
            pregM: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b0;
                R4<= 1'b1;
                R3<= 1'b0;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b0;
                write_enable<=1'b1;
                startmod1 <= 1'b0;
                startround1 <= 1'b0;
                starttspoly<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                starthash <= 1'b0;
                write_enablemDP<=1'b0;                
                Encapsulation_done <= 1'b0;
            end
            tempR: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b1;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                startround1 <= 1'b0;
                starttspoly<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                starthash <= 1'b0;
                write_enablemDP<=1'b0;                
                Encapsulation_done <= 1'b0;
            end
            round1: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b0;
                R3<= 1'b0;
                R8<= 1'b1;
                R9 <=1'b0;
                R10 <=1'b1;
                R11 <=1'b1;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b0;
                write_enable<=1'b1;
                startmod1 <= 1'b0;
                startround1 <= 1'b1;
                starttspoly<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                starthash <= 1'b0;
                write_enablemDP<=1'b0;                
                Encapsulation_done <= 1'b0;
            end
            mantR: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                startround1 <= 1'b0;
                starttspoly<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                starthash <= 1'b0;
                write_enablemDP<=1'b0;                
                Encapsulation_done <= 1'b0;
            end
            pregR: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b0;
                R4<= 1'b1;
                R3<= 1'b0;
                R8<= 1'b1;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b1;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b0;
                write_enable<=1'b1;
                startmod1 <= 1'b0;
                startround1 <= 1'b0;
                starttspoly<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                starthash <= 1'b0;
                write_enablemDP<=1'b0;                
                Encapsulation_done <= 1'b0;
            end
            hashI: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b1;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                startround1 <= 1'b0;
                starttspoly<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                starthash <= 1'b1;
                write_enablemDP<=1'b0;                
                Encapsulation_done <= 1'b0;
            end
            salida: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b1;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                startround1 <= 1'b0;
                starttspoly<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                starthash <= 1'b0;
                write_enablemDP<=1'b0;                
                Encapsulation_done <= 1'b1;
            end
            
            default: begin 
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b0;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b0;
                Q4<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                startround1 <= 1'b0;
                starttspoly<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                starthash <= 1'b0;
                write_enablemDP<=1'b0;                
                Encapsulation_done <= 1'b0;
            end
      endcase
endmodule
