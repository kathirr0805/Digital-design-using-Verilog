module pipo (
    output reg out,
    input in,   // Serial input
    input clk,  // Clock signal
    input rst   // Reset signal
);
    reg [3:0] shift_reg;  // 4-bit shift register

    always @(posedge clk or posedge rst) begin
        if (rst)
            shift_reg <= 4'b0000;  // Reset the shift register to 0
        else
            shift_reg <= {shift_reg[2:0], in};  // Shift left and load `in` at the LSB
    end

    always @(posedge clk) begin
        out <= shift_reg[3];  // Output the MSB (most significant bit)
    end
endmodule
