//练习1 连线
module top_module( input in, output out );
	assign out =in;
endmodule

//练习2 连线
module top_module( 
    input a,b,c,
    output w,x,y,z );
    assign {w,x,y,z}= {a,b,b,c};
endmodule

//练习3 非门
module top_module( input in, output out );
	assign out = !in;
endmodule

//练习4 缩位与
module top_module( 
    input a, 
    input b, 
    output out );
    assign out = &{a,b};
endmodule

//练习4 缩位或非
module top_module( 
    input a, 
    input b, 
    output out );
    assign out = ~|{a,b};
endmodule

//练习4 缩位异或非
module top_module( 
    input a, 
    input b, 
    output out );
    assign out = ~^{a,b};
endmodule

//练习4 组合逻辑
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   );
    assign out = (a&b)|(c&d);
    assign out_n = ~out;
endmodule

//10_7458.v 组合逻辑7485
module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
    assign p1y = |{&{p1a,p1b,p1c},&{p1d,p1e,p1f}};
    assign p2y = |{&{p2a,p2b},&{p2c,p2d}};
endmodule

//11_Vector0.v 向量1
module top_module ( 
    input wire [2:0] vec,
    output wire [2:0] outv,
    output wire o2,
    output wire o1,
    output wire o0  ); // Module body starts after module declaration
	assign outv = vec;
    assign {o2,o1,o0} = vec;
endmodule

//12_7Vector1.v 向量赋值
module top_module( 
    input wire [15:0] in,
    output wire [7:0] out_hi,
    output wire [7:0] out_lo );
    assign {out_hi,out_lo} = in;
endmodule

//13_Vector2.v 向量赋值
module top_module( 
    input [31:0] in,
    output [31:0] out );//
    assign out = {in[7:0],in[15:8],in[23:16],in[31:24]};
    // assign out[31:24] = ...;
endmodule

//14_Vectorgates.v 向量2
module top_module( 
    input [2:0] a,
    input [2:0] b,
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);
    assign out_or_bitwise = a | b;
    assign out_or_logical = a || b;
    assign out_not = {~b,~a};
endmodule

//15_Gates4.v 门
module top_module( 
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    assign out_and = &in;
    assign out_or = |in;
    assign out_xor = ^in;
endmodule

//16_Vector3.v 向量3  
module top_module (
    input [4:0] a, b, c, d, e, f,
    output [7:0] w, x, y, z );//
    assign {w,x,y,z} = {a,b,c,d,e,f,2'b11};
endmodule

//17_Vectorr.v 向量，反转
module top_module( 
    input [7:0] in,
    output [7:0] out
);
    assign out = {in[0],in[1],in[2],in[3],in[4],in[5],in[6],in[7]};
endmodule

//18_Vector4.v 向量4 复制
/*
Examples:

{5{1'b1}}           // 5'b11111 (or 5'd31 or 5'h1f)
{2{a,b,c}}          // The same as {a,b,c,a,b,c}
{3'd5, {2{3'd6}}}   // 9'b101_110_110. It's a concatenation of 101 with
                    // the second vector, which is two copies of 3'b110.
*/
module top_module (
    input [7:0] in,
    output [31:0] out );
    assign out = {{24{in[7]}},in};
    // assign out = { replicate-sign-bit , the-input };
endmodule

//19_Vector5.v 向量5 f复制
module top_module (
    input a, b, c, d, e,
    output [24:0] out );//
    assign out = ~{ {5{a}}, {5{b}}, {5{c}},{5{d}},{5{e}} } ^ { 5{a,b,c,d,e} };

    // The output is XNOR of two vectors created by 
    // concatenating and replicating the five inputs.
    // assign out = ~{ ... } ^ { ... };

endmodule
