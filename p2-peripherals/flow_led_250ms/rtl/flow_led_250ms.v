module flow_led_250ms(
    input               sys_clk,
    input               sys_rst_n,
    
    output reg [3:0]    led
);

reg [23:0]  cnt;

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        cnt <= 24'd0;
    else if(cnt < (24'd12500000 - 24'd1))
        cnt <= cnt + 24'd1;
    else
        cnt <= 24'd0;
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        led <= 4'b1111;
    else if(cnt == (24'd12500000 - 24'd1))
        if(led == 4'b1111)
            led <= 4'b0000;
        else
            led <= 4'b1111;
    else
        led <= led;
end

endmodule