module counter_7seg_binary (
    input clk,             // Clock input
    input reset,           // Reset input
    output [6:0] HEX0_D,   // 7-segment output for digit 0
    output [6:0] HEX1_D,   // 7-segment output for digit 1
    output [6:0] HEX2_D,   // 7-segment output for digit 2
    output [6:0] HEX3_D    // 7-segment output for digit 3 (if available)
);

    reg [3:0] count; // 4-bit counter

    // Binary-to-7-segment decoder logic
    function [6:0] binary_to_segment(input bit_value);
        begin
            binary_to_segment = bit_value ? 7'b0111111 : 7'b1111110; // "1" lights up top segment only, "0" lights up all except middle
        end
    endfunction

    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 4'b0000; // Reset counter to 0
        else
            count <= count + 1; // Increment counter
    end

    // Assign each counter bit to one 7-segment display
    assign HEX0_D = binary_to_segment(count[0]); // LSB
    assign HEX1_D = binary_to_segment(count[1]);
    assign HEX2_D = binary_to_segment(count[2]);
    assign HEX3_D = binary_to_segment(count[3]); // MSB (if HEX3 is available)

endmodule
