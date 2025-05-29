module SRAM(
    input clk,               // Clock signal
    input rst,               // Reset signal
    input write_enable,      // Write enable signal
    input [1:0] address,     // 2-bit address (for 4 locations)
    input [3:0] write_data,  // 4-bit data input
    output reg [3:0] read_data // 4-bit data output
);

    // 4x4 SRAM memory array
    reg [3:0] memory [3:0];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all memory locations to 0
            memory[0] <= 4'b0000;
            memory[1] <= 4'b0000;
            memory[2] <= 4'b0000;
            memory[3] <= 4'b0000;
        end else if (write_enable) begin
            // Write data to the specified address
            memory[address] <= write_data;
        end
    end

    always @(*) begin
        // Read data from the specified address
        read_data = memory[address];
    end
endmodule
