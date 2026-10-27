module edge_test(
    input   sys_clk,
    input   sys_rst_n,
    input   a,
    
    output  a_posedge,
    output  a_negedge,
    output  a_edge
);

reg     a_dly;

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        a_dly <= 1'b0;
    else
        a_dly <= a;
end

assign a_posedge = a & ~a_dly;
assign a_negedge = ~a & a_dly;
assign a_edge = a ^ a_dly;

endmodule