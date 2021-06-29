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

    parameter ns2s = 1000000000;
    
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
    
    always begin
    #25*ns2s res = 1;
    #10 res = 0;
    end
    
    divider div(.CLK(CLK),
    .pau(pau),
    .res(res),
    .clk1s(clk1s));

    adder24 add(.clk1s(clk1s),
        .res(res),
        .pau(pau),
        .tim(tim) //输出时间
    );

endmodule
