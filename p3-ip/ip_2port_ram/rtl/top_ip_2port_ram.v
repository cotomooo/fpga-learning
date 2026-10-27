module top_ip_2port_ram(
    input   sys_clk,
    input   sys_rst_n,
    
    output [4:0]    wr_addr,
    output [7:0]    wr_data,
    output          wr_en,
    output [4:0]    rd_addr,
    output [7:0]    rd_data
);

wire    rd_flag;
wire    rd_rst;

ram_2port u_ram_2port (
  .wr_data  (wr_data),    // input [7:0]
  .wr_addr  (wr_addr),    // input [4:0]
  .wr_en    (wr_en),        // input
  .wr_clk   (sys_clk),      // input
  .wr_rst   (~sys_rst_n),      // input
  .rd_addr  (rd_addr),    // input [4:0]
  .rd_data  (rd_data),    // output [7:0]
  .rd_clk   (sys_clk),      // input
  .rd_rst   (rd_rst)       // input
);

ram_wr u_ram_wr(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),
    .wr_data    (wr_data),    
    .wr_addr    (wr_addr),    
    .wr_en      (wr_en),        
    .rd_flag    (rd_flag)
);

ram_rd u_ram_rd(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),
    .rd_addr    (rd_addr),    // input [4:0]
    .rd_data    (rd_data),    // output [7:0]
    .rd_flag    (rd_flag),
    .rd_rst     (rd_rst)
);

endmodule