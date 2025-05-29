module single_port_ram(
    input [7:0] data,         // 8-bit data input
    input [5:0] addr,         // 6-bit address input
    input we,                 // Write enable input
    input clk,                // Clock input
    output reg [7:0] q        // 8-bit data output (registered output)
);

    reg [7:0] ram [63:0];     // 64x8-bit memory array

    always @(posedge clk) begin
        if (we) begin
            ram[addr] <= data;  // Write data to RAM at the given address
        end else begin
            q <= ram[addr];     // Read data from RAM at the given address and assign it to q
        end
    end

endmodule
