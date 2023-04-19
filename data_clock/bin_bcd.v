/*
输入：同步的din_vld和bin_in
输出：二进制bin的bcd格式bcd_out
*/
module bin_bcd(
	input clk,
	input rst_n,

	input	    [7:0]   bin_in,
	input               din_vld,
	output	reg [7:0]	bcd_out
    );
	
reg [7:0] bcd;

reg [7:0] bin_in_tem1;
reg [2:0]cnt;
wire add_cnt;
wire end_cnt;
reg flag_add;



//
always  @(posedge clk)begin
	if(!rst_n)begin
		bin_in_tem1 <= 0;
	end
	else if(din_vld )begin
		bin_in_tem1 <= bin_in;
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

always  @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		bcd_out <= 0;
	end
	if(rst_n && end_cnt)begin
		bcd_out <= bcd;
	end
end

//
always @(posedge clk)begin
	if(bcd[3:0] >= 4'd5)begin
		bcd[3:0] <= bcd[3:0]+3;
	end
end
always @(posedge clk)begin
	if(bcd[7:4] >= 4'd5)begin
		bcd[7:4] <= bcd[7:4]+3;
	end
end

always @(negedge clk or negedge rst_n) begin
	if(!rst_n)begin
		bcd <= 0;
	end
	else if(add_cnt )begin
		bcd	 <= {bcd[6:0],bin_in_tem1[7-cnt]};
	end
	else begin
		bcd <= 0;
	end
end
	
	

endmodule