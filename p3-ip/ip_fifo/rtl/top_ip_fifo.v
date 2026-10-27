module top_ip_fifo(
    input           sys_clk,
    input           sys_rst_n,
    
    output          rd_empty,
    output          wr_en,
    output [7:0]    wr_data,
    output          wr_full,
    output [7:0]    rd_data,
    output          rd_en
);

wire        pll_lock;
wire        wr_clk;
wire        rd_clk;
wire [8:0]  wr_water_level;
wire [8:0]  rd_water_level;
wire        almost_empty;
wire        almost_full;
wire        rst_n;

assign rst_n = sys_rst_n & pll_lock;

pll_clk u_pll_clk(
  .pll_rst  (~sys_rst_n),      // input
  .clkin1   (sys_clk),        // input
  .pll_lock (pll_lock),    // output
  .clkout0  (wr_clk),      // output
  .clkout1  (rd_clk)       // output
);

async_fifo u_async_fifo(
  .wr_clk           (wr_clk),                    // input
  .wr_rst           (~rst_n),                    // input
  .wr_en            (wr_en),                      // input
  .wr_data          (wr_data),                  // input [7:0]
  .wr_full          (wr_full),                  // output
  .wr_water_level   (wr_water_level),    // output [8:0]
  .almost_full      (almost_full),          // output
  .rd_clk           (rd_clk),                    // input
  .rd_rst           (~rst_n),                    // input
  .rd_en            (rd_en),                      // input
  .rd_data          (rd_data),                  // output [7:0]
  .rd_empty         (rd_empty),                // output
  .rd_water_level   (rd_water_level),    // output [8:0]
  .almost_empty     (almost_empty)         // output
);

fifo_wr u_fifo_wr(
    .wr_clk         (wr_clk),
    .wr_rst_n       (rst_n),
    .wr_water_level (wr_water_level),
    .fifo_empty     (rd_empty),
    .wr_en          (wr_en),
    .wr_data        (wr_data)
);

fifo_rd u_fifo_rd(
    .rd_clk         (rd_clk),
    .rd_rst_n       (rst_n),
    .rd_water_level (rd_water_level),
    .fifo_full      (wr_full),
    .rd_data        (rd_data),
    .rd_en          (rd_en)
);

endmodule