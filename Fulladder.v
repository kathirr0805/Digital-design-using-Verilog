module Fulladder (
    input A,        // Input bit A
    input B,        // Input bit B
    input Cin,      // Carry input
    output Sum,     // Sum output
    output Cout     // Carry output
);
    assign Sum = A ^ B ^ Cin;    // XOR for Sum
    assign Cout = (A & B) | (B & Cin) | (A & Cin); // Carry-out
endmodule