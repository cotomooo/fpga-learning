module two_key_debounce(
    input               sys_clk,
    input               sys_rst_n,
    input [1:0]         key,
    
    output reg [1:0]    key_filter
);

parameter CNT_MAX = 20'd100_0000;

reg [1:0]   key_d0;
reg [1:0]   key_d1;
reg [19:0]  cnt0;
reg [19:0]  cnt1;

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        key_d0 <= 2'b11;
        key_d1 <= 2'b11;
    end
    else begin
        key_d0 <= key;
        key_d1 <= key_d0;
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        cnt0 <= 20'd0;
    else if(key_d0[0] != key_d1[0])
        cnt0 <= 20'd0;
    else begin
        if(cnt0 < (CNT_MAX - 20'd1))
            cnt0 <= cnt0 + 20'd1;
        else
            cnt0 <= cnt0;
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        cnt1 <= 20'd0;
    else if(key_d0[1] != key_d1[1])
        cnt1 <= 20'd0;
    else begin
        if(cnt1 < (CNT_MAX - 20'd1))
            cnt1 <= cnt1 + 20'd1;
        else
            cnt1 <= cnt1;
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        key_filter <= 2'b11;
    else begin
        if(cnt0 == (CNT_MAX - 20'd1))
            key_filter[0] <= key_d1[0];
        else
            key_filter[0] <= key_filter[0];
        if(cnt1 == (CNT_MAX - 20'd1))
            key_filter[1] <= key_d1[1];
        else
            key_filter[1] <= key_filter[1];
    end
end

endmodule
        