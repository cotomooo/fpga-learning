`timescale 1ns/1ns

module tb_key_led();

reg         sys_clk;
reg         sys_rst_n;
reg [3:0]   key;

wire [3:0]  led;

initial begin
    sys_clk <= 1'b1;
    sys_rst_n <= 1'b0;
    key <= 4'b1111;
    #201
    sys_rst_n <= 1'b1;
    #1001
    key <= 4'b1110;
    #1001
    key <= 4'b1101;
    #1001
    key <= 4'b1011;
    #1001
    key <= 4'b0111;
    #1001
    key <= 4'b1111;
end

always #10 sys_clk <= ~sys_clk;

key_led key_led_inst(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),
    .key        (key),
    .led        (led)
);

endmodule
    