`timescale 1ns/1ns

module tb_or_gate();

reg     A;
reg     B;

wire    Y;

initial begin
    A = 1'b1;
    B = 1'b1;
    #100
    A = 1'b0;
    B = 1'b1;
    #100
    A = 1'b1;
    B = 1'b0;
    #100
    A = 1'b0;
    B = 1'b0;
end

or_gate u_or_gate(
    .A(A),
    .B(B),
    
    .Y(Y)
);

endmodule