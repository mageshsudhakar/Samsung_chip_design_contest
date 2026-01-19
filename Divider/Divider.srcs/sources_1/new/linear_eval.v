module linear_eval (
    input  wire signed [6:0] A,
    input  wire signed [6:0] B,
    input  wire signed [7:0] C,
    input  wire [19:0] delta_mx,
    input  wire [19:0] delta_my,
    output wire signed [26:0] mant_raw   // Q0.26
);

    // Intermediate products
    wire signed [27:0] mul_x;
    wire signed [27:0] mul_y;

    // A·ΔMx and B·ΔMy
    // delta_* : Q0.20
    // A,B     : integer
    // >>>2 accounts for LSB_A = LSB_B = 2^-2
    assign mul_x = (A * delta_mx) >>> 2;   // Q0.18
    assign mul_y = (B * delta_my) >>> 2;   // Q0.18

    // Align everything to Q0.26
    // C is scaled by 2^-7 → shift left by (26 - 7) = 19
    assign mant_raw =
        (mul_x <<< 8) +
        (mul_y <<< 8) +
        (C <<< 19);

endmodule
