`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.08.2023 11:22:16
// Design Name: 
// Module Name: subpolydiv_FSM
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


module subpolydiv_FSM(
    input clk,
    input start, f,
    input [12:0]mem_inputS,
    input [10:0] i,  degN,
    input  [10:0] j,
    output reg R1, R2, R3, R4, R5,R6, R7, R8, R9, R10, R11, R12, R13, R14, R15,
    output reg sub_done
    );
    
    parameter Inicio  = 4'b0000;
    parameter sub  = 4'b0001;
    parameter temp2= 4'b1000;
    parameter deg =4'b0010;
    parameter preg =4'b0011;
    parameter comp =4'b0100;
    parameter preg2 =4'b0110;
    parameter temp1= 4'b0111;
    parameter temp3= 4'b1011;
    parameter checkf= 4'b1001;
    parameter changef=4'b1010;
    parameter salida =4'b0101;


    reg [3:0] presente = Inicio; // Registro de Estado - Valor inicial
    reg [3:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente,start,i, j, f, degN, mem_inputS)
        case (presente)
            Inicio :
                if(start)
                    futuro <= sub;            
                else
                    futuro <= Inicio;
            sub:
                futuro <= temp2;
            preg2:
                if(mem_inputS!=0 && f==0)
                    futuro<=deg;
                else
                    futuro <= temp3;
            preg:
                if (j==2047)
                    futuro<=comp;
                else
                    futuro<=sub;
            temp2:
                 futuro <= preg2;
            deg:
                futuro<=temp3;
 
            comp:
                 if (i==2047)
                    futuro<=checkf;
                else
                    futuro<=temp1;
            temp1:
                futuro<=preg2;
            temp3:
                 if (j==2047)
                    futuro<=comp;
                else
                    futuro<=preg;
            checkf:
                if (f==1)
                    futuro<=salida;
                else
                    futuro<=changef;  
            changef:
                futuro<=salida;                    
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
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b0;
                R15<= 1'b1;
                sub_done <= 1'b0; 
            end                     
            sub: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8<= 1'b1;
                R9<= 1'b1;
                R10<= 1'b0;
                R11<= 1'b1;
                R12<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
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
                R12<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
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
                R12<= 1'b0;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
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
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R12<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
                sub_done <= 1'b0;
            end
            comp: begin
                R1 <= 1'b1;
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
                R12<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
                sub_done <= 1'b0;
            end
            temp1: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8<= 1'b1;
                R9<= 1'b0;
                R10<= 1'b1;
                R11<= 1'b1;
                R12<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
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
                R12<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
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
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R12<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
                sub_done <= 1'b0;
            end
            checkf:begin
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
                R12<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
                sub_done <= 1'b1;
            end
            changef:begin
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
                R12<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b0;
                sub_done <= 1'b1;
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
                R12<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
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
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R12<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
                sub_done <= 1'b0;
            end
      endcase
endmodule
