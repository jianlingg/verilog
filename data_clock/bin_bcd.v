module bin_bcd(
	input clk,
	input rst_n,

	input	    [7:0]   bin_in,
	input               din_vld,
	output	reg [7:0]	bcd_out
    );
	
reg [3:0] one;
reg [3:0] ten;
//reg [1:0] hun;

reg [7:0] bin_in_tem;
reg [2:0]cnt;
wire add_cnt;
wire end_cnt;
reg flag_add;

//
always  @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		bin_in_tem <= 0;
	end
	else if(din_vld)begin
		bin_in_tem <= bin_in;
	end
end
//计数器
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		cnt <= 0;
	  end
	else if(add_cnt)begin
	  if(end_cnt)
		 cnt <= 0;
	  else
		 cnt <= cnt + 1;
	  end      
end

assign add_cnt = flag_add;
assign end_cnt = add_cnt && cnt == 8-1;

//加一条件
always  @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		flag_add <= 0;
	end
	else if(din_vld)begin
		flag_add <= 1;
	end
	else if(end_cnt)begin 
		flag_add <= 0;
	end
end

//
always @(negedge clk)begin
	if (one >= 4'd5 && add_cnt) 	one = one + 4'd3;
	if (ten >= 4'd5 && add_cnt) 	ten = ten + 4'd3;
end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n)begin
		one <= 0;
		ten <= 0;
	end
	else if(flag_add)begin
		ten	 <= {ten[2:0],one[3]};
		one	 <= {one[2:0],bin_in_tem[7-cnt]};
	end
end

//
always  @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		bcd_out <= 0;
	end
	if(end_cnt)begin
		bcd_out <= {ten, one};
	end
end
endmodule