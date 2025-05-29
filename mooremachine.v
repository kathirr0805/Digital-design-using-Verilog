module moore(
    input clk,        // Clock signal
    input reset,      // Reset signal (synchronous)
    input in,         // Input signal
    output reg out    // Output signal
);

    // Define states using parameters
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;

    reg [1:0] current_state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= S0;  // Reset to the initial state
        else 
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: if (in) next_state = S1; else next_state = S0;
            S1: if (in) next_state = S2; else next_state = S0;
            S2: if (in) next_state = S2; else next_state = S1;
            default: next_state = S0;
        endcase
    end

    // Output logic (Moore: output depends only on the current state)
    always @(*) begin
        case (current_state)
            S0: out = 1'b0;
            S1: out = 1'b0;
            S2: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
