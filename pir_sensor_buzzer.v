module pir_sensor_buzzer (
    input wire CLK,       // Clock Signal
    input wire RST,       // Reset Signal
    input wire PIR_IN,    // PIR Sensor Input (HIGH = Motion Detected, LOW = No Motion)
    output reg BUZZER     // Buzzer Output
);

always @(posedge CLK or posedge RST) begin
    if (RST)
        BUZZER <= 0;  // Reset Buzzer
    else begin
        if (PIR_IN)
            BUZZER <= 1;  // Turn on Buzzer when motion is detected
        else
            BUZZER <= 0;  // Turn off Buzzer
    end
end

endmodule
