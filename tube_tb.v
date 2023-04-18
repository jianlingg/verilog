`timescale 1ns / 1ns
module tube_tb;
    //global clock
    reg            clk         ;
    reg            rst_n       ;

    //user interface
    reg [31:0] din;

    wire [7:0] sel;
    wire [7:0] seg;// seg[0]-a; seg[1]-b...

    //ʱ�����ڣ���λΪns�����ڴ��޸�ʱ�����ڡ�
    parameter CYCLE    = 20;

    //��λʱ�䣬��ʱ��ʾ��λ3��ʱ�����ڵ�ʱ�䡣
    parameter RST_TIME = 3 ;

    //�����Ե�ģ������
    tube tube_u(
    //global clock
    . clk(clk),
    . rst_n(rst_n),

    //user interface
    . din(din),

    . sel(sel),
    . seg(seg)// seg[0]-a; seg[1]-b...
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
  disp_tem = {8'h12 , 8'ha , 8'h12 , 8'ha , 8'h12};
    //���������ź�
    initial begin
        #2;
        din = 32'h0000_0000;
        #(CYCLE*10);
        din = 32'h12345678;
        #(CYCLE*10000);
        

    end
endmodule