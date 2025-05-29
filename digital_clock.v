module digital_clock (
    input clk,         // Input clock (e.g., 1Hz for real-time operation)
    input reset,       // Reset signal
    output reg [5:0] sec,  // Seconds (0-59)
    output reg [5:0] min,  // Minutes (0-59)
    output reg [4:0] hr    // Hours (0-23 for 24-hour format)
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            sec <= 0;
            min <= 0;
            hr <= 0;
        end else begin
            // Increment seconds
            if (sec == 59) begin
                sec <= 0;
                // Increment minutes
                if (min == 59) begin
                    min <= 0;
                    // Increment hours
                    if (hr == 23) begin
                        hr <= 0;
                    end else begin
                        hr <= hr + 1;
                    end
                end else begin
                    min <= min + 1;
                end
            end else begin
                sec <= sec + 1;
            end
        end
    end

endmodule
