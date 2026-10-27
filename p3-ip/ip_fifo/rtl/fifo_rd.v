module fifo_rd(
    input       rd_clk,
    input       rd_rst_n,
    input [8:0] rd_water_level,
    input       fifo_full,
    input [7:0] rd_data,
    
    output reg  rd_en
);

reg     full_d0;
reg     full_d1;

always@(posedge rd_clk or negedge rd_rst_n) begin
    if(!rd_rst_n) begin
        full_d0 <= 1'b0;
        full_d1 <= 1'b0;
    end
    else begin
        full_d0 <= fifo_full;
        full_d1 <= full_d0;
    end
end

always@(posedge rd_clk or negedge rd_rst_n) begin
    if(!rd_rst_n)
        rd_en <= 1'b0;
    else if(full_d1)
        rd_en <= 1'b1;
    else if(rd_water_level == 9'd1)
        rd_en <= 1'b0;
    else
        rd_en <= rd_en;
end

endmodule        