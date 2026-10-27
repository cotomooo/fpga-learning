`timescale 1ns/1ns

module tb_touch_led();

reg     sys_clk;
reg     sys_rst_n;
reg     touch_key;
wire    led;

initial begin
    sys_clk <= 1'b1;
    sys_rst_n <= 1'b0;
    touch_key <= 1'b0;
    #201
    sys_rst_n <= 1'b1;
    #40
    touch_key <= 1'b1;
    #40
    touch_key <= 1'b0;
    #40
    touch_key <= 1'b1;
    #40
    touch_key <= 1'b0;
    #40
    touch_key <= 1'b1;
    #40
    touch_key <= 1'b0;
end

always #10 sys_clk <= ~sys_clk;

touch_led u_touch_led(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .touch_key(touch_key),
    .led(led)
);

endmodule