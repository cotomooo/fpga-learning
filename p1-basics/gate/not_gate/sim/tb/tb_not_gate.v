`timescale 1ns/1ns

module tb_not_gate();

reg     [3:0]   A;

wire    [3:0]   Y;

initial begin
    A = 4'b0000;
    #100
    A = 4'b1111;
    #100
    A = 4'b1001;
    #100
    A = 4'b1100;
    #100
    A = 4'b0011;
    #100
    A = 4'b0110;
end

not_gate u_not_gate(
    .A(A),
    
    .Y(Y)
);

endmodule