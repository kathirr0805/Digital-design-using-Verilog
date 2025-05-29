module ir_sensor_buzzer (
    input wire CLK,       // Clock Signal
    input wire RST,       // Reset Signal
    input wire IR_IN,     // IR Sensor Input (HIGH = Object Detected, LOW = No Object)
    output reg BUZZER     // Buzzer Output
);

always @(posedge CLK or posedge RST) begin
    if (RST)
        BUZZER <= 0;  // Reset Buzzer
    else begin
        if (IR_IN)
            BUZZER <= 1;  // Turn on Buzzer when object is detected
        else
            BUZZER <= 0;  // Turn off Buzzer
    end
end

endmodule
