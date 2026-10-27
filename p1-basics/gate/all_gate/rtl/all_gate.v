module all_gate(
    input   key1,
    input   key2,
    
    output  led1,
    output  led2,
    output  led3
);

and_gate u_and_gate(
    .A(key1),
    .B(key2),
    
    .Y(led1)
);

or_gate u_or_gate(
    .A(key1),
    .B(key2),
    
    .Y(led2)
);

not_gate u_not_gate(
    .A(key1),
    .Y(led3)
);

endmodule

