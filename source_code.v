`timescale 1ns/1ps
/*
active high synchronous reset pin
clk - clock
Two states:
mainroad_state = 1'b0
crossroad_state = 1'b1
MG - main road green
MR - main road red
CG - cross road green
CR - cross road red
displayM - a, b, c, d, e, f, g for Main road (seven segment display)
displayC - a, b, c, d, e, f, g for cross road (seven segment display)
*/
module generate_1s(input clk, output clk_1s);
  reg [26:0]temp = 0;
  reg clk_temp = 1'b1;
  always @ (posedge clk)
begin
   temp = temp + 1;
   if(temp > 62500000) // 62500000
     begin
         clk_temp = ~clk_temp;
         temp <= 0;
     end
   else
     clk_temp = clk_temp;
end
  assign clk_1s = clk_temp;
endmodule
module traffic_light_contoller(input reset, clk, output clk_1s, output reg MG, MR, CG, CR, output reg [6:0]displayM, displayC);
  parameter [2:0]Mtimer = 3'b111; // 7
  parameter [2:0]Ctimer = 3'b101; // 5
 
 
  generate_1s Clock(clk, clk_1s);
 
  reg [2:0]Mcount, Ccount;
 
  reg present_state;
  reg next_state;
  reg mainroad_state = 1'b0;
  reg crossroad_state = 1'b1;
 
  always @ (posedge clk_1s)
begin
   if(reset == 1'b1)
     begin
       present_state <= mainroad_state;
       Mcount <= Mtimer;
       Ccount <= Ctimer;
     end
   else
     begin
     case(present_state)
       mainroad_state:
         begin
           Mcount <= Mcount - 1'b1;
           if(Mcount == 1'b0)
             begin
               present_state <= next_state;
               Mcount <= Mtimer;
             end
         end
       crossroad_state:
         begin
           Ccount <= Ccount - 1'b1;
           if(Ccount == 1'b0)
             begin
               present_state <= next_state;
               Ccount <= Ctimer;
             end
         end
     endcase
     end
end
always @(present_state)
begin
case(present_state)
   mainroad_state:
     begin
       MG = 1'b1;
       MR = 1'b0;
       CG = 1'b0;
       CR = 1'b1;
       next_state <= crossroad_state;
     end
   crossroad_state:
     begin
       MG = 1'b0;
       MR = 1'b1;
       CG = 1'b1;
       CR = 1'b0;
       next_state <= mainroad_state;
     end
endcase
end
 
  reg [6:0]tempM;
  reg [6:0]tempC;
 
  always @ (*)
begin
case(present_state)
     mainroad_state:
     begin
         tempM <= Mcount;
         tempC <= Mcount;
     end
     crossroad_state:
     begin
         tempC <= Ccount;
         tempM <= Ccount;
     end
endcase
end
always @ (*)
     begin
       case(tempM)
             3'b000: displayM = 7'b1111110;
             3'b001: displayM = 7'b0110000;
             3'b010: displayM = 7'b1101101;
             3'b011: displayM = 7'b1111001;
             3'b100: displayM = 7'b0110011;
             3'b101: displayM = 7'b1011011;
             3'b110: displayM = 7'b1011111;
             3'b111: displayM = 7'b1110000;     
       endcase
     end
 
   always @ (*)
   begin
    case(tempC)
         3'b000: displayC = 7'b1111110;
         3'b001: displayC = 7'b0110000;
         3'b010: displayC = 7'b1101101;
         3'b011: displayC = 7'b1111001;
         3'b100: displayC = 7'b0110011;
         3'b101: displayC = 7'b1011011;
         3'b110: displayC = 7'b1011111;
         3'b111: displayC = 7'b1110000;
     endcase
     end
endmodule
