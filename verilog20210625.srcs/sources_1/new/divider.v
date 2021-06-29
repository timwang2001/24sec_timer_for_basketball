`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/25 19:54:11
// Design Name: 
// Module Name: divider
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


module divider(
    input CLK,//系统时钟
    input pau,//暂停
    input res,//重置
    output reg clk1s//输出1秒脉�??
    
    );
   
    //parameter update_interval = 100000000 / 100 - 1;  //100MHZ 分成 100HZ
    parameter update_interval = 50000000 - 1;//1�??
    integer selcnt;
    reg state;

    initial begin
    clk1s <= 0;
    //state <=0;
    end
    
    always @(posedge CLK,posedge pau,posedge res)  //100Hz
       begin
       if(res)
           begin
             state <= 1;
             selcnt <= 0;
             clk1s <= 0;
           end
       else if(pau)
            state =~state;
       else begin
            if(state)
                begin    
                    if (selcnt == update_interval)  //1�??
                    begin  
                        selcnt <= 0;  
                        clk1s =~clk1s;  //翻转
                    end
                    else
                        selcnt <= selcnt+1;
                end
            else
                selcnt <= selcnt+0;//暂停
            end         
   end

endmodule
