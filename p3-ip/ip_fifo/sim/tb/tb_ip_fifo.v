`timescale 1ns/1ps

module tb_ip_fifo();

reg     grs_n;

GTP_GRS GRS_INST(
    .GRS_N(grs_n)
);

initial begin
    grs_n <= 1'b0;
    #5000
    grs_n <= 1'b1;
end

reg     sys_clk;
reg     sys_rst_n;

wire        rd_empty;
wire        rd_en;
wire        wr_en;
wire        wr_full;
wire [7:0]  wr_data;
wire [7:0]  rd_data;

initial begin
    sys_clk <= 1'b0;
    sys_rst_n <= 1'b0;
    #201
    sys_rst_n <= 1'b1;
end

always #10 sys_clk <= ~sys_clk;

top_ip_fifo u_top_ip_fifo(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),
    .rd_empty   (rd_empty),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .wr_full    (wr_full),
    .wr_data    (wr_data),
    .rd_data    (rd_data)
);

endmodule