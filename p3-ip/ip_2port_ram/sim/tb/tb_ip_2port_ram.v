`timescale 1ns/1ps

module tb_ip_2port_ram();

reg     grs_n;
GTP_GRS GRS_INST(
    .GRS_N  (grs_n)
);

initial begin
    grs_n <= 1'b0;
    #5000
    grs_n <= 1'b1;
end

reg     sys_clk;
reg     sys_rst_n;

wire [4:0]  wr_addr;
wire [7:0]  wr_data;
wire        wr_en;
wire [4:0]  rd_addr;
wire [7:0]  rd_data;

initial begin
    sys_clk <= 1'b0;
    sys_rst_n <= 1'b0;
    #201
    sys_rst_n <= 1'b1;
end

always #10 sys_clk <= ~sys_clk;

top_ip_2port_ram u_top_ip_2port_ram(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),
    .wr_addr    (wr_addr),
    .wr_data    (wr_data),
    .wr_en      (wr_en),
    .rd_addr    (rd_addr),
    .rd_data    (rd_data)
);

endmodule