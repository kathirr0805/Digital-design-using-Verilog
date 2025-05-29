module siso (
    output reg out,
    input [3:0] data, // Parallel data input
    input load,
    input shift,
    input clk,
    input rst
);
    reg [3:0] shift_reg;

    always @(posedge clk or posedge rst) begin
        if (rst)
            shift_reg <= 4'b0000; // Clear shift register on reset
        else if (load)
            shift_reg <= data; // Load parallel data into shift register
        else if (shift)
            shift_reg <= {shift_reg[2:0], 1'b0}; // Shift left by 1 bit if shift is enabled
    end

    always @(posedge clk) begin
        if (!rst && !load && shift)
            out <= shift_reg[3]; // Output MSB during shift operation
        else
            out <= 1'b0; // Clear output if not shifting
    end
endmodule
