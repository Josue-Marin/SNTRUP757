`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2023 09:39:28
// Design Name: 
// Module Name: Normalize_inverse_FSM
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


module Normalize_inverse_FSM(
    input clk,
    input start, moddone1, moddonemf,
    input [12:0] mem_output,
    input [10:0] degp,
    input [10:0] i,    
    output reg R1, R2, R3, R4, R5, R6, R7, write_enable, startmod1, startmf,
    output reg busy
    );

    parameter Inicio = 4'b0000;
    parameter startmod =4'b0001;
    parameter modulo= 4'b0010;
    parameter Fp= 4'b0011;
    parameter fracmodstart=4'b0100;
    parameter fracmodulo=4'b0101;
    parameter preg2=4'b0110;
    parameter salida=4'b0111;


    reg [3:0] presente = Inicio; // Registro de Estado - Valor inicial
    reg [3:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente, mem_output, i, degp,start, moddone1, moddonemf)
        case (presente)
            Inicio :
                if(start)
                    futuro <= startmod;            
                else
                    futuro <= Inicio;
            startmod:
                futuro <= modulo;                
            modulo:
                if(moddone1)
                    futuro <= Fp;                  
                else
                    futuro <= modulo;
            Fp:
                futuro<= fracmodstart;
            fracmodstart:
                futuro<= fracmodulo;
            
            fracmodulo:
                if(moddonemf)
                    futuro <= preg2;                  
                else
                    futuro <= fracmodulo;                
            preg2:
                if(i<=degp)
                    futuro <= fracmodstart;                  
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
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b0;
                startmod1<= 1'b0;
                startmf<= 1'b0;
                write_enable <=1'b0;
                busy <= 1'b0;
            end
            startmod : begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b0;
                startmod1<= 1'b1;
                startmf<= 1'b0;
                write_enable <=1'b0;
                busy <= 1'b0;
            end
            modulo: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b0;
                startmod1<= 1'b0;
                startmf<= 1'b0;
                write_enable <=1'b0;
                busy <= 1'b0;
            end
            Fp: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b0;
                startmod1<= 1'b0;
                startmf<= 1'b0;
                write_enable <=1'b0;
                busy <= 1'b0;
            end
            fracmodstart: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b0;
                startmod1<= 1'b0;
                startmf<= 1'b1;
                write_enable <=1'b1;
                busy <= 1'b0;
            end
            fracmodulo: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b0;
                startmod1<= 1'b0;
                startmf<= 1'b0;
                write_enable <=1'b0;
                busy <= 1'b0;
            end
            preg2: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b0;
                startmod1<= 1'b0;
                startmf<= 1'b0;
                write_enable <=1'b0;
                busy <= 1'b0;
            end            
            salida: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b1;
                startmod1<= 1'b0;
                startmf<= 1'b0;
                write_enable <=1'b1;
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
                startmod1<= 1'b0;
                startmf<= 1'b0;
                write_enable <=1'b0;
                busy <= 1'b0;
             end 
     endcase
endmodule
