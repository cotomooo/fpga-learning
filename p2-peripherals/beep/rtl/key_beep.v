module key_beep(
    input       sys_clk,
    input       sys_rst_n,
    input       key_filter,
    
    output reg  beep
);

reg     key_filter_d0;
wire    key_negedge;

assign key_negedge = (~key_filter) & key_filter_d0;

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        key_filter_d0 <= 1'b1;
    else
        key_filter_d0 <= key_filter;
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        beep <= 1'b1;
    else if(key_negedge == 1'b1)
        beep <= ~beep;
    else
        beep <= beep;
end

endmodule