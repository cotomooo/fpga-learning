module flow_led(
    input               sys_clk,
    input               sys_rst_n,
    
    output reg [3:0]    led
);

reg [24:0]  cnt;

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        cnt <= 25'd0;
    else if(cnt < 25'd24999999)
        cnt <= cnt + 25'd1;
    else
        cnt <= 25'd0;
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        led <= 4'b0001;
    else if(cnt == 25'd24999999)
    /*
        case (led)
            4'b0000: led <= 4'b0001;
            4'b0001: led <= 4'b0010;
            4'b0010: led <= 4'b0100;
            4'b0100: led <= 4'b1000;
            4'b1000: led <= 4'b0001;
            default: led <= 4'b0000;
        endcase
    */
        led <= {led[2:0],led[3]};
    else
        led <= led;
end

endmodule