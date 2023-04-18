`timescale 1ns / 1ns
module hc595_tb;
    //global clock
    reg            clk         ;
    reg            rst_n       ;

    //user interface
    reg [15:0] din;
    wire shcp;
    wire ds;
    

    //时钟周期，单位为ns，可在此修改时钟周期。
    parameter CYCLE    = 20;

    //复位时间，此时表示复位3个时钟周期的时间。
    parameter RST_TIME = 3 ;

    //待测试的模块例化
    hc595 hc595_u(
    //global clock
    . clk(clk),
    . rst_n(rst_n),

    //user interface
    . din(din),
    . shcp(shcp),
    . ds(ds)
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
        din = 16'b1100_1111_1011_0011;
        #(CYCLE*10000);
        din = 16'd12;
        

    end
endmodule