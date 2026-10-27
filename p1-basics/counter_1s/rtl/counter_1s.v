module counter_1s(
    input               sys_clk,
    input               sys_rst_n,
    
    output reg [25:0]   cnt
);

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        cnt <= 26'd0;
    else if(cnt < 26'd49999999)
        cnt <= cnt + 26'd1;
    else
        cnt <= 26'd0;
end

endmodule