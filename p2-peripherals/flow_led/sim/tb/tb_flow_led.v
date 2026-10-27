`timescale 1ns/1ns

module tb_flow_led();

reg         sys_clk;
reg         sys_rst_n;

wire [3:0]  led;

initial begin
    sys_clk = 1'b1;
    sys_rst_n <= 1'b0;
    #201
    sys_rst_n <= 1'b1;
end

always #10 sys_clk <= ~sys_clk;

flow_led flow_led_inst(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),
    
    .led        (led)
);

endmodule