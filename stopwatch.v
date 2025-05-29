module stopwatch (
    input wire clk,          // Input clock signal
    input wire rst,          // Reset signal
    input wire start,        // Start signal
    output reg [5:0] seconds, // Seconds counter (0-59)
    output reg [5:0] minutes, // Minutes counter (0-59)
    output reg [4:0] hours    // Hours counter (0-23)
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all counters
            seconds <= 6'd0;
            minutes <= 6'd0;
            hours <= 5'd0;
        end else if (start) begin
            // Increment seconds
            if (seconds == 6'd59) begin
                seconds <= 6'd0;
                // Increment minutes on seconds overflow
                if (minutes == 6'd59) begin
                    minutes <= 6'd0;
                    // Increment hours on minutes overflow
                    if (hours == 5'd23) begin
                        hours <= 5'd0; // Reset hours on overflow
                    end else begin
                        hours <= hours + 1;
                    end
                end else begin
                    minutes <= minutes + 1;
                end
            end else begin
                seconds <= seconds + 1;
            end
        end
    end

endmodule
