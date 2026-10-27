module divider_4(
    input       sys_clk,
    input       sys_rst_n,
    
    output reg  out_clk
);

    reg     cnt;

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) 
        cnt <= 1'b0;
    else
        cnt <= ~cnt;
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        out_clk <= 1'b0;
    else if(cnt == 1'b1)
        out_clk <= ~out_clk;
end

endmodule