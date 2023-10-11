`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2023 16:09:25
// Design Name: 
// Module Name: Subpoly_FSM
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


module Subpoly_FSM(
    input clk,
    input start,
    input [25:0]mem_inputS, mem_outputS,
    input [10:0] i,  degN, degD, degch,
    input  [10:0] j,
    output reg t,s,
    output reg R1, R2, R3, R4, R5,R6, R7, R8, R9, R10, R11, R14, R15, R16, R17,R18, R19,R20,R21,R22,
    output reg sub_done
    );
    
    parameter Inicio  = 5'b00000;
    parameter preg1=5'b01001;
    parameter preg4=5'b01010;
    parameter M2=5'b01011; 
    parameter M3=5'b01100;
    parameter sub  = 5'b00001;
    parameter temp2= 5'b01000;
    parameter preg3=5'b01101;    
    parameter grad=5'b01111; 
    parameter grad1=5'b10000;
    parameter preg5=5'b10001;
    parameter compD=5'b10010;
    parameter preg6=5'b10011;
    parameter temp3=5'b10100;
    parameter deg =5'b00010;
    parameter preg =5'b00011;
    parameter comp =5'b00100;
    parameter preg2 =5'b00110;
    parameter temp1= 5'b00111;
    parameter salida =5'b00101;


    reg [4:0] presente = Inicio; // Registro de Estado - Valor inicial
    reg [4:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente,start,i, j, degN, degD, mem_inputS,mem_outputS, t, degch)
        case (presente)
            Inicio :
                if(start)
                    futuro <= preg1;            
                else
                    futuro <= Inicio;
                                   
            preg1:
                if(degN>degD)
                    futuro <= sub;
                else
                    futuro <= preg4;
            preg4:
                if(degN==degD)
                    futuro <= M2;
                else
                    futuro <= M3;
            M2:
                 futuro <= sub;
            M3:
                 futuro <= sub;
            sub:
                if(j==2047)
                    futuro <= preg3;
                else
                    futuro <= temp2;
            temp2:
                 futuro <= sub;
            
            deg:
                futuro<=preg;
            preg3:
                if(t==0)
                    futuro <= preg5;
                else
                    futuro <= grad;
//            A5:
//                 futuro <= grad;
            grad:
                if(mem_outputS!=0)
                    futuro <= grad1;
                else
                    futuro <= grad;
            grad1:
                 futuro <= salida;
            preg5:     
                 if (s==0)
                    futuro<=comp;
                else
                    futuro<=compD;
            compD:
                futuro<=temp3;
            temp3:
                 futuro<=preg2;
            preg6:
                if (s==0)
                    futuro<=comp;
                else
                    futuro<=compD; 
            preg:
                if (i>degch)
                    futuro<=salida;
                else
                    futuro<=preg6;
            comp: 
                futuro<=temp1;
            temp1:
                futuro<=preg2;                
            preg2:
                if(mem_inputS!=0)
                    futuro<=deg;
                else
                    futuro <= preg;
                                
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
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b1;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b0;
                R17<= 1'b0;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= 1'b0;
                R20<= 1'b0;
                R21<= 1'b0;
                R22<= 1'b1;
                s<=1'b0;
                sub_done <= 1'b0; 
            end
            preg1: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= t;
                s<=s;
                R20<= 1'b1;
                R21<= 1'b1;
                R22<= 1'b1;
                sub_done <= 1'b0;
            end
            preg2: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= t;
                s<=s;
                R20<= 1'b1;
                R21<= 1'b1;
                R22<= 1'b1;
                sub_done <= 1'b0;
            end
            M2: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= 1'b1;
                s<=s;
                R20<= 1'b0;
                R21<= 1'b1;
                R22<= 1'b1;
                sub_done <= 1'b0;
            end
            M3: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b0;
                t<= t;
                s<=1'b1;
                R20<= 1'b0;
                R21 <= 1'b0;
                R22<= 1'b1;
                sub_done <= 1'b0;
            end                     
            sub: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8<= 1'b1;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b0;
                R17<= 1'b0;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= t;
                s<=s;
                R20<= 1'b1;
                R21<= 1'b1;
                R22<= 1'b1;
                sub_done <= 1'b0;
            end
            temp2: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8<= 1'b1;
                R9<= 1'b1;
                R10<= 1'b0;
                R11<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= t;
                s<=s;
                R20<= 1'b1;
                R21<= 1'b1;
                R22<= 1'b1;
                sub_done <= 1'b0;
            end
            preg3: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= t;
                s<=s;
                R20<= 1'b1;
                R21<= 1'b1;
                R22<= 1'b1;
                sub_done <= 1'b0;
            end
//            A5: begin
//                R1 <= 1'b1;
//                R2 <= 1'b1;
//                R3 <= 1'b1;
//                R4 <= 1'b1;
//                R5 <= 1'b1;
//                R6 <= 1'b1;
//                R7 <= 1'b1;
//                R8<= 1'b0;
//                R9<= 1'b0;
//                R10<= 1'b0;
//                R11<= 1'b1;
//                R14<= 1'b0;
//                R15<= 1'b1;
//                R16<= 1'b1;
//                R17<= 1'b1;
//                sub_done <= 1'b1;
//            end
            grad: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b0;
                R19<= 1'b1;
                t<= t;
                s<=s;
                R20<= 1'b1;
                R21<= 1'b1;
                R22<= 1'b1;
                sub_done <= 1'b0;
            end
            grad1: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= t;
                s<=s;
                R20<= 1'b1;
                R21<= 1'b1;
                R22<= 1'b0;
                sub_done <= 1'b0;
            end
            preg5: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= t;
                s<=s;
                R20<= 1'b0;
                R21<= 1'b1;
                R22<= 1'b1;
                sub_done <= 1'b0;
            end
            compD: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b0;
                R8<= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R11<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= t;
                s<=s;
                R20<= 1'b0;
                R21<= 1'b1;
                R22<= 1'b1;
                sub_done <= 1'b0;
            end
            temp3: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8<= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R11<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= t;
                s<=s;
                R20<= 1'b1;
                R21<= 1'b1;
                R22<= 1'b1;
                sub_done <= 1'b0;
            end
            preg6: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= t;
                s<=s;
                R20<= 1'b1;
                R21<= 1'b1;
                R22<= 1'b1;
                sub_done <= 1'b0;
            end
            
            deg: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= t;
                s<=s;
                R20<= 1'b1;
                R21<= 1'b1;
                R22<= 1'b0;
                sub_done <= 1'b0;
            end
            preg: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8<= 1'b1;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= t;
                s<=s;
                R20<= 1'b1;
                R21<= 1'b1;
                R22<= 1'b1;
                sub_done <= 1'b0;
            end
            comp: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b0;
                R8<= 1'b1;
                R9<= 1'b0;
                R10<= 1'b1;
                R11<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= t;
                s<=s;
                R20<= 1'b0;
                R21<= 1'b1;
                R22<= 1'b1;
                sub_done <= 1'b0;
            end
            temp1: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8<= 1'b1;
                R9<= 1'b0;
                R10<= 1'b1;
                R11<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= t;
                s<=s;
                R20<= 1'b0;
                R21<= 1'b1;
                R22<= 1'b1;
                sub_done <= 1'b0;
            end
            preg2: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8<= 1'b1;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= t;
                s<=s;
                R20<= 1'b0;
                R21<= 1'b1;
                R22<= 1'b1;
                sub_done <= 1'b0;
            end
            salida: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= t;
                s<=s;
                R20<= 1'b0;
                R21<= 1'b1;
                R22<= 1'b1;
                sub_done <= 1'b1;
            end
            default: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b1;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8<= 1'b1;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b0;
                R17<= 1'b0;
                R18<= 1'b1;
                R19<= 1'b1;
                t<= 1'b0;
                s<=s;
                R20<= 1'b0;
                R21<= 1'b0;
                R22<= 1'b1;
                sub_done <= 1'b0;
            end
      endcase

endmodule
