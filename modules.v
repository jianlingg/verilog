//20_Module.v 例化
module top_module ( input a, input b, output out );
    mod_a u_mod_a(
        .in1(a),
        .in2(b),
        .out(out)
    );
endmodule

//21_Module_pos.v 按端口位置例化
module top_module ( 
    input a, 
    input b, 
    input c,
    input d,
    output out1,
    output out2
);
    mod_a u_mod_a(
        out1,out2,a,b,c,d
    );
endmodule

//22_Module_name.v 按端口名称例化
module top_module ( 
    input a, 
    input b, 
    input c,
    input d,
    output out1,
    output out2
);
    mod_a u_mod_a( .out1(out1), . out2(out2), . in1(a), . in2(b), . in3(c), . in4(d));

endmodule

//23_Module_shift.v  多次例化
module top_module ( input clk, input d, output q );
    wire q1,q2;
    my_dff my_dff1(.clk(clk), .d(d),  .q(q1) );
    my_dff my_dff2(.clk(clk), .d(q1), .q(q2) );
    my_dff my_dff3(.clk(clk), .d(q2), .q(q)  );
endmodule

//24_Module_shift8v.v 多次例化+选择器
module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    wire [7:0] q1, q2, q3;
    my_dff8 my_dff81(.clk(clk), .d(d),  .q(q1) );
    my_dff8 my_dff82(.clk(clk), .d(q1), .q(q2) );
    my_dff8 my_dff83(.clk(clk), .d(q2), .q(q3) );
    always @(*)begin
        case (sel)
     		 0:      begin    q=d;       end
     		 1:      begin    q=q1;      end
     		 2:      begin    q=q2;      end
             3:      begin    q=q3;      end
            default: begin    q=d;       end
        endcase
    end

endmodule
