module divider_7(
    input   sys_clk,
    input   sys_rst_n,
    
    output  out_clk
);

parameter N = 7;
parameter EDGE = N/2-1;

reg [2:0]   cnt;
reg         out_clk1;
reg         out_clk2;

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        cnt <= 3'd0;
    else if(cnt == N-1)
        cnt <= 3'd0;
    else
        cnt <= cnt + 3'd1;
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        out_clk1 <= 1'b0;
    else if(cnt <= EDGE)
        out_clk1 <= 1'b0;
    else
        out_clk1 <= 1'b1;
end

always@(negedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        out_clk2 <= 1'b0;
    else if(cnt <= EDGE)
        out_clk2 <= 1'b0;
    else
        out_clk2 <= 1'b1;
end

assign out_clk = out_clk1 & out_clk2;

endmodule