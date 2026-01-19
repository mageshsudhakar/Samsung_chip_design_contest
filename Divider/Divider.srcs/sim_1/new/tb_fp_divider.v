`timescale 1ns/1ps

module tb_fp_divider;

    reg  [31:0] X;
    reg  [31:0] Y;
    wire [31:0] Q;

    // Instantiate DUT
    fp_divider_top dut (
        .X(X),
        .Y(Y),
        .Q(Q)
    );

    // Task to display values
    task display_result;
        begin
            $display("X = %h, Y = %h -> Q = %h", X, Y, Q);
        end
    endtask

    initial begin
        $display("====================================");
        $display(" Floating Point Divider Testbench ");
        $display("====================================");

        // -------------------------------
        // Test 1: 1.0 / 1.0 = 1.0
        // -------------------------------
        X = 32'h3F800000;  // 1.0
        Y = 32'h3F800000;  // 1.0
        #10;
        display_result();

        // -------------------------------
        // Test 2: 2.0 / 1.0 = 2.0
        // -------------------------------
        X = 32'h40000000;  // 2.0
        Y = 32'h3F800000;  // 1.0
        #10;
        display_result();

        // -------------------------------
        // Test 3: 1.0 / 2.0 = 0.5
        // -------------------------------
        X = 32'h3F800000;  // 1.0
        Y = 32'h40000000;  // 2.0
        #10;
        display_result();

        // -------------------------------
        // Test 4: 3.5 / 1.75 = 2.0
        // -------------------------------
        X = 32'h40600000;  // 3.5
        Y = 32'h3FE00000;  // 1.75
        #10;
        display_result();

        // -------------------------------
        // Test 5: Negative result
        // -------------------------------
        X = 32'hC0800000;  // -4.0
        Y = 32'h40000000;  // 2.0
        #10;
        display_result();

        $display("====================================");
        $display(" End of basic tests ");
        $display("====================================");

        $finish;
    end

endmodule
