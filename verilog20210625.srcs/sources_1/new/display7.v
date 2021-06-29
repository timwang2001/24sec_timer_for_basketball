`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: wtr
// 
// Create Date: 2021/06/25 18:43:47
// Design Name: 
// Module Name: display7
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


module display7(
    CLK,//系统时钟
    clk1s,//1秒时钟
    //input res,//复位
    tim,//输入时间
    block,
    display_out//输出的码
    );
    input CLK;
    input clk1s;
    input [7:0] tim;
    input block;
    output [10:0] display_out;
    
    reg [3:0] d;//第d个管
    reg [6:0] led;//
    reg [6:0] digit;//数
    reg [19:0]count=0;//分时
    reg [1:0] sel=0;//第sel个数码管
    parameter T1MS=10000;
    // always@(posedge CLK)
    //     begin
            
    //     end
    // end
    reg state =1;//管状态
    
    //always @(posedge clk1s)
    //begin 
    //    if(block==1)
    //    begin
    //        state = ~state;
    //    case(state)
    //            0:digit = 7'b0001000;//8 全亮
    //            1:digit = 7'b0001010;//10 全灭
    //    endcase
    //    case(sel)
    //            0:d = 7'b0001110;
    //            1:d = 7'b0001101;
    //    endcase
    //    end
    //end

    always @(*) begin
        if(block == 0)
            begin
                case(sel)
                0:begin d=4'b1110;digit=tim[3:0];end
                1:begin d=4'b1101;digit=tim[7:4] ;end
                endcase
            end
        else 

            begin
                
            end
    end

    always @(*)//显示段数
    begin
        case(digit)
        0:led=7'b0000001;
        1:led=7'b1001111;
        2:led=7'b0010010;
        3:led=7'b0000110;
        4:led=7'b1001100;
        5:led=7'b0100100;
        6:led=7'b0100000;
        7:led=7'b0001111;
        8:led=7'b0000000;
        9:led=7'b0000100;
        10:led=7'b1111111;
        // 'hA:led=7'b0001000;
        // 'hB:led=7'b1100000;
        // 'hC:led=7'b0110001;
        // 'hD:led=7'b1000010;
        // 'hE:led=7'b0110000;
        // 'hF:led=7'b0111000;
        default:led=7'b0000001;
        endcase
    end

    always@(posedge CLK)//四位数码管分时显示
        begin
            count = count+1;
            if(count==T1MS)
                begin
                    count = 0;
                    sel = sel+1;
                    if(sel==2)
                        sel = 0;
                end 
            if(block == 1)
                begin
//                    #100000000
                    state = 0;
                end
    end
    assign display_out={d,led};//reg 不能拼接 为啥
endmodule
