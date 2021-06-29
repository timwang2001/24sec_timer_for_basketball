`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: wtr
// 
// Create Date: 2021/06/25 20:39:10
// Design Name: 
// Module Name: adder24
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


module adder24(
    input clk1s,
    input res,
    input pau,
    output [7:0] tim //输出时间
    ); 
    reg [3:0] tens = 0;//十位
    reg [3:0] units = 0;//个位
    reg block = 0;//24秒计时结束标志
    reg state_stop = 0;
    always@(negedge clk1s or posedge res)//24秒倒计时
        begin
            if(res)
                begin
                    tens <= 4'b0010;//2
                    units <= 4'b0100;//4
                    block <= 1'b0;
                end

            else begin
                if(!block && units != 0)
                begin
                    units <= units-1'b1;
                end

                else if(!block && units == 0 && tens != 0)//个位为0
                begin
                    tens <= tens -1'b1;
                    units <= 4'b1001;
                end

                else if(!block && units == 0 && tens == 0)//计时结束 
                begin
                    block <= 1'b1;
                end

                else if (block)//结束后闪灯
                begin
                    if(state_stop == 0)
                        begin
                          tens <= 4'b1010;//10 全灭
                          units <= 4'b1010; // 全灭
                          state_stop = ~state_stop;
                        end
                        
                    else
                        begin
                          tens <= 1'b0;// 显示0
                          units <= 1'b0;//显示0
                          state_stop = ~state_stop;
                        end                   
                end
            end
        end
    assign tim={tens,units};//拼接后输出
endmodule