`timescale 1ns/1ns

module tb_mux2_1();

    reg     in1;
    reg     in2;
    reg     sel;
    
    wire    out;
    
initial begin
    in1 = 1'b1;
    in2 = 1'b0;
    sel = 1'b1;
    #100
    in1 = 1'b1;
    in2 = 1'b0;
    sel = 1'b0;
    #100
    in1 = 1'b0;
    in2 = 1'b0;
    sel = 1'b1;
    #100
    in1 = 1'b0;
    in2 = 1'b0;
    sel = 1'b0;
    #100
    in1 = 1'b0;
    in2 = 1'b1;
    sel = 1'b1;
    #100
    in1 = 1'b0;
    in2 = 1'b1;
    sel = 1'b0;
end

mux2_1 u_mux2_1(
    .in1(in1),
    .in2(in2),
    .sel(sel),
    
    .out(out)
);

endmodule