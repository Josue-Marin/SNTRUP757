`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.05.2023 13:31:47
// Design Name: 
// Module Name: tspoly_FSM
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


module tspoly_FSM(
    input clk,
    input start,
    input write_enable,
    input [12:0] mem_output,
    input [10:0] i, j,k,zc,minco, 
    output reg R1, R2, R3, R4, R5, R8, R9, R10, R11, R12, R13, R14,R15, R16, R17,R18, R19, R20, R21, R22,R23,R24,R25,R26, R27,
    output reg write_done, dd
    );
    
    parameter p=10'd757;
    parameter t=8'd116;
    parameter Inicio  = 5'b00000;
    parameter Inicio2  = 5'b00001;
    parameter Op1 =5'b00010;
    parameter C1 =5'b00110;
    parameter C2 =5'b01000;
    parameter C3 =5'b01010;
    parameter Fr1 =5'b01100;
    parameter M =5'b10010;
    parameter wd =5'b00111;
    parameter T =5'b01111;
    parameter grad =5'b11001;
    parameter salida =5'b10100;
    parameter temp1=5'b10110;
    parameter temp2=5'b11000;
    parameter temp3=5'b11010;
    parameter temp4=5'b11100;
    parameter temp5=5'b11110;
    parameter temp6=5'b01110;
    


    reg [4:0] presente = Inicio; // Registro de Estado - Valor inicial
    reg [4:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente,start,i, j, k, minco,zc,mem_output,p,write_enable,t)
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
                if(i<p-1)
                    futuro <= Op1;
                else
                    futuro <= C1;
            C1:
                if(mem_output!=0)
                    futuro <= C2;
                else
                    futuro<=temp1;
            temp1:  
                if (k<=p)
                     futuro<=C1;
                else
                    futuro<=temp2;  
            temp2: 
                 if (zc==2*t)
                     futuro <= wd;
                 else
                     futuro<=C3;
            C2:
                if (k<=p-1)
                      futuro<=C1;
                else
                    futuro<=temp3;
            temp3: 
                 if (zc==2*t)
                     futuro <= wd;
                 else
                     futuro<=C3;
            C3:
                if(write_enable)
                    futuro<=temp4;
                else
                    futuro <= C3;
            temp4:
                 if(mem_output==13'd8191 || mem_output==1)
                      futuro <= temp6;
                 else
                     futuro<=temp5;
            temp5:  
                  if(j<=p-1)
                      futuro <=C3;
                  else 
                      futuro <=M; 
            temp6:
                if(minco<(zc-2*t)-1)
                    futuro <= Fr1;
                else
                    futuro <= M;             
            Fr1:
                futuro <= C3;
                
            M:
                if(write_enable==0)
                    futuro <= C1;
                else
                    futuro <= M;
            wd:
                futuro <= T;
            T:
                if(mem_output!=0)
                    futuro <= grad;
                else
                    futuro <= T;
            grad:
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
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b1;
                R11<= 1'b0;
                R12<= 1'b1;
                R13<= 1'b0;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b0;
                R18<= 1'b0;
                R19<= 1'b0;
                R20<= 1'b0;
                R21<= 1'b0;
                R22<= 1'b0;
                R23<= 1'b1;
                R24<= 1'b0;
                R25<= 1'b1;
                R26<= 1'b1;
                R27<= 1'b1;
                write_done <= 1'b0;
                dd <= 1'b0;   
            end
            Inicio2 : begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R8<= 1'b1;
                R9<= 1'b0;
                R10<= 1'b1;
                R11<= 1'b0;
                R12<= 1'b1;
                R13<= 1'b0;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b0;
                R18<= 1'b0;
                R19<= 1'b0;
                R20<= 1'b0;
                R21<= 1'b0;
                R22<= 1'b0;
                R23<= 1'b1;
                R24<= 1'b1;
                R25<= 1'b1;
                R26<= 1'b1;
                R27<= 1'b1;
                write_done <= 1'b0;
                dd <= 1'b0;   
            end                     
            Op1: begin
                R1 <= 1'b1;
                R2 <= 1'b0;
                R3 <= 1'b1;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R8<= 1'b1;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b0;
                R19<= 1'b1;
                R20<= 1'b0;
                R21<= 1'b0;
                R22<= 1'b0;
                R23<= 1'b1;
                R24<= 1'b1;
                R25<= 1'b1;
                R26<= 1'b1;
                R27<= 1'b1;
                write_done <= 1'b0;
                dd <= 1'b0;   
            end
            C1: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R8<= 1'b0;
                R9<= 1'b1;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b0;
                R15<= 1'b0;
                R16<= 1'b1;
                R17<= 1'b0;
                R18<= 1'b0;
                R19<= 1'b0;
                R20<= 1'b0;
                R21<= 1'b0;
                R22<= 1'b0;
                R23<= 1'b1;
                R24<= 1'b1;
                R25<= 1'b1;
                R26<= 1'b1;
                R27<= 1'b1;
                write_done <= 1'b0;
                dd <= 1'b0;   
            end
            C2: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b1;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b0;
                R18<= 1'b0;
                R19<= 1'b0;
                R20<= 1'b0;
                R21<= 1'b0;
                R22<= 1'b0;
                R23<= 1'b1;
                R24<= 1'b1;
                R25<= 1'b1;
                R26<= 1'b1;
                R27<= 1'b1;
                write_done <= 1'b0;
                dd <= 1'b0;   
            end
            C3: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R8<= 1'b1;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b1;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b0;
                R17<= 1'b0;
                R18<= 1'b1;
                R19<= 1'b0;
                R20<= 1'b0;
                R21<= 1'b0;
                R22<= 1'b0;
                R23<= 1'b1;
                R24<= 1'b1;
                R25<= 1'b1;
                R26<= 1'b1;
                R27<= 1'b1;
                write_done <= 1'b0;
                dd <= 1'b0;   
            end
            Fr1: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b1;
                R5 <= 1'b0;
                R8<= 1'b1;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b0;
                R18<= 1'b1;
                R19<= 1'b0;
                R20<= 1'b1;
                R21<= 1'b1;
                R22<= 1'b1;
                R22<= 1'b1;
                R23<= 1'b1;
                R24<= 1'b1;
                R25<= 1'b1;
                R26<= 1'b1;
                R27<= 1'b1;
                write_done <= 1'b0; 
                dd <= 1'b0;  
            end
            M: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b1;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b1;
                R15<= 1'b0;
                R16<= 1'b1;
                R17<= 1'b0;
                R18<= 1'b0;
                R19<= 1'b0;
                R20<= 1'b0;
                R21<= 1'b1;
                R22<= 1'b1;
                R23<= 1'b1;
                R24<= 1'b1;
                R25<= 1'b1;
                R26<= 1'b1;
                R27<= 1'b1;
                write_done <= 1'b0;
                dd <= 1'b0;   
            end
            temp6: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b0;
                R18<= 1'b0;
                R19<= 1'b0;
                R20<= 1'b0;
                R21<= 1'b1;
                R22<= 1'b1;
                R23<= 1'b1;
                R24<= 1'b1;
                R25<= 1'b1;
                R26<= 1'b1;
                R27<= 1'b1;
                write_done <= 1'b0;
                dd <= 1'b0; 
            end
            temp1:begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b0;
                R18<= 1'b0;
                R19<= 1'b0;
                R20<= 1'b0;
                R21<= 1'b0;
                R22<= 1'b1;
                R23<= 1'b1;
                R24<= 1'b1;
                R25<= 1'b1;
                R26<= 1'b1;
                R27<= 1'b1;
                write_done <= 1'b0;
                dd <= 1'b0;   
            end
            temp2:begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b0;
                R18<= 1'b0;
                R19<= 1'b0;
                R20<= 1'b0;
                R21<= 1'b0;
                R22<= 1'b1;
                R23<= 1'b1;
                R24<= 1'b1;
                R25<= 1'b1;
                R26<= 1'b1;
                R27<= 1'b1;
                write_done <= 1'b0;
                dd <= 1'b0;   
            end
            temp3:begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b0;
                R18<= 1'b0;
                R19<= 1'b0;
                R20<= 1'b0;
                R21<= 1'b0;
                R22<= 1'b1;
                R23<= 1'b1;
                R24<= 1'b1;
                R25<= 1'b1;
                R26<= 1'b1;
                R27<= 1'b1;
                write_done <= 1'b0;
                dd <= 1'b0;   
            end
            temp4:begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R8<= 1'b1;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b0;
                R18<= 1'b1;
                R19<= 1'b0;
                R20<= 1'b0;
                R21<= 1'b1;
                R22<=1'b1;
                R23<= 1'b1;
                R24<= 1'b1;
                R25<= 1'b1;
                R26<= 1'b1;
                R27<= 1'b1;
                write_done <= 1'b0;
                dd <= 1'b0;   
            end
            temp5:begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R8<= 1'b1;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b0;
                R18<= 1'b1;
                R19<= 1'b0;
                R20<= 1'b0;
                R21<= 1'b1;
                R22<=1'b1;
                R23<= 1'b1;
                R24<= 1'b1;
                R25<= 1'b1;
                R26<= 1'b1;
                R27<= 1'b1;
                write_done <= 1'b0;
                dd <= 1'b0;  
            end
            wd: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b0;
                R18<= 1'b0;
                R19<= 1'b0;
                R20<= 1'b0;
                R21<= 1'b1;
                R22<= 1'b1;
                R23<= 1'b1;
                R24<= 1'b1;
                R25<= 1'b1;
                R26<= 1'b1;
                R27<= 1'b1;
                write_done <= 1'b1; 
                dd <= 1'b0;  
            end
            T: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b0;
                R18<= 1'b0;
                R19<= 1'b0;
                R20<= 1'b0;
                R21<= 1'b1;
                R22<= 1'b1;
                R23<= 1'b0;
                R24<= 1'b0;
                R25<= 1'b0;
                R26<= 1'b1;
                R27<= 1'b1;
                write_done <= 1'b0;
                dd <= 1'b0;   
            end
            grad: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R8<= 1'b1;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b1;
                R18<= 1'b1;
                R19<= 1'b0;
                R20<= 1'b0;
                R21<= 1'b1;
                R22<= 1'b1;
                R23<= 1'b1;
                R24<= 1'b1;
                R25<= 1'b1;
                R26<= 1'b0;
                R27<= 1'b0;
                write_done <= 1'b0;
                dd <= 1'b0;   
            end
            salida: begin
                R1 <= 1'b0;
                R2 <= 1'b1;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b0;
                R8<= 1'b0;
                R9<= 1'b0;
                R10<= 1'b0;
                R11<= 1'b0;
                R12<= 1'b0;
                R13<= 1'b0;
                R14<= 1'b0;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b0;
                R18<= 1'b0;
                R19<= 1'b0;
                R20<= 1'b0;
                R21<= 1'b1;
                R22<= 1'b1;
                R23<= 1'b1;
                R24<= 1'b1;
                R25<= 1'b1;
                R26<= 1'b1;
                R27<= 1'b1;
                write_done <= 1'b0;
                dd <= 1'b1; 
            end
            default: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R3 <= 1'b0;
                R4 <= 1'b0;
                R5 <= 1'b1;
                R8<= 1'b1;
                R9<= 1'b0;
                R10<= 1'b1;
                R11<= 1'b0;
                R12<= 1'b1;
                R13<= 1'b0;
                R14<= 1'b1;
                R15<= 1'b1;
                R16<= 1'b1;
                R17<= 1'b0;
                R18<= 1'b0;
                R19<= 1'b0;
                R20<= 1'b0;
                R21<= 1'b0;
                R22<= 1'b1;
                R23<= 1'b0;
                R24<= 1'b1;
                R25<= 1'b1;
                R26<= 1'b1;
                R27<= 1'b0;
                write_done <= 1'b0;
                dd <= 1'b0;  
            end
      endcase
        
endmodule
