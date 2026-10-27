module ip_pll(
    input   sys_clk,
    input   sys_rst_n,
    
    output  clk_100m,
    output  clk_100m_180deg,
    output  clk_50m,
    output  clk_25m
);

wire    pll_lock;

pll_clk u_pll_clk(
    .pll_rst    (~sys_rst_n),      // input
    .clkin1     (sys_clk),        // input
    .pll_lock   (pll_lock),    // output
    .clkout0    (clk_100m),      // output
    .clkout1    (clk_100m_180deg),      // output
    .clkout2    (clk_50m),      // output
    .clkout3    (clk_25m)       // output
);

endmodule