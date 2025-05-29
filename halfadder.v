module halfadder(
    input a,            // First input
    input b,            // Second input
    output sum,         // Sum output
    output carry        // Carry output
);
    assign sum = a ^ b;     // XOR gate for sum
    assign carry = a & b;   // AND gate for carry
endmodule
