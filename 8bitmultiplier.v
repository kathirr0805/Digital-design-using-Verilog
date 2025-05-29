module multiplier (
    input [7:0] a,       // 8-bit input operand a
    input [7:0] b,       // 8-bit input operand b
    output [15:0] product // 16-bit output product
);
    reg [15:0] partial_product [7:0]; // Array to store partial products
    reg [15:0] sum;                    // Sum of partial products
    integer i;

    always @(*) begin
        // Initialize the sum to 0
        sum = 16'b0;
        
        // Generate partial products and accumulate
        for (i = 0; i < 8; i = i + 1) begin
            if (b[i]) begin
                partial_product[i] = a << i; // Shift a by i positions
            end else begin
                partial_product[i] = 16'b0;
            end
            sum = sum + partial_product[i]; // Accumulate partial products
        end
    end

    assign product = sum; // Output the final product
endmodule
