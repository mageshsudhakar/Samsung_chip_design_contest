module fp_divider_top (
    input  wire [31:0] X,
    input  wire [31:0] Y,
    output wire [31:0] Q
);

    // Unpack IEEE-754
    wire sx = X[31];
    wire sy = Y[31];
    wire [7:0] ex = X[30:23];
    wire [7:0] ey = Y[30:23];
    wire [22:0] mx = X[22:0];
    wire [22:0] my = Y[22:0];

    // Tile indices
    wire [2:0] h = mx[22:20];
    wire [2:0] k = my[22:20];

    // Local offsets (ΔMx, ΔMy)
    wire [19:0] delta_mx = mx[19:0];
    wire [19:0] delta_my = my[19:0];

    // LUT coefficients
    wire signed [6:0] A, B;
    wire signed [7:0] C;

    coeff_lut LUT (
        .h(h), .k(k),
        .A(A), .B(B), .C(C)
    );

    // Linear evaluation
    wire signed [26:0] mant_raw;
    linear_eval LE (
        .A(A), .B(B), .C(C),
        .delta_mx(delta_mx),
        .delta_my(delta_my),
        .mant_raw(mant_raw)
    );

    // --------- FIXED EXPONENT COMPUTATION ---------
    // IEEE-754: Ex - Ey + bias
    wire signed [8:0] exp_diff = $signed(ex) - $signed(ey) + 9'sd127;

    // Normalize
    wire [22:0] mant_final;
    wire signed [8:0] exp_final;

    normalize NORM (
        .mant_raw(mant_raw),
        .exp_in(exp_diff),
        .mant_out(mant_final),
        .exp_out(exp_final)
    );

    // Pack result
    assign Q = { sx ^ sy, exp_final[7:0], mant_final };

endmodule
