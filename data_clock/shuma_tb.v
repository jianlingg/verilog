`timescale 1ns / 1ns
module shuma_tb;
    //global clock
    reg            clk         ;
    reg            rst_n       ;

    //user interface
    reg [31:0] din;

    wire [15:0] dout;

    //时钟周期，单位为ns，可在此修改时钟周期。
    parameter CYCLE    = 20;

    //复位时间，此时表示复位3个时钟周期的时间。
    parameter RST_TIME = 3 ;

    //待测试的模块例化
    shuma shuma_u(
    //global clock
    . clk(clk),
    . rst_n(rst_n),

    //user interface
    . din(din),

    . dout(dout),
    . dout_vld(dout_vld)
);


    //生成本地时钟50M
    initial clk = 1;
    always #(CYCLE/2) clk=~clk;
    

    //产生复位信号
    initial begin
        rst_n = 1;
        #2;
        rst_n = 0;
        #(CYCLE*RST_TIME);
        rst_n = 1;
    end
 
    //产生输入信号
    initial begin
        #2;
        din = 32'h0000_0000;
        #(CYCLE*10);
        din = 32'h12345678;
        #(CYCLE*10000);
        

    end
endmodule