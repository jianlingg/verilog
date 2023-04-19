`timescale 1ns/1ns
/*模块说明
74hc595芯片驱动，是一个串转并的芯片，所用协议为三线SPI
*/
module hc595 (
    //global clock
    input       clk,
    input       rst_n,

    //user interface
    input [15:0]din,
    input       din_vld,
    output      shcp,
    output reg  stcp,
    output reg  ds
);
reg [15:0] din_tmp;
reg [3:0]cnt;
wire add_cnt;
wire end_cnt;
reg flag_add;

//
always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        din_tmp <= 16'd0;
    end
    if(rst_n && din_vld)begin
        din_tmp <= din;
    end
end

// 分频器:end_cnt_div后是下降沿
//---------------------------------------------------------------------
    parameter div = 3;//分频系数
    reg [div-1:0]cnt_div;
    wire add_cnt_div;
    wire end_cnt_div;
    wire clk_neg = end_cnt_div;
    wire clk_pos = cnt_div[0]==1 && cnt_div[1]==1 && cnt_div[2]==0;

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
    
    
    //
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            stcp <= 0;
        end
        else if(!stcp && clk_neg && cnt == 0 && flag_add)begin
            stcp <= 1;
        end
        else if(stcp && clk_pos)begin
            stcp <= 0;
        end
    end

    //计数器
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
    
    assign add_cnt = end_cnt_div && flag_add;
    assign end_cnt = add_cnt && cnt == 16-1;

    //加一条件
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            flag_add <= 0;
        end
        else if(din_vld)begin
            flag_add <= 1;
        end
    end

    //
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            ds <= 0;
        end
        else if(end_cnt_div)begin
            ds <= din_tmp[15-cnt];
        end
    end

   
    
    
endmodule