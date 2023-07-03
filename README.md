# Files discription:


## Problem statement:
Implement a traffic light controller on Zybo. There is a highway and a crossroad, with a time counter, red and green traffic lights on each direction. When green light is on in one direction (say H: Highway), red is on in the other direction (say C: Crossroad), and the counter starts counting down from X to 0. Once the counter hits 0, the red traffic light should be on in H and green in C with the counter in C starting to count down from Y to 0. This should keep alternating. Come up with a nice state diagram, Verilog code at FSM abstraction and implement it on Zybo. <br/>
a) X and Y can be any number between 1 to 7. Use high value for highway counter and low value for crossroad counter to create more realistic scenario. <br/>
b) Take reset state to be highway green. <br/>
c) Use two 7-segment displays for displaying the counter values, red and green LEDs to display traffic lights. <br/>

## Description of approach:
X is taken as 7 and Y is taken as 5 here. There are two states as described in below picture <br/>
**State diagram:** <br/>
![image](https://github.com/112101011/Traffic-lights./assets/111628378/57755a5a-caf8-41ce-9b93-cf32af5aad6b)

First the reset pin will be clicked where highway green will be on, and both highway and crossroad count will be set to 7.and the next steps goes as follows: <br/>
Flow diagram: <br/>
![image](https://github.com/112101011/Traffic-lights./assets/111628378/2db2f7e2-1be4-4c05-af32-09b108f5013c)

Code, Port connections description:
1. In code module generate_1s is used to slow down the clock of zybo at L16 pin whose frequency is 125Mhz. That is done by counter. where the clk_1s is generated where for 62.5Mhz clk_1s is high and remaining 6.25MHz clk_1s is low.
2. The code is written such that whenever main road green is on cross road red will be on. And in both the signals the countdown goes from 7 to 0.
3. The code is written such that whenever cross road green is on main road red will be on. And in the both the signals the countdown goes from 5 to 0.
4. And this will repeat.

## Implementation in vivado software:
![image](https://github.com/112101011/Traffic-lights./assets/111628378/c63a03f4-5690-4598-89c7-e535d3b2fef3)

The following test bench is written to simulate some test cases: <br/>
![image](https://github.com/112101011/Traffic-lights./assets/111628378/e4993bf3-91ca-4ef3-b289-77dcdf3f25e7)

Port connections (Zybo board): <br/>
![image](https://github.com/112101011/Traffic-lights./assets/111628378/19232dd1-7d0e-4a77-8307-a5d417d92f90)

Schematic: <br/>
![image](https://github.com/112101011/Traffic-lights./assets/111628378/18eaa55a-7902-4d5c-a5f4-79e287756819)

## Timing diagrams:

![image](https://github.com/112101011/Traffic-lights./assets/111628378/a58851b7-1fd5-44a0-a973-efb43dc19241)

![image](https://github.com/112101011/Traffic-lights./assets/111628378/0b6f2122-f5dc-488c-8005-f95c3bb10e48)

Observations:
From simulations we can infer that:
1) Whenever highway green is ON, highway red and crossroad green will be OFF, crossroad red will be ON. With countdown from 7
to 0 on both the signals.(that can be inferred from 7 segment display outputs displayH, displayM.
2) Whenever crossroad green is ON, highway green and crossroad red will be OFF, highway red will be ON. With countdown from 5
to 0. (that can be inferred from 7 segment display outputs displayH, displayM.

## Zybo implementation:

Seven segment displays: <br/>
![image](https://github.com/112101011/Traffic-lights./assets/111628378/1e207c4f-5346-419f-be64-047b7d43108b)

The first two LED’s green and red are for highway, next two LED’s are for cross road. Yellow LED is clk_1s. <br/>
Mainroad_state:(highway green)
![image](https://github.com/112101011/Traffic-lights./assets/111628378/f4186258-5637-4358-8330-f66bd7daaea7)

Crossroad_state:(cross road green) <br/>
![image](https://github.com/112101011/Traffic-lights./assets/111628378/493b93b4-2a7c-43d2-a820-cb90932e5b66)

Observations:
1) Whenever the system is in mainroad state, Green LED of highway is glowing and red LED of cross road is glowing, remaining bulbs will are in OFF. With countdowns from 7 to 0 on both seven segment displays.
2) Whenever the system is in crossroad state, Green LED of crossroad is glowing and red LED of highway is glowing, remaining bulbs will are in OFF. With countdowns from 5 to 0 on both seven segment displays.
