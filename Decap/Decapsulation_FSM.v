`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2023 19:30:37
// Design Name: 
// Module Name: Decapsulation_FSM
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


module Decapsulation_FSM(
    input clk, start,
    input [127:0] C, Cp,
    input [10:0]i, deg, j,
    input st, liftdone, liftNdone, Encapsulation_done,moddone1, mod3dcdone, mult_done, divdone, mult_done_rp, divdone_rp,
    output reg start_encap, startliftN,startlift,write_enable, startmod1,write_enablemDP, startdiv, startmult, startdiv_rp, startmult_rp, startmod3_dc,
    output reg Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, R1, R2, R3, R4, R5, R6, R7,R8,R9,R10,R11, R12,
    output reg Decapsulation_done
    );
    
    parameter Inicio  = 5'b00000;
    parameter multI=5'b00001;
    parameter As1=5'b00010;
    parameter As2= 5'b00011;
    parameter cI=5'b00100;
    parameter temp1 = 5'b00101;
    parameter mod1=5'b00110;
    parameter mant=5'b00111;
    parameter pregM=5'b01000;
    parameter tempM3 = 5'b01001;
    parameter Mod3decap=5'b01010;
    parameter mantM3=5'b01011;
    parameter pregM3=5'b01100; 
    parameter multIrp=5'b01101;
    parameter As1rp=5'b01110;
    parameter As2rp=5'b01111;
    parameter rpI=5'b10000;
    parameter lift=5'b11100;
    parameter tsmallI=5'b10110;
    parameter checkrp=5'b10111;
    parameter CHrp=5'b11000;
    parameter Mrp=5'b11001;
    parameter encap=5'b10001;
    parameter check_C=5'b10010;
    parameter T=5'b10011;
    parameter F=5'b10100;
    parameter salida =5'b10101;


    reg [5:0] presente = Inicio; // Registro de Estado - Valor inicial
    reg [5:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente,  deg, i, j, liftNdone, Encapsulation_done, moddone1, st, liftdone, mult_done, divdone, mult_done_rp, divdone_rp, mod3dcdone, start)
        case (presente)
            Inicio:
                if(start)
                    futuro <= multI;            
                else
                    futuro <= Inicio;
            multI:
                  if(mult_done)
                    futuro <= As1;            
                else
                    futuro <= multI;
            As1:
                futuro <= As2;
            As2:
                futuro <= cI;
            cI:
                if(divdone)
                    futuro <= temp1;
                else
                    futuro <= cI;
            temp1:
                futuro <= mod1;
            mod1:
                    futuro <= mant;
            mant:
                if(moddone1)
                    futuro <= pregM;
                else
                    futuro <= mant;
            pregM:
                if((i-1)>deg)
                    futuro <= tempM3;
                else
                    futuro <= mod1;
            tempM3:
                futuro <=Mod3decap;
            Mod3decap:
                    futuro <= mantM3;
            mantM3:
                if(mod3dcdone)
                    futuro <= pregM3;
                else
                    futuro <= mantM3;
            pregM3:
                if((j-1)>deg)
                    futuro <= multIrp;
                else
                    futuro <= Mod3decap;
            multIrp:
                  if(mult_done_rp)
                    futuro <= As1rp;            
                else
                    futuro <= multIrp;
            As1rp:
                futuro <= As2rp;
            As2rp:
                futuro <= rpI;
            rpI:
                if(divdone_rp)
                    futuro <= lift;
                else
                    futuro <= rpI;
            lift:
                if(liftNdone)
                    futuro <= tsmallI;
                else
                    futuro <= lift;
            tsmallI:
                if(liftdone)
                    futuro <= checkrp;
                else
                    futuro <= tsmallI;
            checkrp:
                if(st)
                    futuro <= Mrp;
                else
                    futuro <= CHrp;
            CHrp:
                if(Encapsulation_done)
                    futuro <= check_C;
                else
                    futuro <= CHrp;
            Mrp:
                futuro <= encap;
            encap:
                if(Encapsulation_done)
                    futuro <= check_C;
                else
                    futuro <= encap; 
            check_C:
                 if(C==Cp)
                    futuro <= T;
                else
                    futuro <= F; 
            T:
                futuro <=salida;
            F:
                futuro <=salida;    
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
                R2 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b0;
                R10 <=1'b0;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b0;
                Q4<=1'b0;
                Q5<=1'b0;
                Q6<=1'b0;
                Q7<=1'b0;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startliftN<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            multI: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b0;
                Q4<=1'b0;
                Q5<=1'b0;
                Q6<=1'b0;
                Q7<=1'b0;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b1;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            As1: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b1;
                Q4<=1'b1;
                Q5<=1'b0;
                Q6<=1'b0;
                Q7<=1'b0;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b1;                
                Decapsulation_done <= 1'b0;
            end
            As2: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b1;
                Q4<=1'b1;
                Q5<=1'b0;
                Q6<=1'b0;
                Q7<=1'b0;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b1;                
                Decapsulation_done <= 1'b0;
            end                 
            cI: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b0;
                Q4<=1'b1;
                Q5<=1'b0;
                Q6<=1'b1;
                Q7<=1'b0;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b1;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            temp1: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b1;
                Q4<=1'b0;
                Q5<=1'b0;
                Q6<=1'b0;
                Q7<=1'b0;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            mod1: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b0;
                R3<= 1'b0;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b1;
                Q4<=1'b0;
                Q5<=1'b0;
                Q6<=1'b0;
                Q7<=1'b0;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b1;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            mant: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b0;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b1;
                Q4<=1'b0;
                Q5<=1'b0;
                Q6<=1'b0;
                Q7<=1'b0;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            pregM: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b0;
                R4<= 1'b1;
                R3<= 1'b0;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b1;
                Q4<=1'b0;
                Q5<=1'b0;
                Q6<=1'b0;
                Q7<=1'b0;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b1;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            tempM3: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b1;
                Q4<=1'b0;
                Q5<=1'b0;
                Q6<=1'b0;
                Q7<=1'b0;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b1;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            Mod3decap: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b0;
                R3<= 1'b0;
                R8<= 1'b1;
                R9 <=1'b0;
                R10 <=1'b1;
                R11 <=1'b1;
                R12 <=1'b0;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b1;
                Q4<=1'b0;
                Q5<=1'b0;
                Q6<=1'b0;
                Q7<=1'b0;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b1;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b1;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            mantM3: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b1;
                Q4<=1'b0;
                Q5<=1'b0;
                Q6<=1'b0;
                Q7<=1'b0;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            pregM3: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b0;
                R4<= 1'b1;
                R3<= 1'b0;
                R8<= 1'b1;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b1;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b1;
                Q4<=1'b0;
                Q5<=1'b0;
                Q6<=1'b0;
                Q7<=1'b0;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b1;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            multIrp: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b0;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b0;
                Q7<=1'b0;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b1;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            As1rp: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b0;
                Q3<=1'b1;
                Q4<=1'b1;
                Q5<=1'b0;
                Q6<=1'b0;
                Q7<=1'b0;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b1;                
                Decapsulation_done <= 1'b0;
            end
            As2rp: begin
                R1 <= 1'b0;
                R2 <= 1'b0;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b0;
                Q3<=1'b1;
                Q4<=1'b1;
                Q5<=1'b0;
                Q6<=1'b0;
                Q7<=1'b0;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b1;                
                Decapsulation_done <= 1'b0;
            end                 
            rpI: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b1;
                Q7<=1'b1;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b1;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            lift: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b1;
                Q7<=1'b1;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b1;
                startliftN<=1'b1;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            tsmallI: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b1;
                Q7<=1'b1;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b1;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            checkrp: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b1;
                Q7<=1'b1;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            CHrp: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
               Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b1;
                Q7<=1'b1;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b1;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b1;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            Mrp: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b1;
                Q7<=1'b1;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b1;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            encap: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b1;
                Q7<=1'b1;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b1;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b1;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            check_C: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b1;
                Q7<=1'b1;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b1;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            T: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b1;
                Q7<=1'b1;
                Q8<=1'b1;
                Q9<=1'b0;
                Q10<=1'b1;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            F: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b0;
                Q4<=1'b0;
                Q5<=1'b0;
                Q6<=1'b0;
                Q7<=1'b0;
                Q8<=1'b0;
                Q9<=1'b1;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
            salida: begin
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b1;
                R7 <= 1'b1;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b1;
                R10 <=1'b1;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b1;
                Q2<=1'b1;
                Q3<=1'b1;
                Q4<=1'b1;
                Q5<=1'b1;
                Q6<=1'b1;
                Q7<=1'b1;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b1;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b1;
            end
            
            default: begin 
                R1 <= 1'b1;
                R2 <= 1'b1;
                R6 <= 1'b0;
                R7 <= 1'b0;
                R5<= 1'b1;
                R4<= 1'b1;
                R3<= 1'b1;
                R8<= 1'b0;
                R9 <=1'b0;
                R10 <=1'b0;
                R11 <=1'b0;
                R12 <=1'b0;
                Q1<=1'b0;
                Q2<=1'b0;
                Q3<=1'b0;
                Q4<=1'b0;
                Q5<=1'b0;
                Q6<=1'b0;
                Q7<=1'b0;
                Q8<=1'b0;
                Q9<=1'b0;
                Q10<=1'b0;
                Q11<=1'b0;
                Q12<=1'b0;
                startliftN<=1'b0;
                write_enable<=1'b0;
                startmod1 <= 1'b0;
                start_encap <= 1'b0;
                startlift<=1'b0;
                startmult_rp<=1'b0;
                startdiv_rp<=1'b0;
                startmod3_dc<=1'b0;
                startmult<=1'b0;
                startdiv <= 1'b0;
                write_enablemDP<=1'b0;                
                Decapsulation_done <= 1'b0;
            end
      endcase
endmodule
