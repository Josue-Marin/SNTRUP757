`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2023 10:10:36
// Design Name: 
// Module Name: Lift_poly_FSM
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


module Lift_poly_FSM(
    input clk,
    input start,
    input [10:0] mem_output,
    input [10:0] degp,
    input [10:0] i, zerocount,    
    output reg R1, R2, R3, R4, R5,
    output reg busy, st
    );
    
    parameter p=12'd757;
    parameter t=7'd116;
    parameter Inicio = 3'b000;
    parameter preg1 =3'b001;
    parameter Fp= 3'b010;
    parameter Tp= 3'b011;
    parameter preg2=3'b100;
    parameter preg3=3'b110;
    parameter as1=3'b111;
    parameter salida=3'b101;


    reg [2:0] presente = Inicio; // Registro de Estado - Valor inicial
    reg [2:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente, mem_output, i, zerocount, degp,start, p, t)
        case (presente)
            Inicio :
                if(start)
                    futuro <= preg1;            
                else
                    futuro <= Inicio;
            preg1:
                if(mem_output!=12'd0)
                    futuro <= Tp;                  
                else
                    futuro <= Fp;
            Fp:
                futuro <= preg2;
            Tp:
                futuro<= preg2;
            preg2:
                if(i<=degp)
                    futuro <= preg1;                  
                else
                    futuro <= preg3;
            preg3:
                if(zerocount==2*t)
                    futuro <= as1;                  
                else
                    futuro <= salida;
            as1:
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
                st <= st;
                busy <= 1'b0;
            end
            preg1 : begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                st <= 1'b0;
                busy <= 1'b0;
            end
            Fp: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b1;
                R5 <= 1'b1;
                st <= 1'b0;
                busy <= 1'b0;
            end
            Tp: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b1;
                R5 <= 1'b0;
                st <= 1'b0;
                busy <= 1'b0;
            end
            preg2: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                st <= 1'b0;
                busy <= 1'b0;
            end
            preg3: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                st <= 1'b0;
                busy <= 1'b0;
            end
            as1: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                st <= 1'b1;
                busy <= 1'b0;
            end
            salida: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                st <= st;
                busy <= 1'b1;
            end 
            default: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                st <= st;
                busy <= 1'b0;
             end 
     endcase
endmodule