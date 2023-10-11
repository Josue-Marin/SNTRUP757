`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.05.2023 10:36:13
// Design Name: 
// Module Name: Multpoly_FSM
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


module Multpoly_FSM(
    input clk,
    input start,
    input write_enable,
    input [9:0] i, j,
    input [10:0] k, dega, degb,
    input [25:0]mem_output, 
    output reg R1, R2, R3, R4, R5,R6, R7, R8, R9, R10, R11, R12, R13,R14, R15,R16,
    output reg mult_done
    );
    
    parameter Inicio  = 4'b0000;
    parameter Inicio2  = 4'b0001;
    parameter preg1=4'b1101;
    parameter as1=4'b1110;
    parameter temp5=4'b1111;
    parameter Op1 =4'b0010;
    parameter A1 =4'b0011;
    parameter temp1 =4'b0111;
    parameter mult =4'b0100;
    parameter temp2 =4'b1000;
    parameter temp3=4'b1001;
    parameter deg1=4'b1011;
    parameter deg2=4'b1100;
    parameter A2 =4'b0101;
    parameter temp4 =4'b1010;
    parameter salida =4'b0110;


    reg [3:0] presente = Inicio; // Registro de Estado - Valor inicial
    reg [3:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente,start,i, j, k,write_enable, mem_output,dega,degb)
        case (presente)
            Inicio :
                if(start)
                    futuro <= Inicio2;            
                else
                    futuro <= Inicio;
            Inicio2:
                if(write_enable)
                    futuro <= Op1;            
                else
                    futuro <= Inicio2;
            Op1:
                if(k<dega+degb)
                    futuro <= Op1;
                else
                    futuro <= A1;            
            A1:
                futuro<=temp1;
            
            temp1:
                futuro<=mult;
                
            mult:
                if (j<degb)
                      futuro<=temp3;
                else
                    futuro<=A2;

            temp3:
                futuro<=mult;
            
            A2:
                if(i<dega)
                    futuro<=temp4;
                else
                    futuro <= deg1;
            temp4:
                futuro<=temp2;
            temp2:
                futuro<=mult;
            deg1:
                 if(mem_output!=0)
                    futuro<=deg2;
                else
                    futuro <= deg1;
            deg2:
                futuro <= salida;
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
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b0;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b0;
                mult_done <= 1'b0; 
            end
            Inicio2 : begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b0;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b0;
                mult_done <= 1'b0;
            end                     
            Op1: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8<= 1'b0;
                R9<= 1'b1;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b1;
                R13<= 1'b0;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b0;
                mult_done <= 1'b0;
            end
            A1: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8<= 1'b1;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b1;
                R13<= 1'b0;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b0;
                mult_done <= 1'b0;
            end
            temp1: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8<= 1'b1;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b1;
                R13<= 1'b0;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b0;
                mult_done <= 1'b0;
            end
            mult: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b1;
                R11<= 1'b1;
                R12<= 1'b0;
                R13<= 1'b1;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b0;
                mult_done <= 1'b0;
            end

            temp3: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b0;
                mult_done <= 1'b0;
            end
            deg1: begin
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
                R12<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b1;
                mult_done <= 1'b0;
            end
            deg2: begin
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
                R12<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b0;
                R16<= 1'b0;
                mult_done <= 1'b0;
            end
            A2: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
                mult_done <= 1'b0;
            end
            temp4: begin
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
                R12<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
                mult_done <= 1'b0;
            end
            temp2: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b1;
                R11<= 1'b1;
                R12<= 1'b1;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
                mult_done <= 1'b0;
            end
            salida: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b0;
                R15<= 1'b1;
                mult_done <= 1'b1;
            end
            default: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b0;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b1;
                R15<= 1'b1;
                mult_done <= 1'b0; 
            end
      endcase
      
endmodule
