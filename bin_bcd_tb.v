`timescale 1ns / 1ps
 
module bin_bcd_tb();
    //global clock
    reg            clk         ;
    reg            rst_n       ;
	reg            rst_ns       ;
 
reg 	[7:0] bin_in;
reg           din_vld;
reg           din_vlds;
wire  	[9:0] bcd_out;

    //时钟周期，单位为ns，可在此修改时钟周期。
    parameter CYCLE    = 20;

    //复位时间，此时表示复位3个时钟周期的时间。
    parameter RST_TIME = 3 ;

    //生成本地时钟50M
    initial clk = 0;
    always #(CYCLE/2) clk=~clk;

	always  @(posedge clk)begin
		rst_ns <= rst_n;
		din_vlds <= din_vld;
	end

	//产生复位信号
    initial begin
        rst_n = 1;
        #2;
        rst_n = 0;
        #(CYCLE*RST_TIME);
        rst_n = 1;
    end
 

bin_bcd u_binary_bcd(
	.clk(clk),
	.rst_n(rst_ns),
	.bin_in (bin_in),
	.din_vld(din_vlds),
	.bcd_out(bcd_out)
);

initial begin
	bin_in = 8'd55; //十进制165
	din_vld = 0;
	#201;
	din_vld = 1;
	#(CYCLE*1);
	din_vld =0;
	#(CYCLE*100);
	bin_in = 8'b1111_0000; //十进制240
	#100;
	bin_in = 8'b1111_1111;	//十进制255
end
endmodule