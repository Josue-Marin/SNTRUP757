`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.08.2023 17:32:19
// Design Name: 
// Module Name: EGCD_FSM
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


module EGCD_FSM(
    input clk,
    input start,
    input [0:1]sw,
    input [10:0]degA, dego,
    input [10:0]degS,
    input [12:0]mem_outputA,
    input subdone1,moddone1, divdone, multdone1,restdonemem_1, restdonemem_2,    
    input [10:0] i, k,j,
    output reg Q1, Q2, Q3, Q4, Q5,Q6, Q7, Q8,
    output reg startmod1, startdiv, startsub1,startmult1, startresetmem_1, startresetmem_2,
    output reg R1, R2, R3, R4, R5,R6, R7, R8, R9, R10, R11, R12, R13,R14, R15, R16, R17,R18, R19,R20,
    output reg egcd_done
    );
    
    parameter Inicio  = 5'b00000;
    parameter div  = 5'b00001;
    parameter mult =5'b00010;
    parameter sub =5'b00011;
    parameter mod1 =5'b00100;
    parameter mant =5'b00101;
    parameter preg1  = 5'b00110;
    parameter preg2  = 5'b00111;
    parameter preg4 = 5'b01101;
    parameter chQ = 5'b01110;
    parameter reset =5'b01000;
    parameter NIt =5'b01001;
    parameter checkA =5'b01010;
    parameter temp1=5'b01111;
    parameter preg3 =5'b01011;
    parameter as1=5'b10000;
    parameter temp2=5'b10001;
    parameter salida =5'b01100;


    reg [4:0] presente = Inicio; // Registro de Estado - Valor inicial
    reg [4:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente,start,i, k, j, dego, sw,mem_outputA, divdone,multdone1, subdone1,moddone1,degS, degA)
        case (presente)
            Inicio :
                if(start)
                    futuro <= div;            
                else
                    futuro <= Inicio;
            div:
                if(divdone)
                    futuro <= mult;
                else
                    futuro <= div;
            mult:
                if(multdone1)
                    futuro <= sub;
                else
                    futuro <= mult;
            
            sub:
                if (subdone1)
                    futuro<=mod1;
                else
                    futuro<=sub;

            mod1:
                    futuro <= mant;
            mant:
                if(moddone1)
                    futuro <= preg1;
                else
                    futuro <= mant;
            preg1:
                if(i>degS)
                    futuro <= preg4;
                else
                    futuro <= mod1;
            preg4:
                if (sw==2'b01)
                    futuro<=chQ;
                else
                    futuro<=preg2;
            chQ: 
                futuro<=preg2;
            preg2:
                if (sw==2'b11)
                    futuro<=reset;
                else
                    futuro<=NIt;

            reset:
                futuro <= checkA;
            NIt:
                futuro<=checkA;
            
            checkA:
                if (mem_outputA==0)
                    futuro<=preg3;
                else
                    futuro<=temp1;
            temp1:
                 futuro<=div;
            preg3:
                if(k>degA || degA==11'd2047)
                    futuro<=as1;
                else
                    futuro <= checkA;
            as1:
                if(j>dego)
                    futuro<=salida;
                else
                    futuro <=temp2;
            temp2:
                futuro<=as1;
            salida:
                futuro <= Inicio; 
            default:
                futuro <= Inicio;
        endcase
    
    // Lógica de salida
    always @(presente)
        case (presente)
            Inicio : begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8 <= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b1;
                R15<= 1'b0;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b0;
                R20<= 1'b0;
                Q1 <=1'b0;
                Q2 <=1'b0;
                Q3 <=1'b0;
                Q4 <=1'b0;
                Q5 <=1'b0;
                Q6 <=1'b0;
                Q7 <=1'b1;
                Q8 <=1'b0;
                startresetmem_1 <=1'b0;
                startresetmem_2 <=1'b0;
                egcd_done <= 1'b0;
                startmod1 <= 1'b0;
                startdiv <= 1'b0;
                startsub1 <= 1'b0;
                startmult1 <= 1'b0;
                 
            end                     
            div: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8 <= 1'b1;
                R9<= 1'b0;
                R10<= 1'b1;
                R13<= 1'b0;
                R14<= 1'b1;
                R15<= 1'b0;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                R20<= 1'b1;
                Q7 <=1'b0;
                Q1 <=Q1;
                Q2 <=Q2;
                Q3 <=1'b0;
                Q4 <=Q4;
                Q5 <=Q5;
                Q6 <=1'b0;
                Q8 <=1'b0;
                startresetmem_1 <=1'b0;
                startresetmem_2 <=1'b0;
                egcd_done <= 1'b0;
                startmod1 <= 1'b0;
                startdiv <= 1'b1;
                startsub1 <= 1'b0;
                startmult1 <= 1'b0;
            end
            mult: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8 <= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b0;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                R20<= 1'b1;
                Q7 <=1'b0;
                Q1 <=Q1;
                Q2 <=Q2;
                Q3 <=1'b0;
                Q4 <=Q4;
                Q5 <=Q5;
                Q6 <=1'b0;
                Q8 <=1'b0;
                startresetmem_1 <=1'b0;
                startresetmem_2 <=1'b0;
                egcd_done <= 1'b0;
                startmod1 <= 1'b0;
                startdiv <= 1'b0;
                startsub1 <= 1'b0;
                startmult1 <= 1'b1;
            end
            sub: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8 <= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b0;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                R20<= 1'b1;
                Q7 <=1'b0;
                Q1 <=Q1;
                Q2 <=Q2;
                Q3 <=1'b0;
                Q4 <=Q4;
                Q5 <=Q5;
                Q6 <=1'b1;
                Q8 <=1'b0;
                startresetmem_1 <=1'b0;
                startresetmem_2 <=1'b0;
                egcd_done <= 1'b0;
                startmod1 <= 1'b0;
                startdiv <= 1'b0;
                startsub1 <= 1'b1;
                startmult1 <= 1'b0;
            end
            mod1: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8 <= 1'b1;
                R9<= 1'b1;
                R10<= 1'b0;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                R20<= 1'b1;
                Q7 <=1'b0;
                Q1 <=Q1;
                Q2 <=Q2;
                Q3 <=1'b1;
                Q4 <=Q4;
                Q5 <=Q5;
                Q6 <=Q6;
                Q8 <=1'b0;
                startresetmem_1 <=1'b0;
                startresetmem_2 <=1'b0;
                egcd_done <= 1'b0;
                startmod1 <= 1'b1;
                startdiv <= 1'b0;
                startsub1 <= 1'b0;
                startmult1 <= 1'b0;
            end
            mant: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8 <= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b0;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                R20<= 1'b1;
                Q7 <=1'b0;
                Q1 <=Q1;
                Q2 <=Q2;
                Q3 <=1'b1;
                Q4 <=Q4;
                Q5 <=Q5;
                Q6 <=Q6;
                Q8 <=1'b0;
                startresetmem_1 <=1'b0;
                startresetmem_2 <=1'b0;
                egcd_done <= 1'b0;
                startmod1 <= 1'b0;
                startdiv <= 1'b0;
                startsub1 <= 1'b0;
                startmult1 <= 1'b0;
            end
            preg1: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8 <= 1'b1;
                R9<= 1'b0;
                R10<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                R20<= 1'b1;
                Q7 <=1'b0;
                Q1 <=Q1;
                Q2 <=Q2;
                Q3 <=1'b1;
                Q4 <=Q4;
                Q5 <=Q5;
                Q6 <=Q6;
                Q8 <=1'b0;
                startresetmem_1 <=1'b0;
                startresetmem_2 <=1'b0;
                egcd_done <= 1'b0;
                startmod1 <= 1'b0;
                startdiv <= 1'b0;
                startsub1 <= 1'b0;
                startmult1 <= 1'b0;
            end
            preg4: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8 <= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                R20<= 1'b1;
                Q7 <=1'b0;
                Q1 <=Q1;
                Q2 <=Q2;
                Q3 <=1'b1;
                Q4 <=Q4;
                Q5 <=Q5;
                Q6 <=Q6;
                Q8 <=1'b0;
                startresetmem_1 <=1'b0;
                startresetmem_2 <=1'b0;
                egcd_done <= 1'b0;
                startmod1 <= 1'b0;
                startdiv <= 1'b0;
                startsub1 <= 1'b0;
                startmult1 <= 1'b0;
            end
            chQ: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8 <= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b0;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                R20<= 1'b1;
                Q7 <=1'b0;
                Q1 <=Q1;
                Q2 <=1'b1;
                Q3 <=1'b0;
                Q4 <=1'b1;
                Q5 <=Q5;
                Q6 <=Q6;
                Q8 <=1'b0;
                startresetmem_1 <=1'b0;
                startresetmem_2 <=1'b0;
                egcd_done <= 1'b0;
                startmod1 <= 1'b0;
                startdiv <= 1'b0;
                startsub1 <= 1'b0;
                startmult1 <= 1'b0;
            end
            preg2: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8 <= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b0;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                R20<= 1'b1;
                Q7 <=1'b0;
                Q1 <=Q1;
                Q2 <=Q2;
                Q3 <=1'b0;
                Q4 <=Q4;
                Q5 <=Q5;
                Q6 <=Q6;
                Q8 <=1'b0;
                startresetmem_1 <=1'b0;
                startresetmem_2 <=1'b0;
                egcd_done <= 1'b0;
                startmod1 <= 1'b0;
                startdiv <= 1'b0;
                startsub1 <= 1'b0;
                startmult1 <= 1'b0;
            end
            reset: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b0;
                R8 <= 1'b0;
                R9<= 1'b1;
                R10<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b0;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                R20<= 1'b1;
                Q7 <=1'b0;
                Q1 <=Q1;
                Q2 <=Q2;
                Q3 <=1'b1;
                Q4 <=Q4;
                Q5 <=Q5;
                Q6 <=Q6;
                Q8 <=1'b0;
                startresetmem_1 <=1'b0;
                startresetmem_2 <=1'b0;
                egcd_done <= 1'b0;
                startmod1 <= 1'b0;
                startdiv <= 1'b0;
                startsub1 <= 1'b0;
                startmult1 <= 1'b0;
            end
            NIt: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b0;
                R8 <= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b0;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                R20<= 1'b1;
                Q7 <=1'b0;
                Q1 <=1'b1;
                Q2 <=Q2;
                Q3 <=1'b1;
                Q4 <=Q4;
                Q5 <=1'b1;
                Q6 <=Q6;
                Q8 <=1'b0;
                startresetmem_1 <=1'b1;
                startresetmem_2 <=1'b1;
                egcd_done <= 1'b0;
                startmod1 <= 1'b0;
                startdiv <= 1'b0;
                startsub1 <= 1'b0;
                startmult1 <= 1'b0;
            end
            checkA: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8 <= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R13<= 1'b0;
                R14<= 1'b1;
                R15<= 1'b0;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                R20<= 1'b1;
                Q7 <=1'b0;
                Q1 <=Q1;
                Q2 <=Q2;
                Q3 <=1'b1;
                Q4 <=Q4;
                Q5 <=Q5;
                Q6 <=Q6;
                Q8 <=1'b0;
                startresetmem_1 <=1'b1;
                startresetmem_2 <=1'b1;
                egcd_done <= 1'b0;
                startmod1 <= 1'b0;
                startdiv <= 1'b0;
                startsub1 <= 1'b0;
                startmult1 <= 1'b0;
            end
            temp1: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8 <= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b0;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                R20<= 1'b1;
                Q7 <=1'b0;
                Q1 <=Q1;
                Q2 <=Q2;
                Q3 <=1'b1;
                Q4 <=Q4;
                Q5 <=Q5;
                Q6 <=Q6;
                Q8 <=1'b0;
                startresetmem_1 <=1'b0;
                startresetmem_2 <=1'b0;
                egcd_done <= 1'b0;
                startmod1 <= 1'b0;
                startdiv <= 1'b0;
                startsub1 <= 1'b0;
                startmult1 <= 1'b0;
            end
            preg3: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8 <= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R13<= 1'b0;
                R14<= 1'b1;
                R15<= 1'b0;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                R20<= 1'b1;
                Q7 <=1'b1;
                Q1 <=Q1;
                Q2 <=Q2;
                Q3 <=1'b1;
                Q4 <=Q4;
                Q5 <=Q5;
                Q6 <=Q6;
                Q8 <=1'b0;
                startresetmem_1 <=1'b0;
                startresetmem_2 <=1'b0;
                egcd_done <= 1'b0;
                startmod1 <= 1'b0;
                startdiv <= 1'b0;
                startsub1 <= 1'b0;
                startmult1 <= 1'b0;
            end
            as1: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8 <= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b0;
                R16<= 1'b1;
                R17<= 1'b0;
                R18<= 1'b0;
                R19<= 1'b0;
                R20<= 1'b1;
                Q7 <=1'b0;
                Q1 <=Q1;
                Q2 <=Q2;
                Q3 <=1'b1;
                Q4 <=Q4;
                Q5 <=Q5;
                Q6 <=Q6;
                Q8 <=1'b1;
                startresetmem_1 <=1'b0;
                startresetmem_2 <=1'b0;
                egcd_done <= 1'b0;
                startmod1 <= 1'b0;
                startdiv <= 1'b0;
                startsub1 <= 1'b0;
                startmult1 <= 1'b0;
            end
            temp2: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8 <= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b0;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                R20<= 1'b1;
                Q7 <=1'b1;
                Q1 <=Q1;
                Q2 <=Q2;
                Q3 <=1'b1;
                Q4 <=Q4;
                Q5 <=Q5;
                Q6 <=Q6;
                Q8 <=1'b0;
                startresetmem_1 <=1'b0;
                startresetmem_2 <=1'b0;
                egcd_done <= 1'b0;
                startmod1 <= 1'b0;
                startdiv <= 1'b0;
                startsub1 <= 1'b0;
                startmult1 <= 1'b0;
            end
            salida: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8 <= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b0;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                R20<= 1'b1;
                Q7 <=1'b1;
                Q1 <=Q1;
                Q2 <=Q2;
                Q3 <=1'b1;
                Q4 <=Q4;
                Q5 <=Q5;
                Q6 <=Q6;
                Q8 <=Q8;
                startresetmem_1 <=1'b0;
                startresetmem_2 <=1'b0;
                egcd_done <= 1'b1;
                startmod1 <= 1'b0;
                startdiv <= 1'b0;
                startsub1 <= 1'b0;
                startmult1 <= 1'b0;
            end
            default: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8 <= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b1;
                R15<= 1'b0;
                Q1 <=1'b0;
                Q2 <=1'b0;
                Q3 <=1'b0;
                Q4 <=1'b0;
                Q5 <=1'b0;
                Q6 <=1'b0;
                Q8 <=1'b0;
                startresetmem_1 <=1'b0;
                startresetmem_2 <=1'b0;
                egcd_done <= 1'b0;
                startmod1 <= 1'b0;
                startdiv <= 1'b0;
                startsub1 <= 1'b0;
                startmult1 <= 1'b0;
            end
      endcase

endmodule
