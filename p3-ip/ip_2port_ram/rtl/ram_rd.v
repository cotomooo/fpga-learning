module ram_rd(
    input               sys_clk,
    input               sys_rst_n,
    input [7:0]         rd_data,
    input               rd_flag,
    
    output reg [4:0]    rd_addr,
    output              rd_rst
);

assign rd_rst = ~rd_flag;

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        rd_addr <= 5'd0;
    else begin
        if((rd_addr < 5'd31) && (!rd_rst))
            rd_addr <= rd_addr + 5'd1;
        else
            rd_addr <= 5'd0;
    end
end

endmodule