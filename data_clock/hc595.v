`timescale 1ns/1ns
/*ģ��˵��
74hc595оƬ��������һ����ת����оƬ������Э��Ϊ����SPI
*/
module hc595 (
    //global clock
    input clk,
    input rst_n,

    //user interface
    input [15:0]din,
    output shcp,
    output reg ds
);
reg [2:0]cnt;
wire add_cnt;
wire end_cnt;

// ��Ƶ��
//---------------------------------------------------------------------
    parameter div = 3;//��Ƶϵ��
    reg [div-1:0]cnt_div;
    wire add_cnt_div;
    wire end_cnt_div;

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_div <= 0;
          end
        else if(add_cnt_div)begin
          if(end_cnt_div)
             cnt_div <= 0;
          else
             cnt_div <= cnt_div + 1;
          end      
    end
  
    assign add_cnt_div = 1;
    assign end_cnt_div = add_cnt_div && cnt_div == {div{1'b1}};

    assign shcp = cnt_div[div-1];

    //������
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt <= 0;
          end
        else if(add_cnt)begin
          if(end_cnt)
             cnt <= 0;
          else
             cnt <= cnt + 1;
          end      
    end
    
    assign add_cnt = end_cnt_div;
    assign end_cnt = add_cnt && cnt == 16-1;

    //
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            ds <= 0;
        end
        else if(end_cnt_div)begin
            ds <= din[15-cnt];
        end
    end

   
    
    
endmodule