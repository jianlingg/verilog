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

    //ʱ�����ڣ���λΪns�����ڴ��޸�ʱ�����ڡ�
    parameter CYCLE    = 20;

    //��λʱ�䣬��ʱ��ʾ��λ3��ʱ�����ڵ�ʱ�䡣
    parameter RST_TIME = 3 ;

    //���ɱ���ʱ��50M
    initial clk = 0;
    always #(CYCLE/2) clk=~clk;

	always  @(posedge clk)begin
		rst_ns <= rst_n;
		din_vlds <= din_vld;
	end

	//������λ�ź�
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
	bin_in = 8'd55; //ʮ����165
	din_vld = 0;
	#201;
	din_vld = 1;
	#(CYCLE*1);
	din_vld =0;
	#(CYCLE*100);
	bin_in = 8'b1111_0000; //ʮ����240
	#100;
	bin_in = 8'b1111_1111;	//ʮ����255
end
endmodule