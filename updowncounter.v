module updown(input clk, reset,up_down, output[2:0] counter);
reg [2:0] counter_up_down;
// down counter
always @(posedge clk or posedge reset)
begin
if(reset)
counter_up_down <= 3'h0;
else if(~up_down)
counter_up_down <= counter_up_down + 3'd1;
else
counter_up_down <= counter_up_down - 3'd1;
end
assign counter = counter_up_down;
endmodule