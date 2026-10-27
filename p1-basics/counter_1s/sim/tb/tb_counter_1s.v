`timescale 1ns/1ns
module tb_counter_1ns();

reg         sys_clk;
reg         sys_rst_n;
    
wire [25:0] cnt;
    
initial begin
    sys_clk = 1'b1;
    sys_rst_n <= 1'b0;
    #201
    sys_rst_n <= 1'b1;
end

always #10 sys_clk <= ~sys_clk;

counter_1s counter_1s_inst(
    .sys_clk    (sys_clk    ),
    .sys_rst_n  (sys_rst_n  ),
    
    .cnt        (cnt        )
);

endmodule