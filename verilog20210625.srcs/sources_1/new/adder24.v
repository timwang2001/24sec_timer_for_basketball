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
    output [7:0] tim //���ʱ��
    ); 
    reg [3:0] tens = 0;//ʮλ
    reg [3:0] units = 0;//��λ
    reg block = 0;//24���ʱ������־
    reg state_stop = 0;
    always@(negedge clk1s or posedge res)//24�뵹��ʱ
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

                else if(!block && units == 0 && tens != 0)//��λΪ0
                begin
                    tens <= tens -1'b1;
                    units <= 4'b1001;
                end

                else if(!block && units == 0 && tens == 0)//��ʱ���� 
                begin
                    block <= 1'b1;
                end

                else if (block)//����������
                begin
                    if(state_stop == 0)
                        begin
                          tens <= 4'b1010;//10 ȫ��
                          units <= 4'b1010; // ȫ��
                          state_stop = ~state_stop;
                        end
                        
                    else
                        begin
                          tens <= 1'b0;// ��ʾ0
                          units <= 1'b0;//��ʾ0
                          state_stop = ~state_stop;
                        end                   
                end
            end
        end
    assign tim={tens,units};//ƴ�Ӻ����
endmodule