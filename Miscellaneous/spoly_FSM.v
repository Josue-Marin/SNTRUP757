`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2023 11:20:11
// Design Name: 
// Module Name: spoly_FSM
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


module spoly_FSM(
    input clk,
    input start,
    input write_enable,
    input [12:0] mem_output,
    input [10:0] i,  
    output reg R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11,
    output reg write_done
    );
    

    parameter Inicio  = 4'b0000;
    parameter Inicio2  = 4'b0010;
    parameter Op1 =4'b0100;
    parameter Op2 =4'b0110;
    parameter Op3 =4'b1000;
    parameter d1 =4'b1010;
    parameter d2 =4'b1100;
    parameter temp1 =4'b1001;
    parameter temp2 =4'b1101;
    parameter salida =4'b1110;


    reg [3:0] presente = Inicio; // Registro de Estado - Valor inicial
    reg [3:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente,start,i, mem_output, write_enable)
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
                if(i>=10'd756)
                    futuro <= Op2;
                else
                    futuro <= Op1;
            Op2:
                if(mem_output==0)
                    futuro <= Op3;
                else
                    futuro <= d1;
            Op3:
                futuro <= Op2;
            d1:
                futuro <= d2;
            d2:
                if(mem_output!=0)
                    futuro <= temp1;
                else
                    futuro <= d2;
            temp1:
                  if(start==0)
                    futuro <= temp2;
                else
                    futuro <= temp1;
            temp2:
                  if(start==0)
                    futuro <= salida;
                  else
                    futuro <= temp2; 
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
                R8 <= 1'b0;
                R9 <= 1'b0;
                R10 <= 1'b0;
                R11 <= 1'b1;
                write_done <= 1'b0; 
            end
            Inicio2 : begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b0;
                R8 <= 1'b0;
                R9 <= 1'b0;
                R10 <= 1'b0;
                R11 <= 1'b1;
                write_done <= 1'b0; 
            end                     
            Op1: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b1;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b0;
                R8 <= 1'b0;
                R9 <= 1'b0;
                R10 <= 1'b0;
                R11 <= 1'b1;
                write_done <= 1'b0; 
            end
            Op2: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b0;
                R10 <= 1'b0;
                R11 <= 1'b1;
                write_done <= 1'b0; 
            end
            Op3: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b0;
                R10 <= 1'b0;
                R11 <= 1'b1;
                write_done <= 1'b0; 
            end
            d1: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b0;
                R10 <= 1'b1;
                R11 <= 1'b1;
                write_done <= 1'b0; 
            end
            d2: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R8 <= 1'b1;
                R9 <= 1'b1;
                R10 <= 1'b1;
                R11 <= 1'b1;
                write_done <= 1'b0; 
            end
            temp1: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8 <= 1'b1;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b0;
                write_done <= 1'b1; 
            end
            temp2: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8 <= 1'b1;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b0;
                write_done <= 1'b1; 
            end
            salida: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8 <= 1'b1;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b0;
                write_done <= 1'b1; 
            end
            default: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b0;
                R8 <= 1'b0;
                R9 <= 1'b0;
                R10 <= 1'b0;
                R11 <= 1'b1;
                write_done <= 1'b0; 
            end
      endcase
        
endmodule

