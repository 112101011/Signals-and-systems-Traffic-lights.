`timescale 1ns/1ps
module test_bench;
  reg reset;
  reg clk;
  wire clk_1s;
  wire MG, MR, CG, CR;
  wire [6:0]displayM, displayC;
 
  traffic_light_contoller uut(reset, clk, clk_1s, MG, MR, CG, CR, displayM, displayC);
 
  initial
begin
   clk = 1'b1;
   reset = 1'b1;
   #2 reset = reset + 1'b1;
end
 
  always #1 clk = clk + 1'b1;
 
  initial
begin
   $dumpfile("dump.vcd"); $dumpvars;
end
 
  initial $monitor("reset = %b, clk = %b | clk_1s = %b MG = %b, MR = %b, CG = %b, CR = %b, displayM = %b, displayC = %b", reset, clk, clk_1s, MG, MR, CG, CR, displayM, displayC);
 
  initial #100 $finish;
endmodule
