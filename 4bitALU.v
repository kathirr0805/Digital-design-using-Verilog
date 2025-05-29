module alu(
    input [3:0] A,    // 4-bit input A
    input [3:0] B,    // 4-bit input B
    input [2:0] opcode, // 3-bit opcode for operation selection
    output reg [3:0] result, // 4-bit result
    output reg carry    // Carry/Overflow flag
);
    always @(*) begin
        carry = 0; // Default carry
        case (opcode)
            3'b000: result = A + B;             // Addition
            3'b001: {carry, result} = A - B;   // Subtraction with borrow
            3'b010: result = A & B;            // AND
            3'b011: result = A | B;            // OR
            3'b100: result = A ^ B;            // XOR
            3'b101: result = ~A;               // NOT
            3'b110: result = A << 1;           // Logical left shift
            3'b111: result = A >> 1;           // Logical right shift
            default: result = 4'b0000;
        endcase
    end
endmodule
