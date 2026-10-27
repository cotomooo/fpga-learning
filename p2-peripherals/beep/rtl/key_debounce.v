module key_debounce(
    input       sys_clk,
    input       sys_rst_n,
    input       key,
    
    output reg  key_filter
);

parameter CNT_MAX = 20'd100_0000;

reg         key_d0;
reg         key_d1;
reg [19:0]  cnt;

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        key_d0 <= 1'b1;
        key_d1 <= 1'b1;
    end
    else begin
        key_d0 <= key;
        key_d1 <= key_d0;
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        cnt <= 20'd0;
    else begin
        if(key_d0 != key_d1)
            cnt <= 20'd0;
        else begin
            if(cnt < (CNT_MAX - 20'd1))
                cnt <= cnt + 20'd1;
            else
                cnt <= cnt;
        end
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        key_filter <= 1'b1;
    else if(cnt == (CNT_MAX - 20'd1))
        key_filter <= key_d1;
    else
        key_filter <= key_filter;
end
  
endmodule      