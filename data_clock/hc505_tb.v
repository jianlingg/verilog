`timescale 1ns / 1ns
module hc595_tb;
    //global clock
    reg            clk         ;
    reg            rst_n       ;

    //user interface
    reg [15:0] din;
    wire shcp;
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
    . shcp(shcp),
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
        din = 16'b1100_1111_1011_0011;
        #(CYCLE*10000);
        din = 16'd12;
        

    end
endmodule