`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2023 19:31:57
// Design Name: 
// Module Name: Modulo3_FSM
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


module Modulo3_FSM(
    input clk,
    input start,
    input [12:0] V,
    input [3:0]C,
    input [12:0] M1,
    input signed[12:0] nega,
    input [3:0] M,
    input signed[12:0] N,    
    output reg R1, R2, R3, R4, R5, R6,R7, R8, R9, R10,
    output reg busy
    );
    
    parameter Inicio  = 4'b0000;
    parameter Inicio2 =4'b0001;
    parameter Neg= 4'b0111;
    parameter tempN= 4'b1010;
    parameter Negp= 4'b1011;
    parameter salidaNeg2=4'b1000;
    parameter salidaNeg1=4'b1100;
    parameter Op1N=4'b1101;
    parameter Op1 = 4'b0010;
    parameter Op2 = 4'b0011;
    parameter Op3 = 4'b0100;
    parameter Lp2 = 4'b0101;
    parameter temps = 4'b1001;
    parameter salida = 4'b0110;


    reg [3:0] presente = Inicio; // Registro de Estado - Valor inicial
    reg [3:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente, V, M1,nega, N, C, M,start)
        case (presente)
            Inicio :
                if(start)
                    futuro <= Inicio2;            
                else
                    futuro <= Inicio;
            Inicio2:
                if(N<0)
                    futuro <= Neg;
                else if(N>=M)
                    futuro <= Op1;                
                else
                    futuro <= salida;
            Neg:
                if(nega>=0 && nega<13'd3)
                    futuro <= salidaNeg1;
                else
                    futuro <= tempN;
            salidaNeg1:
                futuro<=Inicio;
            tempN:
                 if(nega>=0)
                    futuro <= Op1N;
                else
                    futuro <= Negp; 
            Negp:
                futuro <= tempN;               
            salidaNeg2:
                futuro<=Inicio;
            Op1N:
                 if(V>{M,9'd0})
                    futuro <= Op2;
                else
                    futuro <= Op3; 
            Op1:
                if(V>{M,9'd0})
                    futuro <= Op2;
                else
                    futuro <= Op3;
            Op2:
                if(V>C)
                    futuro <= Op3;
                else
                    futuro <= salida;
            Op3:
                if(V>={1'b0, M1[12:1]})
                    futuro <= temps;
                else
                    futuro <= Op3;
            temps:
                if(V-M1>=C && M1>V-M1)
                    futuro <= Op3;
                else if(C>V)
                    futuro <= salida;
                else
                    futuro <= Lp2; 
            Lp2:
                if(V>=C && M1>V-M1)
                    futuro <= Op3;
                else if(C>V)
                    futuro <= salida;
                else
                    futuro <= Lp2; 
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
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8 <= 1'b1;
                R9 <= 1'b0;
                R10 <= 1'b0;
                busy <= 1'b0; 
            end
            Inicio2 : begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8 <= 1'b1;
                R9 <= 1'b1;
                R10 <= 1'b1;
                busy <= 1'b0; 
            end
            Neg: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b0;
                R8 <= 1'b1;
                R9 <= 1'b0;
                R10 <= 1'b1;
                busy <= 1'b0; 
            end
            tempN: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b0;
                R8 <= 1'b1;
                R9 <= 1'b0;
                R10 <= 1'b1;
                busy <= 1'b0; 
            end
            Negp: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8 <= 1'b1;
                R9 <= 1'b1;
                R10 <= 1'b0;
                busy <= 1'b0; 
            end
            salidaNeg1: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8 <= 1'b1;
                R9 <= 1'b0;
                R10 <= 1'b1;
                busy <= 1'b1; 
            end
            salidaNeg2: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8 <= 1'b0;
                R9 <= 1'b0;
                R10 <= 1'b1;
                busy <= 1'b1; 
            end
            Op1N: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b1;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b0;
                R8 <= 1'b1;
                R9 <= 1'b0;
                R10 <= 1'b0;
                busy <= 1'b0; 
            end            
            Op1: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b1;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b0;
                R8 <= 1'b1;
                R9 <= 1'b0;
                R10 <= 1'b0;
                busy <= 1'b0; 
            end
            Op2: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8 <= 1'b1;
                R9 <= 1'b0;
                R10 <= 1'b0;
                busy <= 1'b0; 
            end
            Op3: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b0;
                R8 <= 1'b1;
                R9 <= 1'b0;
                R10 <= 1'b0;
                busy <= 1'b0; 
            end
            Lp2: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8 <= 1'b1;
                R9 <= 1'b0;
                R10 <= 1'b0;
                busy <= 1'b0; 
            end
            temps: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8 <= 1'b1;
                R9 <= 1'b0;
                R10 <= 1'b0;
                busy <= 1'b0;
            end 
            salida: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8 <= 1'b0;
                R9 <= 1'b0;
                R10 <= 1'b0;
                busy <= 1'b1; 
            end
            default: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8 <= 1'b1;
                R9 <= 1'b0;
                R10 <= 1'b0;
                busy <= 1'b0; 
            end
      endcase
        
endmodule
