`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2023 09:14:37
// Design Name: 
// Module Name: Round_poly_FSM
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


module Round_poly_FSM(
    input clk,
    input start,
    input moddone,
    input [12:0] N,
    input [12:0]q,
    input [12:0] p,    
    output reg R1, R2, R3, R4, R5, R6,R7,f,
    output reg busy, startmod
    );
    
    parameter Inicio  = 5'b00000;
    parameter preg1 =5'b00001;
    parameter D1= 5'b00010;
    parameter D2= 5'b00011;
    parameter temp=5'b10000;
    parameter temp2=5'b10001;
    parameter mod1=5'b00100;
    parameter as1=5'b00101;
    parameter ch1 = 5'b00110;
    parameter sa1 = 5'b00111;
    parameter sa4 = 5'b01000;
    parameter mod2 = 5'b01001;
    parameter preg2 = 5'b01010;
    parameter ch2 = 5'b01011;
    parameter sa2 = 5'b01100;
    parameter sa3 = 5'b01101;
    parameter sa5 = 5'b01110;
    parameter salida = 5'b01111;


    reg [4:0] presente = Inicio; // Registro de Estado - Valor inicial
    reg [4:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente, N, q, p, f,start, moddone)
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
                    futuro <= D2;
            D1:
                futuro <= temp;
            D2:
                futuro<= temp;
            temp:
                futuro <=mod1;           
            mod1:
                if(moddone)
                    futuro <= as1;
                else
                    futuro <= mod1;               
            as1:
                if(p!=0)
                    futuro <= temp2;
                else
                    futuro <= ch1;
            ch1:
                if(f)
                    futuro <= sa4;
                else
                    futuro <= sa1;
            sa1:
                futuro <= salida;
            sa4:
                futuro <= salida;
            temp2:
                futuro <= mod2;
            mod2:
                if(moddone)
                    futuro <= preg2;             
                else
                    futuro <= mod2; 
            preg2:
                if(p!=0)
                    futuro <= ch2;              
                else
                    futuro <= sa2;
            ch2:
                if(f)
                    futuro <= sa5;
                else
                    futuro <= sa3;
            sa3:
                futuro <= salida;
            sa2:
                futuro <= salida;
            sa5:
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
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                busy <= 1'b0;
                f <= 1'b0;
                startmod <=1'b0; 
            end
            preg1 : begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                busy <= 1'b0;
                f <= f;
                startmod <=1'b0; 
            end
            D1: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                busy <= 1'b0;
                f <= 1'b1;
                startmod <=1'b0; 
            end
            D2: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                busy <= 1'b0;
                f <= f;
                startmod <=1'b0;
            end
            temp: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                busy <= 1'b0;
                f <= f;
                startmod <=1'b1;
            end  
            mod1: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                busy <= 1'b0;
                f <= f;
                startmod <=1'b0; 
            end
            as1: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                busy <= 1'b0;
                f <= f;
                startmod <=1'b0; 
            end            
            ch1: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                busy <= 1'b0;
                f <= f;
                startmod <=1'b0; 
            end
            sa4: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b0;
                busy <= 1'b0;
                f <= f;
                startmod <=1'b0; 
            end
            sa1: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b0;
                busy <= 1'b0;
                f <= f;
                startmod <=1'b0; 
            end
            temp2: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                busy <= 1'b0;
                f <= f;
                startmod <=1'b1;
            end  
            mod2: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                busy <= 1'b0;
                f <= f;
                startmod <=1'b0; 
            end
            preg2: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                busy <= 1'b0;
                f <= f;
                startmod <=1'b0; 
            end
            ch2: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                busy <= 1'b0;
                f <= f;
                startmod <=1'b0;  
            end
            sa2: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b0;
                busy <= 1'b0;
                f <= f;
                startmod <=1'b0; 
            end
            sa3: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b0;
                busy <= 1'b0;
                f <= f;
                startmod <=1'b0; 
            end
            sa5: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b1;
                busy <= 1'b0;
                f <= f;
                startmod <=1'b0; 
            end 
            salida: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R3 <= 1'b1;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                busy <= 1'b1;
                f <= f;
                startmod <=1'b0;
            end 
            default: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b1;
                R5 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                busy <= 1'b0;
                f <= 1'b0;
                startmod <=1'b0;
             end 
     endcase
endmodule