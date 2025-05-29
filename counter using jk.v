module counter(
input wire clk,
input wire reset,
input wire up_down,
output reg [3:0] count
);
always @(posedge clk or posedge reset) begin
if (reset) begin
count <= 4'b0000;
end else if (up_down) begin // Up-count
count <= count + 1;
end else begin // Down-count
count <= count - 1;
end
end
endmodule