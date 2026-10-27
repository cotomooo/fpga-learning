/*
module mux2_1(
    input   in1,
    input   in2,
    input   sel,
    
    output  out
);

assign out = (sel == 1'b1) ? in1 : in2;

endmodule
*/

/*
module mux2_1(
    input       in1,
    input       in2,
    input       sel,
    
    output reg  out
);

always@(*) begin
    if(sel == 1'b1)
        out <= in1;
    else
        out <= in2;
end

endmodule
*/


module mux2_1(
    input       in1,
    input       in2,
    input       sel,
    
    output reg  out
);

always@(*) begin
    case(sel)
        1'b1 :
            out <= in1;
        1'b0 :
            out <=in2;
        default: ;
    endcase
end

endmodule

