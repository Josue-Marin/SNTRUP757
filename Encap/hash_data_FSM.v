`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2023 15:59:30
// Design Name: 
// Module Name: hash_data_FSM
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


module hash_data_FSM(
    input clk,
    input start,
    input [10:0] mem_output,
    input [10:0] degp,
    input [10:0] i,    
    output reg R1, R2, R3, R4, R5,
    output reg busy
    );
    
    parameter Inicio = 3'b000;
    parameter Tp= 3'b001;
    parameter Fp= 3'b010;
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
                    futuro <= Tp;            
                else
                    futuro <= Inicio;
            Tp:
               futuro <= preg2;
            Fp:
                futuro <= preg2;
            preg2:
                if(i<=degp)
                    futuro <= Fp;                  
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
                R4 <= 1'b1;
                R5 <= 1'b1;
                busy <= 1'b0;
            end
            Tp: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                busy <= 1'b0;
            end
            Fp: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b1;
                R5 <= 1'b0;
                busy <= 1'b0;
            end
            preg2: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                busy <= 1'b0;
            end
            salida: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                busy <= 1'b1;
            end 
            default: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                busy <= 1'b0;
             end 
     endcase
endmodule