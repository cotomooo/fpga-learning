module two_key_beep(
    input       sys_clk,
    input       sys_rst_n,
    input [1:0] key_filter,
    
    output reg  beep
);

reg [1:0]   key_filter_d0;
wire [1:0]  negedge_key_filter;

assign negedge_key_filter = (~key_filter) & key_filter_d0;

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        key_filter_d0 <= 2'b11;
    else
        key_filter_d0 <= key_filter;
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        beep <= 1'b1;
    else if(negedge_key_filter[0] || negedge_key_filter[1])
        beep <= ~beep;
    else
        beep <= beep;
end

endmodule