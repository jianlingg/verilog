`timescale 1ns/1ns
/*模块说明
数码管驱动，共阳极，动态
*/
module example (
    //global clock
    input clk,
    input rst_n,

    //user interface
    input [5:0] hour,
    input [5:0] minu,
    input [5:0] seco

    output [7:0] sel,
    output [7:0] seg,
);
    parameter num_0 = 0xc0,//0
	          num_1 = 0xf9,//1
	          num_2 = 0xa4,//2
	          num_3 = 0xb0,//3
	          num_4 = 0x99,//4
	          num_5 = 0x92,//5
	          num_6 = 0x82,//6
	          num_7 = 0xf8,//7
	          num_8 = 0x80,//8
	          num_9 = 0x90,//9
	          dian  = 0xfe,//.

//变量选择器
always  @(*)begin
   case(din)
      0:      begin          end
      1:      begin          end
      2:      begin          end
      default:begin          end
   endcase
end

//计数器 每段切换时间
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt0 <= 0;
      end
    else if(add_cnt0)begin
      if(end_cnt0)
         cnt0 <= 0;
      else
         cnt0 <= cnt0 + 1;
      end      
end

assign add_cnt0 = 1;
assign end_cnt0 = add_cnt0 && cnt0 ==15000-1;
    

    
endmodule