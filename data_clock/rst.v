`timescale 1ns/1ns
/*ģ������
rst rst_u(
    //global clock
    . clk(clk),
    . rst_n(rst_n),

    //user interface
    . rst(rst)
);
*/
module rst (
    //global clock
    input clk,
    input rst_n,

    //user interface
    output reg rst
);
reg rst1;
//
always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        rst1 <= 0;
        rst  <= 0;
    end
    else begin
        rst1 <= 1;
        rst  <= rst1;
    end  
end
    
endmodule

//������ת������
module gray2bin
#(
	parameter	N  = 4						//����λ��
)			
(			
    input	[N-1 : 0]	gray, 				//������
    output 	[N-1 : 0]	bin	    			//������
); 
 
//�Ӵθ�λ��0�������Ƶĸ�λ�ʹθ�λ�����������
    genvar i;
    generate
        for(i = 0; i < N; i = i + 1) 
		begin: bin										//��Ҫ������
			assign bin[i] = gray[N-1 : i];
		end
    endgenerate
 
endmodule