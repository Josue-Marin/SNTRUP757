`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2023 19:49:55
// Design Name: 
// Module Name: liftN_FSM
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


module liftN_FSM(
    input clk,
    input start,
    input [12:0] mem_output,
    input [10:0] degp,
    input [10:0] i,    
    output reg R1, R2, R3, R4, R5, R6, R7, write_enable,
    output reg busy
    );

    parameter Inicio = 3'b000;
    parameter preg1 =3'b001;
    parameter Fp= 3'b010;
    parameter Tp= 3'b011;
    parameter preg2=3'b100;
    parameter salida=3'b101;


    reg [2:0] presente = Inicio; // Registro de Estado - Valor inicial
    reg [2:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente, mem_output, i, degp,start)
        case (presente)
            Inicio :
                if(start)
                    futuro <= preg1;            
                else
                    futuro <= Inicio;
            preg1:
                if(mem_output==12'd2)
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
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b0;
                write_enable <=1'b0;
                busy <= 1'b0;
            end
            preg1 : begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b0;
                write_enable <=1'b0;
                busy <= 1'b0;
            end
            Fp: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                write_enable <=1'b0;
                busy <= 1'b0;
            end
            Tp: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                write_enable <=1'b0;
                busy <= 1'b0;
            end
            preg2: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b0;
                write_enable <=1'b1;
                busy <= 1'b0;
            end
            salida: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                write_enable <=1'b0;
                busy <= 1'b1;
            end 
            default: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                write_enable <=1'b0;
                busy <= 1'b0;
             end 
     endcase
endmodule