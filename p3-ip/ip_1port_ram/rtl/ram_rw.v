module ram_rw(
    input   sys_clk,
    input   sys_rst_n,
    
    output              ram_rw_en,
    output reg [4:0]    ram_addr,
    output reg [7:0]    ram_wr_data
);
reg [5:0]   rw_cnt;/*synthesis syn_preserve=1*/
reg         ram_en;/*synthesis syn_preserve=1*/

assign ram_rw_en = ((rw_cnt <= 6'd31) && ram_en) ? 1'b1 : 1'b0;

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        ram_en <= 1'b0;
    else
        ram_en <= 1'b1;
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        rw_cnt <= 6'd0;
    else begin
        if(rw_cnt < 6'd63 && ram_en)
            rw_cnt <= rw_cnt + 6'd1;
        else
            rw_cnt <= 6'd0;
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        ram_addr <= 5'd0;
    else begin
        if(ram_addr < 5'd31 && ram_en)
            ram_addr <= ram_addr + 5'd1;
        else
            ram_addr <= 5'd0;
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        ram_wr_data <= 8'd0;
    else begin
        if((rw_cnt < 5'd31) && ram_rw_en)
            ram_wr_data <= ram_wr_data + 8'd1;
        else
            ram_wr_data <= 8'd0;
    end
end

endmodule