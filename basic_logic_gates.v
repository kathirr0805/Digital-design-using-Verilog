module logic_gates(
    input wire a,
    input wire b,
    output reg and_gate,
    output reg or_gate,
    output reg not_gate_a,
    output reg not_gate_b,
    output reg nand_gate,
    output reg nor_gate,
    output reg xor_gate,
    output reg xnor_gate
);

    always @(*) begin
        // AND gate
        and_gate = a & b;

        // OR gate
        or_gate = a | b;

        // NOT gates
        not_gate_a = ~a;
        not_gate_b = ~b;

        // NAND gate
        nand_gate = ~(a & b);

        // NOR gate
        nor_gate = ~(a | b);

        // XOR gate
        xor_gate = a ^ b;

        // XNOR gate
        xnor_gate = ~(a ^ b);
    end

endmodule
