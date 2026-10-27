module led_repeat(
    input key,
    output led
);

assign led=~key;

endmodule