`timescale 1ns/1ns

module tb_decoder3_8();

reg         A;
reg         B;
reg         C;

wire [7:0]  out;

initial begin
    A = 0; B = 0; C = 0;
    #200
    A = 0; B = 0; C = 1;
    #200
    A = 0; B = 1; C = 0;
    #200
    A = 0; B = 1; C = 1;
    #200
    A = 1; B = 0; C = 0;
    #200
    A = 1; B = 0; C = 1;
    #200
    A = 1; B = 1; C = 0;
    #200
    A = 1; B = 1; C = 1;
end

decoder3_8 u_decoder3_8(
    .A(A),
    .B(B),
    .C(C),
    .out(out)
);

endmodule
    