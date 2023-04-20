`timescale 1ns/1ns
/*模块说明
数码管驱动，共阳极，动态
*/
module shuma (
    //global clock
    input clk,
    input rst_n,

    //user interface
    input  [31:0] din,

    output [15:0] dout,
    output        dout_vld
);
   
   reg [7:0] sel;
   reg [7:0] seg;// seg[0]-a; seg[1]-b...
   assign  dout = {seg,sel};
   
    parameter num_0 = 8'b1100_0000,//0
	           num_1 = 8'b1111_1001,//1
	           num_2 = 8'b1010_0100,//2
	           num_3 = 8'b1011_0000,//3
	           num_4 = 8'b1001_1001,//4
	           num_5 = 8'b1001_0010,//5
	           num_6 = 8'b1000_0010,//6
	           num_7 = 8'b1111_1000,//7
	           num_8 = 8'b1000_0000,//8
	           num_9 = 8'b1001_0000,//9
	           dian  = 8'b1011_1111;//-

reg [15:0]cnt0;
wire add_cnt0;
wire end_cnt0;
reg [3:0]cnt1;
wire add_cnt1;
wire end_cnt1;

reg [15:0] douts [1:0];
assign dout_vld = douts[1] != douts[0];
always  @(posedge clk)begin
   douts[0] <= dout;
   douts[1] <= douts[0];
end


   
reg [3:0] disp_tem;

//变量选择器  位选,随着计数器运转，展示数据不断变化
always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        sel <= 8'b0000_0001;
    end
    else if(end_cnt0 && !end_cnt1)begin
        sel <= {sel[6:0],sel[7]};
    end
    else if(end_cnt1)begin
        sel <= 8'b0000_0001;
    end
end

//变量选择器  段选,随着计数器运转，展示数据不断变化
always  @(*)begin
   case(cnt1)
      0:      begin    disp_tem = din[ 3: 0];     end
      1:      begin    disp_tem = din[ 7: 4];     end
      2:      begin    disp_tem = din[11: 8];     end
      3:      begin    disp_tem = din[15:12];     end
      4:      begin    disp_tem = din[19:16];     end
      5:      begin    disp_tem = din[23:20];     end
      6:      begin    disp_tem = din[27:24];     end
      7:      begin    disp_tem = din[31:28];     end
      default:begin    disp_tem = 0         ;     end
   endcase
end


//变量选择器  段选
always  @(*)begin
   case(disp_tem)
      0:      begin    seg = num_0;     end
      1:      begin    seg = num_1;     end
      2:      begin    seg = num_2;     end
      3:      begin    seg = num_3;     end
      4:      begin    seg = num_4;     end
      5:      begin    seg = num_5;     end
      6:      begin    seg = num_6;     end
      7:      begin    seg = num_7;     end
      8:      begin    seg = num_8;     end
      9:      begin    seg = num_9;     end
      4'ha:   begin    seg = dian ;     end
      default:begin    seg = dian ;     end
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
assign end_cnt0 = add_cnt0 && cnt0 ==1250-1;//20000-1

//计数器1
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt1 <= 0;
      end
    else if(add_cnt1)begin
      if(end_cnt1)
         cnt1 <= 0;
      else
         cnt1 <= cnt1 + 1;
      end      
end

assign add_cnt1 = end_cnt0;
assign end_cnt1 = add_cnt1 && cnt1 == 8-1;

    
endmodule