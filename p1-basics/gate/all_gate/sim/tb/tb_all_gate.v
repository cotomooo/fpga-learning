`timescale 1ns/1ns
module tb_all_gate();

    reg     key1;
    reg     key2;
    
    wire    led1;
    wire    led2;
    wire    led3;
    
initial begin
    key1 = 1'b1;
    key2 = 1'b1;
    #100
    key1 = 1'b0;
    key2 = 1'b1;
    #100
    key1 = 1'b0;
    key2 = 1'b0;
    #100
    key1 = 1'b1;
    key2 = 1'b0;
end

all_gate u_all_gate(
    .key1(key1),
    .key2(key2),
    
    .led1(led1),
    .led2(led2),
    .led3(led3)
);

endmodule
    