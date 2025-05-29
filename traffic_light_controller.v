// Timescale definition
`timescale 1ns/1ps

// Traffic light controller module
module traffic_light_controller(
    output reg [1:0] hwy,    // Highway signal: RED, YELLOW, GREEN
    output reg [1:0] cntry,   // Country road signal: RED, YELLOW, GREEN
    input wire X,            // Car detected on country road
    input wire clock,        // Clock signal
    input wire clear         // Clear/reset signal
);

    // Parameter definitions
    parameter Y2RDELAY = 3;  // Yellow-to-red delay in clock cycles
    parameter R2GDELAY = 2;  // Red-to-green delay in clock cycles

    // Internal variables
    reg [3:0] counter;     // Counter for delays
    reg delay_active;      // Indicates if a delay is in progress
    reg is_country_priority; // Indicates if country road has priority

    // Initial conditions
    initial begin
        hwy <= 2'b10; // Start with highway GREEN
        cntry <= 2'b00; // Country road RED
        counter <= 0;
        delay_active <= 0;
        is_country_priority <= 0;
    end

    // Sequential logic (triggered by clock or clear)
    always @(posedge clock or posedge clear) begin
        if (clear) begin
            hwy <= 2'b10;
            cntry <= 2'b00;
            counter <= 0;
            delay_active <= 0;
            is_country_priority <= 0;
        end else if (delay_active) begin
            if (counter > 0) begin
                counter <= counter - 1;
            end else begin
                delay_active <= 0;
            end
        end
    end

    // Combinational logic (triggered by signal changes)
    always @(*) begin
        if (X && !is_country_priority && !delay_active) begin
            // Car detected on country road
            delay_active <= 1;
            counter <= Y2RDELAY;
            hwy <= 2'b01;  // Highway YELLOW
            cntry <= 2'b00; // Country RED
            is_country_priority <= 1;
        end else if (is_country_priority && !delay_active && X) begin
            // Country road remains prioritized
            delay_active <= 1;
            counter <= R2GDELAY;
            hwy <= 2'b00;  // Highway RED
            cntry <= 2'b10; // Country GREEN
        end else if (!X && is_country_priority && !delay_active) begin
            // No car on country road; return to highway priority
            delay_active <= 1;
            counter <= Y2RDELAY;
            hwy <= 2'b00;  // Highway RED
            cntry <= 2'b01; // Country YELLOW
            is_country_priority <= 0;
        end else if (!is_country_priority && !delay_active) begin
            // Maintain highway GREEN
            hwy <= 2'b10;
            cntry <= 2'b00;
        end
    end

endmodule
