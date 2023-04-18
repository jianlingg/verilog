`timescale 1ns/1ns
/*模块说明
时钟顶层
*/
module top (
    //global clock
    input clk,
    input rst_n,

    //user interface

);
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

    . hour(hour),
    . minu(minu),
    . seco(seco),
    . hour_vld(hour_vld),
    . minu_vld(minu_vld),
    . seco_vld(seco_vld)
);

bin_bcd bin_bcd1(
	.clk(clk),
	.rst_n(rst),
	.bin_in (hour),
	.din_vld(hour_vld),
	.bcd_out(hour_bcd)
);

bin_bcd bin_bcd1(
	.clk(clk),
	.rst_n(rst),
	.bin_in (minu),
	.din_vld(minu_vld),
	.bcd_out(minu_bcd)
);

bin_bcd bin_bcd1(
	.clk(clk),
	.rst_n(rst),
	.bin_in (seco),
	.din_vld(seco_vld),
	.bcd_out(seco_bcd)
);

    
endmodule