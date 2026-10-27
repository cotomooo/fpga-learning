module fifo_wr(
    input               wr_clk,
    input               wr_rst_n,
    input [8:0]         wr_water_level,
    input               fifo_empty,
    
    output reg          wr_en,
    output reg [7:0]    wr_data
);

reg     empty_d0;
reg     empty_d1;

always@(posedge wr_clk or negedge wr_rst_n) begin
    if(!wr_rst_n) begin
        empty_d0 <= 1'b0;
        empty_d1 <= 1'b0;
    end
    else begin
        empty_d0 <= fifo_empty;
        empty_d1 <= empty_d0;
    end
end

always@(posedge wr_clk or negedge wr_rst_n) begin
    if(!wr_rst_n)
        wr_en <= 1'b0;
    else if(empty_d1)
        wr_en <= 1'b1;
    else if(wr_water_level == 9'd255)
        wr_en <= 1'b0;
    else
        wr_en <= wr_en;
end

always@(posedge wr_clk or negedge wr_rst_n) begin
    if(!wr_rst_n)
        wr_data <= 8'd0;
    else if((wr_data < 8'd255) && wr_en)
        wr_data <= wr_data + 8'd1;
    else
        wr_data <= 8'd0;
end

endmodule