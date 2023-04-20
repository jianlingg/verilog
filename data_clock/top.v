`timescale 1ns/1ns
/*模块说明
时钟顶层
*/
module top (
    //global clock
    input       clk,
    input       rst_n,

    //user interface
    input [3:0] key,
    output      shcp,
    output      stcp,
    output      ds

);
wire rst;
wire shu_hc5_dat_vld;
wire [31:0] clo_shu_dat;
wire [15:0] shu_hc5_dat;

 //---------------------------------------------------------------------
rst rst_u(
    //global clock
    . clk(clk),
    . rst_n(rst_n),

    //user interface
    . rst(rst)
);
clock clock_u(
    //global clock
    . clk(clk),
    . rst_n(rst),

    //user interface
    . key(key),

    . dout(clo_shu_dat)
);

shuma shuma_u(
    //global clock
    . clk(clk),
    . rst_n(rst),

    //user interface
    . din(clo_shu_dat),

    . dout(shu_hc5_dat),
    . dout_vld(shu_hc5_dat_vld)
);

hc595 hc595_u(
    //global clock
    . clk(clk),
    . rst_n(rst),

    //user interface
    . din(shu_hc5_dat),
    . din_vld(shu_hc5_dat_vld),
    . shcp(shcp),
    . stcp(stcp),
    . ds(ds)
);

    
endmodule