`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: wtr
// 
// Create Date: 2021/06/25 21:10:46
// Design Name: 
// Module Name: basketball
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: ¶¥¶ËÄ£¿é
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module basketball(
    input CLK,
    input res,
    input pau,
    output [10:0] display_out
    );
    
    wire clk1s;
    wire [15:0] tim;

    divider dv(.CLK(CLK),.res(res),.pau(pau),.clk1s(clk1s));
    adder24 ad(.clk1s(clk1s),.res(res),.pau(pau),.tim(tim));
    display7 dp(.CLK(CLK),.clk1s(clk1s),.tim(tim),.display_out(display_out));
    
endmodule
