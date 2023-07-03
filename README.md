# Traffic-lights.

## Problem statement:
Implement a traffic light controller on Zybo. There is a highway and a crossroad, with a time counter, red and green traffic lights on each direction. When green light is on in one direction (say H: Highway), red is on in the other direction (say C: Crossroad), and the counter starts counting down from X to 0. Once the counter hits 0, the red traffic light should be on in H and green in C with the counter in C starting to count down from Y to 0. This should keep alternating. Come up with a nice state diagram, Verilog code at FSM abstraction and implement it on Zybo. <br/>
a) X and Y can be any number between 1 to 7. Use high value for highway counter and low value for crossroad counter to create more realistic scenario. <br/>
b) Take reset state to be highway green. <br/>
c) Use two 7-segment displays for displaying the counter values, red and green LEDs to display traffic lights. <br/>


## Description of approach:
X is taken as 7 and Y is taken as 5 here. There are two states as described in below picture <br/>
**State diagram:** <br/>
![image](https://github.com/112101011/Traffic-lights./assets/111628378/fbfdb097-058b-47f9-987c-66910eddf844)

First the reset pin will be clicked where highway green will be on, and both highway and crossroad count will be set to 7.and the next steps goes as follows: <br/>
Flow diagram: <br/>
![image](https://github.com/112101011/Traffic-lights./assets/111628378/31f25d6c-ae70-4e61-a9fa-d5741b1027d0)


