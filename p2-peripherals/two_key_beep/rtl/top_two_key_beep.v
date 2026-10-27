module top_two_key_beep(
    input       sys_clk,
    input       sys_rst_n,
    input [1:0] key,
    
    output      beep
);

parameter CNT_MAX = 20'd100_0000;

wire [1:0]  key_filter;

two_key_debounce #(
    .CNT_MAX    (CNT_MAX)
) u_two_key_debounce(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),
    .key        (key),
    .key_filter (key_filter)
);

two_key_beep u_two_key_beep(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),
    .key_filter (key_filter),
    .beep       (beep)
);

endmodule