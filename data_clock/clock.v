`timescale 1ns/1ns
/*模块说明
这是一个时钟模块，输出时分秒，输入按键
key3控制设置，和计时的状态切换
在设置状态下：key2,1,0分别控制时分秒，按一下，加一下
*/
module clock (
    //global clock
    input        clk,
    input        rst_n,

    //user interface
    input  [3:0] key,

    output [31:0] dout
);

    wire [7:0] hour;
    wire [7:0] minu;
    wire [7:0] seco;
    wire  hour_vld;
    wire  minu_vld;
    wire  seco_vld;
    wire [7:0] hour_bcd;
    wire [7:0] minu_bcd;
    wire [7:0] seco_bcd;
    

    assign dout = {hour_bcd , 4'ha ,minu_bcd , 4'ha , seco_bcd};


reg [25:0]cnt0;
wire add_cnt0;
wire end_cnt0;
reg [7:0]cnt1;
wire add_cnt1;
wire end_cnt1;
reg [7:0]cnt2;
wire add_cnt2;
wire end_cnt2;
reg [7:0]cnt3;
wire add_cnt3;
wire end_cnt3;

reg [1:0] state_c, state_n;
wire set_to_tim_start ;
wire tim_to_set_start ;

reg  [7:0] hours [1:0];
reg  [7:0] minus [1:0];
reg  [7:0] secos [1:0];
wire hchage;
wire mchage;
wire schage;

localparam  set = 1;
localparam  tim = 2;


wire [3:0] key_vld;
//---------------------------------------------------------------------
 genvar i;
     generate
         for(i=0; i<4; i=i+1) begin:BLOCK1
            key key_u(
                //global clock
                . clk(clk),
                . rst_n(rst_n),

                //use interface
                . key(key[i]),
                . key_vld(key_vld[i])
            );      
        end
     endgenerate
//---------------------------------------------------------------------
    bin_bcd bin_bcd_h(
    	.clk(clk),
    	.rst_n(rst_n),
    
    	.bin_in (hour),
    	.din_vld(hour_vld),
    
    	.bcd_out(hour_bcd)
    );
    
    bin_bcd bin_bcd_m(
    	.clk(clk),
    	.rst_n(rst_n),
    
    	.bin_in (minu),
    	.din_vld(minu_vld),
    
    	.bcd_out(minu_bcd)
    );
    
    bin_bcd bin_bcd_s(
    	.clk(clk),
    	.rst_n(rst_n),
    
    	.bin_in (seco),
    	.din_vld(seco_vld),
    
    	.bcd_out(seco_bcd)
    );


assign {hour,minu,seco} = {cnt3,cnt2,cnt1};
assign {hour_vld,minu_vld,seco_vld} = {hchage,mchage,schage};


assign hchage = hours[1] != hours[0];
always  @(posedge clk)begin
    hours[0] <= cnt3;
    hours[1] <= hours[0];
end


assign mchage = minus[1] != minus[0];
always  @(posedge clk)begin
    minus[0] <= cnt2;
    minus[1] <= minus[0];
end

assign schage = secos[1] != secos[0];
always  @(posedge clk)begin
    secos[0] <= cnt1;
    secos[1] <= secos[0];
end


always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        state_c <= set ;
    else
        state_c <= state_n;
end

always @(*) begin
    case(state_c)
        set :begin
            if(set_to_tim_start)
                state_n = tim ;
            else
                state_n = state_c ;
        end
        tim :begin
            if(tim_to_set_start)
                state_n = set ;
            else
                state_n = state_c ;
        end
        default : state_n = set ;
    endcase
end

assign set_to_tim_start = state_c==set && (key_vld[3]);
assign tim_to_set_start = state_c==tim && (key_vld[3]);



//计数器0 seco
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt0 <= 0;
          end
        else if(add_cnt0)begin
          if(end_cnt0)
             cnt0 <= 0;
          else 
             cnt0 <= cnt0 + 1;
          end      
    end

assign add_cnt0 = state_c == tim;
assign end_cnt0 = add_cnt0 && cnt0 == 50_000-1;//50_000_000-1

//计数器1 minu
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt1 <= 0;
          end
        else if(add_cnt1)begin
          if(end_cnt1)
             cnt1 <= 0; 
          else
             cnt1 <= cnt1 + 1; 
        end
    end

assign add_cnt1 = end_cnt0 || key_vld[0] == 1;
assign end_cnt1 = add_cnt1 && cnt1 == 60-1;

//计数器2 hour
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt2 <= 0;
          end
        else if(add_cnt2)begin
          if(end_cnt2)
             cnt2 <= 0;
          else
             cnt2 <= cnt2 + 1;     
        end
    end

assign add_cnt2 = end_cnt1 || key_vld[1] == 1;
assign end_cnt2 = add_cnt2 && cnt2 == 60-1;

//计数器3 day
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt3 <= 0;
          end
        else if(add_cnt3)begin
          if(end_cnt3)
             cnt3 <= 0;
          else
             cnt3 <= cnt3 + 1;     
        end
    end

assign add_cnt3 = end_cnt2 || key_vld[2] == 1;
assign end_cnt3 = add_cnt3 && cnt3 == 24-1;
    
endmodule