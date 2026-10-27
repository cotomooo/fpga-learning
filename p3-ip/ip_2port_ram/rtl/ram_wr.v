module ram_wr(
    input               sys_clk,
    input               sys_rst_n,
    
    output reg [4:0]    wr_addr,
    output reg [7:0]    wr_data,
    output reg          wr_en,
    output reg          rd_flag
);

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        wr_en <= 1'b0;
    else
        wr_en <= 1'b1;
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        wr_addr <= 5'd0;
    else begin
        if((wr_addr < 5'd31) && wr_en)
            wr_addr <= wr_addr + 5'd1;
        else
            wr_addr <= 5'd0;
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        wr_data <= 8'd0;
    else begin
        if((wr_addr < 5'd31) && wr_en)
            wr_data <= wr_data + 8'd1;
        else
            wr_data <= 8'd0;
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        rd_flag <= 1'b0;
    else if(wr_addr == 5'd15)
        rd_flag <= 1'b1;
    else
        rd_flag <= rd_flag;
end

endmodule