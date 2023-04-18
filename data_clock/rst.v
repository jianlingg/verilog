`timescale 1ns/1ns
/*模块例化
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

//格雷码转二进制
module gray2bin
#(
	parameter	N  = 4						//数据位宽
)			
(			
    input	[N-1 : 0]	gray, 				//格雷码
    output 	[N-1 : 0]	bin	    			//二进制
); 
 
//从次高位到0，二进制的高位和次高位格雷码相异或
    genvar i;
    generate
        for(i = 0; i < N; i = i + 1) 
		begin: bin										//需要有名字
			assign bin[i] = gray[N-1 : i];
		end
    endgenerate
 
endmodule