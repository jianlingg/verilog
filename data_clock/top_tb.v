`timescale 1ns / 1ns
module top_tb;
    //global clock
    reg            clk         ;
    reg            rst_n       ;

    //user interface
    reg [3:0] key;
    wire shcp;
    wire stcp;
    wire ds;
    

    //时钟周期，单位为ns，可在此修改时钟周期。
    parameter CYCLE    = 20;

    //复位时间，此时表示复位3个时钟周期的时间。
    parameter RST_TIME = 3 ;

    //待测试的模块例化
    top top_u(
    //global clock
    . clk(clk),
    . rst_n(rst_n),

    //user interface
    . key(key),
    . shcp(shcp),
    . stcp(stcp),
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
        key = 4'b0000;
        #(CYCLE*10);
        key[2] = 1;
        #(CYCLE*100);
        key[2] = 0;
        #(CYCLE*100)
        key[3] = 1;
        #(CYCLE*100);
        key[3] = 0;
        #(CYCLE*100000);

    end
endmodule