`timescale 1ns / 1ps

module top(
    input clk,                // Input clock
    input reset,              // Reset signal for counter
    output [3:0] led          // LED outputs with different duty cycles
);

    // Define an 8-bit counter
    reg [7:0] counter = 0;

    // Counter logic with reset support
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;      // Reset counter to 0
        end else if (counter < 100) begin
            counter <= counter + 1; // Increment counter
        end else begin
            counter <= 0;      // Reset counter when it reaches 100
        end
    end

    // Generate PWM signals with different duty cycles
    assign led[0] = (counter < 20) ? 1 : 0; // 20% duty cycle
    assign led[1] = (counter < 40) ? 1 : 0; // 40% duty cycle
    assign led[2] = (counter < 60) ? 1 : 0; // 60% duty cycle
    assign led[3] = (counter < 80) ? 1 : 0; // 80% duty cycle

endmodule
