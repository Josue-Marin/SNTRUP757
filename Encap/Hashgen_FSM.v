`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.09.2023 08:26:22
// Design Name: 
// Module Name: Hashgen_FSM
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


module Hashgen_FSM(
    input clk, start,
    input ready,
    input [4:0]counter,
    input fetch_done,
    output reg startfetch, next, init, work_factor,
    output reg Q1, R8, R9, R10, R11,
    output reg prueba_fin
    );
    
    parameter Inicio1  = 4'b0000;
    parameter Inicio2  = 4'b1000;    
    parameter fetchdata  = 4'b0001;
    parameter hash_st=4'b0010;
    parameter hash_chb=4'b0011;
    parameter hash_done=4'b0100;
    parameter hash_sum=4'b0101;
    parameter comp_bn=4'b0110;
    parameter salida = 4'b0111;


    reg [3:0] presente = Inicio1; // Registro de Estado - Valor inicial
    reg [3:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente,  fetch_done, counter, ready, start)
        case (presente)
            Inicio1:
                if(start)
                    futuro <= Inicio2;            
                else
                    futuro <= Inicio1;
            Inicio2:
                futuro <= fetchdata;
            fetchdata:
                if(fetch_done)
                    futuro <= hash_st;
                else
                    futuro <= fetchdata;
            hash_st:
                futuro <= hash_done;
            hash_chb:
                futuro <= hash_done;
            hash_done:
                if(ready)
                    futuro <= hash_sum;
                else
                    futuro <= hash_done;
            hash_sum:
                futuro <= comp_bn;
            comp_bn:
                if(counter<(9))
                    futuro <= hash_chb;
                else
                    futuro <= salida;
            salida:
                futuro <= Inicio1;
            default:
                futuro <= Inicio1;
        endcase
    
    // Lógica de salida
    always @(presente)
        case (presente)
            Inicio1 : begin
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                next<= 1'b0;
                init<= 1'b0;
                work_factor<= 1'b0;
                Q1<=Q1;
                startfetch <= 1'b0;
                prueba_fin <= 1'b0;
            end
            Inicio2:begin
               R8<= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R11<= 1'b1;
                next<= 1'b0;
                init<= 1'b0;
                work_factor<= 1'b0;
                Q1<=1'b0;
                startfetch <= 1'b0;
                prueba_fin <= 1'b0;
            end
                             
            fetchdata: begin
                R8<= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R11<= 1'b1;
                next<= next;
                init<=init;
                work_factor<= work_factor;
                Q1<=1'b1;
                startfetch <= 1'b1;
                prueba_fin <= 1'b0;
            end
            hash_st: begin
                R8<= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R11<= 1'b1;
                next<= 1'b0;
                init<= 1'b1;
                work_factor<= 1'b0;
                Q1<=1'b1;
               startfetch <= 1'b0;
               prueba_fin <= 1'b0;
            end
            hash_chb: begin
                R8<= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R11<= 1'b1;
                next<= 1'b1;
                init<= 1'b0;
                work_factor<= 1'b1;
                Q1<=1'b1;
               startfetch <= 1'b0;
               prueba_fin <= 1'b0;
            end
            hash_done: begin
                R8<= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R11<= 1'b1;
                next<= 1'b0;
                init<= init;
                work_factor<= 1'b0;
                Q1<=1'b1;
               startfetch <= 1'b0;
               prueba_fin <= 1'b0;
            end
            hash_sum: begin
                R8<= 1'b0;
                R9<= 1'b1;
                R10<= 1'b0;
                R11<= 1'b1;
                next<= 1'b0;
                init<= 1'b0;
                work_factor<= 1'b0;
                Q1<=1'b1;
               startfetch <= 1'b0;
               prueba_fin <= 1'b0;
            end
            comp_bn: begin
                R8<= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R11<= 1'b1;
                next<= 1'b0;
                init<= 1'b0;
                work_factor<= 1'b0;
               Q1<=1'b1;
               startfetch <= 1'b0;
               prueba_fin <= 1'b0;
            end
            salida: begin
                R8<= 1'b1;
                R9<= 1'b1;
                R10<= 1'b1;
                R11<= 1'b1;
                next<= 1'b0;
                init<= 1'b0;
                work_factor<= 1'b0; 
               Q1<=1'b1;
               startfetch <= 1'b0;
               prueba_fin <= 1'b1;
            end
            default: begin 
                R8<= 1'b1;
                R9<= 1'b1;
                R10<= 1'b0;
                R11<= 1'b0;
                next<= 1'b0;
                init<= 1'b0;
                work_factor<= 1'b0;
                Q1<=Q1;
                startfetch <= 1'b0;
                prueba_fin <= 1'b0;
            end
      endcase

endmodule
