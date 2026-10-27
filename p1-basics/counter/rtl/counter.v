module counter(
    input   sys_clk,
    input   sys_rst_n,
    
    output  reg [2:0] cnt
);

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        cnt <= 3'd0;
    else
        cnt <= cnt + 3'd1;
end

endmodule