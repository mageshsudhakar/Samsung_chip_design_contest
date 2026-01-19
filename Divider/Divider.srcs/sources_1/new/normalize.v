module normalize (
    input  wire signed [26:0] mant_raw,   // Q0.26
    input  wire signed [8:0]  exp_in,
    output reg  [22:0] mant_out,
    output reg  signed [8:0]  exp_out
);

    always @(*) begin
        if (mant_raw[26] == 1'b1) begin
            // mantissa ≥ 1.0
            mant_out = mant_raw[25:3];  // take 23 bits
            exp_out  = exp_in;
        end else begin
            // mantissa < 1.0 → normalize
            mant_out = mant_raw[24:2];
            exp_out  = exp_in - 1;
        end
    end
endmodule
