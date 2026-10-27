`timescale 1ns/1ns
module tb_breath_led();

reg     sys_clk;
reg     sys_rst_n;
wire    led;

parameter CNT_2US_MAX = 7'd2;
parameter CNT_2MS_MAX = 10'd10;
parameter CNT_2S_MAX = 10'd10;

initial begin
    sys_clk <= 1'b0;
    sys_rst_n <= 1'b0;
    #201
    sys_rst_n <= 1'b1;
end

always #10 sys_clk <= ~sys_clk;

breath_led #(
    .CNT_2MS_MAX    (CNT_2MS_MAX),
    .CNT_2S_MAX     (CNT_2S_MAX),
    .CNT_2US_MAX    (CNT_2US_MAX)
)u_breath_led(
    .sys_clk        (sys_clk),
    .sys_rst_n      (sys_rst_n),
    .led            (led)
);

endmodule