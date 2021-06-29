`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Anakin
// 
// Create Date: 2021/06/26 09:23:05
// Design Name: 
// Module Name: simu
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


module simu(

    );
    reg CLK;
    reg pau;
    reg res;
    wire clk1s;
    wire [7:0] tim;
    wire [10:0] display_out;
    
    initial begin
    pau = 0;
    res = 1;
    CLK = 0;
    #50
    res = 0;
    end
    
    
    
    always begin
    #10 CLK = ~CLK;
    end
    
    /*always begin
    #10000000
    pau <= 1;
    #10
    pau <= 0;
    end */
    
    divider div(.CLK(CLK),
    .pau(pau),
    .res(res),
    .clk1s(clk1s));

    adder24 add(.clk1s(clk1s),
        .res(res),
        .pau(pau),
        .tim(tim) //Êä³öÊ±¼ä
    );
    
    display7 dp(.CLK(CLK),
        .tim(tim),
        .display_out(display_out)
    );
        

endmodule
