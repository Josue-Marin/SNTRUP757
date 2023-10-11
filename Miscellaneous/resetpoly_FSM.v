`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.08.2023 21:31:06
// Design Name: 
// Module Name: resetpoly_FSM
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


module resetpoly_FSM(
    input clk,
    input start,
    input write_enable,
    input [10:0] i, 
    input [10:0]max, 
    output reg R1, R4, R6, R7, R9,
    output reg write_done
    );
    

    parameter Inicio  = 2'b00;
    parameter Inicio2  = 2'b01;
    parameter Op1 =2'b10;
    parameter salida =2'b11;


    reg [1:0] presente = Inicio; // Registro de Estado - Valor inicial
    reg [1:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente,start,i, max, write_enable)
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
                if(i>=max)
                    futuro <= salida;
                else
                    futuro <= Op1;
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
                R4 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R9 <= 1'b0;
                write_done <= 1'b0; 
            end
            Inicio2 : begin
                R1 <= 1'b0;
                R4 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b0;
                R9 <= 1'b0;
                write_done <= 1'b0; 
            end                     
            Op1: begin
                R1 <= 1'b1;
                R4 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b0;
                R9 <= 1'b0;
                write_done <= 1'b0;  
            end
            salida: begin
                R1 <= 1'b0;
                R4 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R9 <= 1'b0;
                write_done <= 1'b1;  
            end
            default: begin
                R1 <= 1'b0;
                R4 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R9 <= 1'b0;
                write_done <= 1'b0; 
            end
      endcase
endmodule