`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2023 21:13:37
// Design Name: 
// Module Name: modulo3_decap_FSM
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


module modulo3_decap_FSM(
    input clk,
    input start,
    input moddone,
    input [12:0] N,
    input [12:0]q,
    input [12:0] p,    
    output reg R2, R3,
    output reg busy, startmod
    );
    
    parameter Inicio  = 5'b000;
    parameter preg1 =5'b001;
    parameter D1= 5'b010;
    parameter temp=5'b011;
    parameter temp2=5'b100;
    parameter mod1=5'b101;
    parameter salida = 5'b110;


    reg [2:0] presente = Inicio; // Registro de Estado - Valor inicial
    reg [2:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente, N, q, p,start, moddone)
        case (presente)
            Inicio :
                if(start)
                    futuro <= preg1;            
                else
                    futuro <= Inicio;
            preg1:
                if(N>(q-1)/2)
                    futuro <= D1;                  
                else
                    futuro <= temp;
            D1:
                futuro <= temp;
            temp:
                futuro <=mod1;           
            mod1:
                if(moddone)
                    futuro <= salida;
                else
                    futuro <= mod1;               
            salida:
                futuro <= Inicio;
            default:
                futuro <= Inicio;
        endcase
    
    // Lógica de salida
    always @(presente)
        case (presente)
            Inicio : begin
                R2 <= 1'b0;
                R3 <= 1'b0;
                busy <= 1'b0;
                startmod <=1'b0; 
            end
            preg1 : begin
                R2 <= 1'b0;
                R3 <= 1'b0;
                busy <= 1'b0;
                startmod <=1'b0; 
            end
            D1: begin
                R2 <= 1'b1;
                R3 <= 1'b0;
                busy <= 1'b0;
                startmod <=1'b0;  
            end
            temp: begin
                R2 <= 1'b1;
                R3 <= 1'b1;
                busy <= 1'b0;
                startmod <=1'b1;
            end  
            mod1: begin
                R2 <= 1'b1;
                R3 <= 1'b1;
                busy <= 1'b0;
                startmod <=1'b0;
            end
            salida: begin
               R2 <= 1'b1;
                R3 <= 1'b1;
                busy <= 1'b1;
                startmod <=1'b0;
            end 
            default: begin
                R2 <= 1'b0;
                R3 <= 1'b0;
                busy <= 1'b0;
                startmod <=1'b0; 
             end 
     endcase
endmodule
