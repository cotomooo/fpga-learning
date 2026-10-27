module ip_1port_ram(
    input           sys_clk,
    input           sys_rst_n,
    
    output [7:0]    wr_data,
    output [7:0]    rd_data,
    output [4:0]    addr,
    output          wr_en
);



ram_rw u_ram_rw(
    .sys_clk        (sys_clk),
    .sys_rst_n      (sys_rst_n),
    .ram_wr_data    (wr_data),
    .ram_addr       (addr),
    .ram_rw_en      (wr_en)
);

ram_1port u_ram_1port(
  .wr_data  (wr_data),    // input [7:0]
  .addr     (addr),          // input [4:0]
  .wr_en    (wr_en),        // input
  .clk      (sys_clk),            // input
  .rst      (~sys_rst_n),            // input
  .rd_data  (rd_data)     // output [7:0]
);

endmodule