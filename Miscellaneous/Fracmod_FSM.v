`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2023 14:43:12
// Design Name: 
// Module Name: Fracmod_FSM
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


module Fracmod_FSM(
    input clk,
    input start,busydiv, moddone, moddonem, moddonen,
    input [11:0] modu,
    input [12:0] num,
    input [12:0] den,
    input [12:0]r,   
    output reg R1, R2, R3, R4, R5, R6,R7, R8,R9, R10,R11, R12,R13, R14, R15, R16,R17, R18,R19,  R20, R21,R22,R23,R24,
    output reg busy,startm,startd,startmm, startmn
    );
    
    parameter Inicio  = 5'b00000;
    parameter preg1= 5'b01110;
    parameter salidaI=5'b10000;
    parameter preg2= 5'b10001;
    parameter salidaT=5'b10010;
    parameter div =5'b00001;
    parameter muln = 5'b00010;
    parameter mulm =5'b00011;
    parameter as1= 5'b00100;
    parameter preg= 5'b01010;
    parameter Mod1 = 5'b00101;
    parameter temp4= 5'b01100;
    parameter as2 = 5'b00110;
    parameter temp= 5'b01101;
    parameter temp2= 5'b01011;
    parameter temp3= 5'b01111;
    parameter as3 = 5'b00111;
    parameter Mod2 = 5'b01000;
    parameter salida = 5'b01001;


    reg [4:0] presente = Inicio; // Registro de Estado - Valor inicial
    reg [4:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente, r, start,busydiv, moddone, moddonem, modu, num, den)
        case (presente)
            Inicio :
                if(start)
                    futuro <= preg1;            
                else
                    futuro <= Inicio;
            preg1:
                 if(num==modu || den==modu || den==11'd0)
                    futuro <= salidaI;            
                else
                    futuro <= preg2;
            salidaI:
                futuro <= Inicio;
            preg2:
                 if(num==den)
                    futuro <= salidaT;            
                else
                    futuro <= temp;
            salidaT:
                 futuro <= Inicio;                  
            temp: 
                futuro <= div;
            div:
                if(busydiv)
                    futuro <= mulm;                
                else
                    futuro <= div;
            mulm:
                 futuro <= temp2;
            temp2:
                futuro <= muln;
            muln:
                 futuro <= temp3;
           temp3:
                 futuro <= as1;            
            as1:
                futuro<=preg;
            preg:
                if(r==0)
                    futuro <= temp4;
                else
                    futuro <= Mod1;
            Mod1:
                if(moddonem)
                    futuro <= temp4;
                else
                    futuro <= Mod1;
            temp4:
                 futuro<=as2;
            as2:
                if(r==0)
                    futuro <= as3;
                else
                    futuro <= temp;
            as3:
                    futuro <= Mod2;
            Mod2:
                if(moddone)
                    futuro <= salida;
                else
                    futuro <= Mod2;
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
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8 <= 1'b0;
                R9 <= 1'b0;
                R10 <= 1'b0;
                R11 <= 1'b0;
                R12 <= 1'b0;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b1;
                R16 <= 1'b1;
                R17 <= 1'b1;
                R18 <= 1'b1;
                R19 <= 1'b1;
                R20 <= 1'b1;
                R21 <= 1'b1;
                R22 <= 1'b1;
                R23 <= 1'b1;
                R24 <= 1'b1;
                busy <= 1'b0;
                startm <= 1'b0;
                startd <= 1'b0;
                startmn <= 1'b0;
                startmm <= 1'b0;
            end
            preg1: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b1;
                R12 <= 1'b0;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b1;
                R16 <= 1'b1;
                R17 <= 1'b1;
                R18 <= 1'b1;
                R19 <= 1'b1;
                R20 <= 1'b0;
                R21 <= 1'b0;
                R22 <= 1'b0;
                R23 <= 1'b0;
                R24 <= 1'b0;
                busy <= 1'b0;
                startm <= 1'b0;
                startd <= 1'b0;
                startmn <= 1'b0;
                startmm <= 1'b0; 
            end 
            salidaI: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b1;
                R12 <= 1'b0;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b1;
                R16 <= 1'b1;
                R17 <= 1'b1;
                R18 <= 1'b1;
                R19 <= 1'b1;
                R20 <= 1'b0;
                R21 <= 1'b0;
                R22 <= 1'b0;
                R23 <= 1'b1;
                R24 <= 1'b0;
                busy <= 1'b1;
                startm <= 1'b0;
                startd <= 1'b0;
                startmn <= 1'b0;
                startmm <= 1'b0; 
            end 
            preg2: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b1;
                R12 <= 1'b0;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b1;
                R16 <= 1'b1;
                R17 <= 1'b1;
                R18 <= 1'b1;
                R19 <= 1'b1;
                R20 <= 1'b0;
                R21 <= 1'b0;
                R22 <= 1'b0;
                R23 <= 1'b0;
                R24 <= 1'b0;
                busy <= 1'b0;
                startm <= 1'b0;
                startd <= 1'b0;
                startmn <= 1'b0;
                startmm <= 1'b0; 
            end 
            salidaT: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b1;
                R12 <= 1'b0;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b1;
                R16 <= 1'b1;
                R17 <= 1'b1;
                R18 <= 1'b1;
                R19 <= 1'b1;
                R20 <= 1'b0;
                R21 <= 1'b0;
                R22 <= 1'b0;
                R23 <= 1'b0;
                R24 <= 1'b1;
                busy <= 1'b1;
                startm <= 1'b0;
                startd <= 1'b0;
                startmn <= 1'b0;
                startmm <= 1'b0; 
            end 
            temp: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b1;
                R12 <= 1'b0;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b1;
                R16 <= 1'b1;
                R17 <= 1'b1;
                R18 <= 1'b1;
                R19 <= 1'b1;
                R20 <= 1'b0;
                R21 <= 1'b0;
                R22 <= 1'b0;
                R23 <= 1'b0;
                R24 <= 1'b0;
                busy <= 1'b0;
                startm <= 1'b0;
                startd <= 1'b1;
                startmn <= 1'b0;
                startmm <= 1'b0; 
            end
            div : begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b1;
                R12 <= 1'b0;
                R13 <= 1'b0;
                R14 <= 1'b0;
                R15 <= 1'b1;
                R16 <= 1'b1;
                R17 <= 1'b1;
                R18 <= 1'b1;
                R19 <= 1'b1;
                R20 <= 1'b0;
                R21 <= 1'b0;
                R22 <= 1'b0;
                R23 <= 1'b0;
                R24 <= 1'b0;
                busy <= 1'b0;
                startm <= 1'b0;
                startd <= 1'b0;
                startmn <= 1'b0;
                startmm <= 1'b0; 
            end
            mulm: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b1;
                R12 <= 1'b0;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b1;
                R16 <= 1'b1;
                R17 <= 1'b1;
                R18 <= 1'b1;
                R19 <= 1'b0;
                R20 <= 1'b0;
                R21 <= 1'b0;
                R22 <= 1'b0;
                R23 <= 1'b0;
                R24 <= 1'b0;
                busy <= 1'b0;
                startm <= 1'b0;
                startd <= 1'b0;
                startmn <= 1'b0;
                startmm <= 1'b0; 
            end
            temp2:begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b1;
                R12 <= 1'b0;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b1;
                R16 <= 1'b1;
                R17 <= 1'b1;
                R18 <= 1'b1;
                R19 <= 1'b0;
                R20 <= 1'b0;
                R21 <= 1'b0;
                R22 <= 1'b0;
                R23 <= 1'b0;
                R24 <= 1'b0;
                busy <= 1'b0;
                startm <= 1'b0;
                startd <= 1'b0;
                startmn <= 1'b0;
                startmm <= 1'b0; 
            end
            muln: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b1;
                R12 <= 1'b0;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b0;
                R16 <= 1'b0;
                R17 <= 1'b0;
                R18 <= 1'b1;
                R19 <= 1'b1;
                R20 <= 1'b0;
                R21 <= 1'b0;
                R22 <= 1'b0;
                R23 <= 1'b0;
                R24 <= 1'b0;
                busy <= 1'b0;
                startm <= 1'b0;
                startd <= 1'b0;
                startmn <= 1'b0;
                startmm <= 1'b0; 
            end
            temp3:begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b1;
                R12 <= 1'b0;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b0;
                R16 <= 1'b0;
                R17 <= 1'b0;
                R18 <= 1'b1;
                R19 <= 1'b1;
                R20 <= 1'b0;
                R21 <= 1'b0;
                R22 <= 1'b0;
                R23 <= 1'b0;
                R24 <= 1'b0;
                busy <= 1'b0;
                startm <= 1'b0;
                startd <= 1'b0;
                startmn <= 1'b0;
                startmm <= 1'b0; 
            end
            as1: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b1;
                R12 <= 1'b0;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b0;
                R16 <= 1'b0;
                R17 <= 1'b1;
                R18 <= 1'b1;
                R19 <= 1'b1;
                R20 <= 1'b0;
                R21 <= 1'b0;
                R22 <= 1'b0;
                R23 <= 1'b0;
                R24 <= 1'b0;
                busy <= 1'b0;
                startm <= 1'b0;
                startd <= 1'b0;
                startmn <= 1'b0;
                startmm <= 1'b0; 
            end
            preg: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b1;
                R12 <= 1'b0;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b1;
                R16 <= 1'b1;
                R17 <= 1'b1;
                R18 <= 1'b1;
                R19 <= 1'b1;
                R20 <= 1'b0;
                R21 <= 1'b0;
                R22 <= 1'b0;
                R23 <= 1'b0;
                R24 <= 1'b0;
                busy <= 1'b0;
                startm <= 1'b0;
                startd <= 1'b0;
                startmn <= 1'b0;
                startmm <= 1'b0; 
            end            
            Mod1: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b1;
                R12 <= 1'b0;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b1;
                R16 <= 1'b1;
                R17 <= 1'b1;
                R18 <= 1'b1;
                R19 <= 1'b1;
                R20 <= 1'b0;
                R21 <= 1'b0;
                R22 <= 1'b0;
                R23 <= 1'b0;
                R24 <= 1'b0;
                busy <= 1'b0;
                startm <= 1'b0;
                startd <= 1'b0;
                startmn <= 1'b1;
                startmm <= 1'b1; 
            end
            temp4:begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b1;
                R12 <= 1'b0;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b0;
                R16 <= 1'b0;
                R17 <= 1'b1;
                R18 <= 1'b1;
                R19 <= 1'b1;
                R20 <= 1'b1;
                R21 <= 1'b1;
                R22 <= 1'b0;
                R23 <= 1'b0;
                R24 <= 1'b0;
                busy <= 1'b0;
                startm <= 1'b0;
                startd <= 1'b0;
                startmn <= 1'b0;
                startmm <= 1'b0;
            end
            as2: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b1;
                R5 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b0;
                R8 <= 1'b1;
                R9 <= 1'b0;
                R10 <= 1'b1;
                R11 <= 1'b0;
                R12 <= 1'b1;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b1;
                R16 <= 1'b1;
                R17 <= 1'b1;
                R18 <= 1'b1;
                R19 <= 1'b1;
                R20 <= 1'b0;
                R21 <= 1'b0;
                R22 <= 1'b0;
                R23 <= 1'b0;
                R24 <= 1'b0;
                busy <= 1'b0;
                startm <= 1'b0;
                startd <= 1'b0;
                startmn <= 1'b0;
                startmm <= 1'b0; 
            end
            
            as3: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b1;
                R12 <= 1'b0;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b1;
                R16 <= 1'b1;
                R17 <= 1'b1;
                R18 <= 1'b0;
                R19 <= 1'b1;
                R20 <= 1'b0;
                R21 <= 1'b0;
                R22 <= 1'b0;
                R23 <= 1'b0;
                R24 <= 1'b0;
                busy <= 1'b0;
                startm <= 1'b0;
                startd <= 1'b0;
                startmn <= 1'b0;
                startmm <= 1'b0; 
            end
            Mod2: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b1;
                R12 <= 1'b0;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b1;
                R16 <= 1'b1;
                R17 <= 1'b1;
                R18 <= 1'b1;
                R19 <= 1'b1;
                R20 <= 1'b0;
                R21 <= 1'b0;
                R22 <= 1'b0;
                R23 <= 1'b0;
                R24 <= 1'b0;
                busy <= 1'b0;
                startm <= 1'b1;
                startd <= 1'b0;
                startmn <= 1'b0;
                startmm <= 1'b0; 
            end
            salida: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R8 <= 1'b0;
                R9 <= 1'b1;
                R10 <= 1'b0;
                R11 <= 1'b1;
                R12 <= 1'b0;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b1;
                R16 <= 1'b1;
                R17 <= 1'b1;
                R18 <= 1'b1;
                R19 <= 1'b1;
                R20 <= 1'b0;
                R21 <= 1'b0;
                R22 <= 1'b0;
                R23 <= 1'b0;
                R24 <= 1'b0;
                busy <= 1'b1;
                startm <= 1'b0;
                startd <= 1'b0;
                startmn <= 1'b0;
                startmm <= 1'b0; 
            end
            default: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R8 <= 1'b0;
                R9 <= 1'b0;
                R10 <= 1'b0;
                R11 <= 1'b0;
                R12 <= 1'b0;
                R13 <= 1'b1;
                R14 <= 1'b1;
                R15 <= 1'b1;
                R16 <= 1'b1;
                R17 <= 1'b1;
                R18 <= 1'b1;
                R19 <= 1'b1;
                R20 <= 1'b0;
                R21 <= 1'b0;
                R22 <= 1'b0;
                R23 <= 1'b0;
                R24 <= 1'b0;
                busy <= 1'b0;
                startm <= 1'b0;
                startd <= 1'b0;
                startmn <= 1'b0;
                startmm <= 1'b0; 
            end
      endcase
        
endmodule
