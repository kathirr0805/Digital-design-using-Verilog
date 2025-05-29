module Jk_FF(output reg q, output reg qb, input j, input k, input clk);
always @(posedge clk) begin
    if (j == 0 && k == 0) begin
        // Hold state
        q <= q;
        qb <= qb; // qb remains complement of q
    end
    else if (j == 0 && k == 1) begin
        // Reset state
        q <= 0;
        qb <= 1;
    end
    else if (j == 1 && k == 0) begin
        // Set state
        q <= 1;
        qb <= 0;
    end
    else if (j == 1 && k == 1) begin
        // Toggle state
        q <= ~q;
        qb <= ~qb;
    end
end
endmodule
