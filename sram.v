module sram_controller (
    input         clk,        // Clock signal
    input         rst,        // Reset signal
    input  [15:0] address,    // Address bus
    input  [7:0]  data_in,    // Data input for write operations
    input         read_en,    // Read enable
    input         write_en,   // Write enable
    inout  [7:0]  sram_data,  // Bidirectional data bus for SRAM
    output [15:0] sram_address, // Address to SRAM
    output reg    sram_we,    // SRAM write enable
    output reg    sram_oe,    // SRAM output enable
    output reg [7:0] data_out // Data output for read operations
);

    // Bidirectional data bus control
    reg [7:0] data_buffer;
    reg data_dir; // 0: Input to SRAM, 1: Output from SRAM

    assign sram_address = address;
    assign sram_data = (data_dir == 0) ? data_buffer : 8'bz; // Tri-state logic

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset logic
            sram_we   <= 1; // Write disable
            sram_oe   <= 1; // Output disable
            data_out  <= 8'b0;
            data_dir  <= 0; // Input mode
            data_buffer <= 8'b0;
        end else begin
            if (write_en) begin
                // Write operation
                sram_we   <= 0; // Enable write
                sram_oe   <= 1; // Disable output
                data_dir  <= 0; // Drive data to SRAM
                data_buffer <= data_in;
            end else if (read_en) begin
                // Read operation
                sram_we   <= 1; // Disable write
                sram_oe   <= 0; // Enable output
                data_dir  <= 1; // Read data from SRAM
                data_out  <= sram_data; // Capture data from SRAM
            end else begin
                // Idle state
                sram_we   <= 1; // Write disable
                sram_oe   <= 1; // Output disable
                data_dir  <= 0; // Default to input mode
            end
        end
    end

endmodule
