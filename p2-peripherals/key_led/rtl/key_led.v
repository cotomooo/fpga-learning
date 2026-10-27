module key_led(
    input               sys_clk,
    input               sys_rst_n,
    input [3:0]         key,
    
    output reg [3:0]    led
);

parameter   CNT_MAX = 25'd25000000;

reg [24:0]  cnt;
reg [1:0]   led_flag;
//counter
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        cnt <= 25'd0;
    else if(cnt < (CNT_MAX-25'd1))
        cnt <= cnt + 25'd1;
    else
        cnt <= 25'd0;
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        led_flag <= 2'd0;
    else if(cnt == (CNT_MAX-25'd1))
        led_flag <= led_flag + 2'd1;
    else
        led_flag <= led_flag;
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        led <= 4'b0000;
    else begin
        case(key)
            4'b1111 : led <= 4'b0000;
            4'b1110 : begin
                if(led_flag == 2'd0)
                    led <= 4'b0001;
                else if(led_flag == 2'd1)
                    led <= 4'b0010;
                else if(led_flag == 2'd2)
                    led <= 4'b0100;
                else
                    led <= 4'b1000;
            end
            4'b1101 : begin
                if(led_flag == 2'd0)
                    led <= 4'b1000;
                else if(led_flag == 2'd1)
                    led <= 4'b0100;
                else if(led_flag == 2'd2)
                    led <= 4'b0010;
                else
                    led <= 4'b0001;
            end
            4'b1011 : begin
                if(led_flag[0] == 1'b0)
                    led <= 4'b0000;
                else
                    led <= 4'b1111;
            end
            4'b0111 : led <= 4'b1111;
            default : ;
        endcase
    end
end

endmodule
        
        