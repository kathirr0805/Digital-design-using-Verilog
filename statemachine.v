module state (
    input clk, reset, in,
    output reg out
);
    reg [2:0] state, next_state;

    // State encoding
    localparam S0 = 3'b000,  // Initial state (No match yet)
               S1 = 3'b001,  // Detected "1"
               S2 = 3'b010,  // Detected "10"
               S3 = 3'b011,  // Detected "101"
               S4 = 3'b100;  // Detected "1011" (output 1)

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= S0;  // Reset to initial state
        else 
            state <= next_state;  // Transition to the next state
    end

    // Output logic and next state logic
    always @(*) begin
        // Default values for next state and output
        next_state = S0;
        out = 0;

        case (state)
            S0: begin
                // No match, move to S1 if input is 1
                next_state = in ? S1 : S0;
            end
            S1: begin
                // Detected "1", move to S2 if 0, stay in S1 if 1
                next_state = in ? S1 : S2;
            end
            S2: begin
                // Detected "10", move to S3 if 1, reset to S0 if 0
                next_state = in ? S3 : S0;
            end
            S3: begin
                // Detected "101", move to S4 if 1, back to S2 if 0
                next_state = in ? S4 : S2;
            end
            S4: begin
                // Detected "1011", output 1 and overlap (move to S1 if 1, S2 if 0)
                out = 1;
                next_state = in ? S1 : S2;
            end
            default: next_state = S0;  // Default to initial state
        endcase
    end
endmodule
