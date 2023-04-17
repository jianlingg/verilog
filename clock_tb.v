`timescale 1ns / 1ns
module clock_tb;
    //global clock
    reg            clk         ;
    reg            rst_n       ;

    //user interface
    reg [3:0]  key;
    wire [5:0] hour;
    wire [5:0] minu;
    wire [5:0] seco;
    

    //ʱ�����ڣ���λΪns�����ڴ��޸�ʱ�����ڡ�
    parameter CYCLE    = 20;

    //��λʱ�䣬��ʱ��ʾ��λ3��ʱ�����ڵ�ʱ�䡣
    parameter RST_TIME = 3 ;

    //�����Ե�ģ������
    clock clock_u(
    //global clock
    . clk(clk),
    . rst_n(rst_n),

    //user interface
    . key(key),

    . hour(hour),
    . minu(minu),
    . seco(seco)
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
        key = 4'b0000;
        #(CYCLE*10);
        key[2] = 1;
        #(CYCLE*1);
        key[2] = 0;
        #(CYCLE*100)
        key[3] = 1;
        #(CYCLE*1);
        key[3] = 0;
        #(CYCLE*10000000);
        

    end
endmodule