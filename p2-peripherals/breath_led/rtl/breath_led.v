module breath_led(
    input       sys_clk,
    input       sys_rst_n,
    
    output reg  led
);

parameter CNT_2US_MAX = 7'd100;
parameter CNT_2MS_MAX = 10'd1000;
parameter CNT_2S_MAX = 10'd1000;

reg [6:0]   cnt_2us;
reg [9:0]   cnt_2ms;
reg [9:0]   cnt_2s;
reg         flag;

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        cnt_2us <= 7'd0;
    else if(cnt_2us < (CNT_2US_MAX - 7'd1))
        cnt_2us <= cnt_2us + 7'd1;
    else
        cnt_2us <= 7'd0;
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        cnt_2ms <= 10'd0;
    else if(cnt_2us == (CNT_2US_MAX - 7'd1) && cnt_2ms < (CNT_2MS_MAX - 10'd1))
        cnt_2ms <= cnt_2ms + 10'd1;
    else if(cnt_2us == (CNT_2US_MAX - 7'd1) && cnt_2ms == (CNT_2MS_MAX - 10'd1))
        cnt_2ms <= 10'd0;
    else
        cnt_2ms <= cnt_2ms;
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        cnt_2s <= 10'd0;
    else if(cnt_2us == (CNT_2US_MAX - 7'd1) && cnt_2ms == (CNT_2MS_MAX - 10'd1) && cnt_2s < (CNT_2S_MAX - 10'd1))
        cnt_2s <= cnt_2s + 10'd1;
    else if(cnt_2us == (CNT_2US_MAX - 7'd1) && cnt_2ms == (CNT_2MS_MAX - 10'd1) && cnt_2s == (CNT_2S_MAX - 10'd1))
        cnt_2s <= 10'd0;
    else
        cnt_2s <= cnt_2s;
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        flag <= 1'b0;
    else if(cnt_2us == (CNT_2US_MAX - 7'd1) && cnt_2ms == (CNT_2MS_MAX - 10'd1) && cnt_2s == (CNT_2S_MAX - 10'd1))
        flag <= ~flag;
    else
        flag <= flag;
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        led <= 1'b0;
    else if(!flag) begin
        if(cnt_2ms <= cnt_2s)
            led <= 1'b1;
        else
            led <= 1'b0;
    end
    else if(flag) begin
        if(cnt_2ms >= cnt_2s)
            led <= 1'b1;
        else
            led <= 1'b0;
    end
    else
        led <= led;
end

endmodule