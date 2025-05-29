module priority_encoder_4to2 (
    input wire D3, D2, D1, D0,
    output reg A, B, V
);
    always @(*) begin
        V = D3 | D2 | D1 | D0;
        if (D3) begin
            A = 0; B = 0;
        end else if (D2) begin
            A = 0; B = 1;
        end else if (D1) begin
            A = 1; B = 0;
        end else if (D0) begin
            A = 1; B = 1;
        end else begin
            A = 0; B = 0;
        end
    end
endmodule
