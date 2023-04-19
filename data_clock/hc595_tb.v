`timescale 1ns / 1ns
module hc595_tb;
    //global clock
    reg            clk         ;
    reg            rst_n       ;

    //user interface
    reg [15:0] din;
    reg din_vld;
    wire shcp;
    wire stcp;
    wire ds;
    

    //ʱ�����ڣ���λΪns�����ڴ��޸�ʱ�����ڡ�
    parameter CYCLE    = 20;

    //��λʱ�䣬��ʱ��ʾ��λ3��ʱ�����ڵ�ʱ�䡣
    parameter RST_TIME = 3 ;

    //�����Ե�ģ������
    hc595 hc595_u(
    //global clock
    . clk(clk),
    . rst_n(rst_n),

    //user interface
    . din(din),
    . din_vld(din_vld),
    . shcp(shcp),
    . stcp(stcp),
    . ds(ds)
);


    //���ɱ���ʱ��50M
    initial clk = 1;
    always #(CYCLE/2) clk=~clk;
    

    //������λ�ź�
    initial begin
        rst_n = 1;
        #2;
        rst_n = 0;
        #(CYCLE*RST_TIME);
        rst_n = 1;
    end

    //���������ź�
    initial begin
        #2;
        din_vld = 0;
        din = 16'b1100_1111_1011_0010;
        #(CYCLE*100);
        din_vld = 1;
        #(CYCLE*1);
        din_vld = 0;
        #(CYCLE*1000);
        din = 16'd44;
        #(CYCLE*10000);
        

    end
endmodule