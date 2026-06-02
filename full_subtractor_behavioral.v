module full_subtractor(
    input a,
    input b,
    input c,
    output reg diff,
    output reg borrow
);

always @(*) begin
    diff = a ^ b ^ c;
    borrow = (~a & b) | (~a & c) | (b & c);
end

endmodule

module test;

reg a, b, c;
wire diff, borrow;

full_subtractor dut(
    .a(a),
    .b(b),
    .c(c),
    .diff(diff),
    .borrow(borrow)
);

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,test);

    $monitor("a=%b b=%b c=%b diff=%b borrow=%b",
              a,b,c,diff,borrow);

    a=0; b=0; c=0; #10;
    a=0; b=0; c=1; #10;
    a=0; b=1; c=0; #10;
    a=0; b=1; c=1; #10;
    a=1; b=0; c=0; #10;
    a=1; b=0; c=1; #10;
    a=1; b=1; c=0; #10;
    a=1; b=1; c=1; #10;

    $finish;
end

endmodule
