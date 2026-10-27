`timescale 1ns/1ns

module tb_led_repeat();

reg     key;
wire    led;

initial begin
    key <= 1'b1;
    
    #200
    key <= 1'b1;
    #1000
    key <= 1'b0;
    #600
    key <= 1'b1;
    #1000
    key <= 1'b0;
end

led_repeat u_led_repeat(
    .key    (key),
    .led    (led)
);
endmodule