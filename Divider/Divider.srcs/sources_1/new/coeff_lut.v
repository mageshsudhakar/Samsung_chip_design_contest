module coeff_lut (
    input  wire [2:0] h,
    input  wire [2:0] k,
    output reg  signed [6:0] A,
    output reg  signed [6:0] B,
    output reg  signed [7:0] C
);

    wire [5:0] addr;
    assign addr = {h, k};

    always @(*) begin
        case (addr)

            // h = 0
            6'd0:  begin A=7'sd4; B=-7'sd4; C=8'sd128; end
            6'd1:  begin A=7'sd3; B=-7'sd3; C=8'sd115; end
            6'd2:  begin A=7'sd3; B=-7'sd2; C=8'sd102; end
            6'd3:  begin A=7'sd3; B=-7'sd2; C=8'sd93;  end
            6'd4:  begin A=7'sd3; B=-7'sd2; C=8'sd85;  end
            6'd5:  begin A=7'sd2; B=-7'sd2; C=8'sd81;  end
            6'd6:  begin A=7'sd2; B=-7'sd1; C=8'sd73;  end
            6'd7:  begin A=7'sd2; B=-7'sd1; C=8'sd68;  end

            // h = 1
            6'd8:  begin A=7'sd4; B=-7'sd4; C=8'sd143; end
            6'd9:  begin A=7'sd3; B=-7'sd3; C=8'sd128; end
            6'd10: begin A=7'sd3; B=-7'sd3; C=8'sd116; end
            6'd11: begin A=7'sd3; B=-7'sd2; C=8'sd104; end
            6'd12: begin A=7'sd3; B=-7'sd2; C=8'sd95;  end
            6'd13: begin A=7'sd2; B=-7'sd2; C=8'sd90;  end
            6'd14: begin A=7'sd2; B=-7'sd1; C=8'sd82;  end
            6'd15: begin A=7'sd2; B=-7'sd1; C=8'sd76;  end

            // h = 2
            6'd16: begin A=7'sd4; B=-7'sd5; C=8'sd160; end
            6'd17: begin A=7'sd3; B=-7'sd4; C=8'sd144; end
            6'd18: begin A=7'sd3; B=-7'sd3; C=8'sd128; end
            6'd19: begin A=7'sd3; B=-7'sd3; C=8'sd117; end
            6'd20: begin A=7'sd3; B=-7'sd2; C=8'sd106; end
            6'd21: begin A=7'sd2; B=-7'sd2; C=8'sd100; end
            6'd22: begin A=7'sd2; B=-7'sd2; C=8'sd93;  end
            6'd23: begin A=7'sd2; B=-7'sd1; C=8'sd85;  end

            // h = 3
            6'd24: begin A=7'sd4; B=-7'sd5; C=8'sd175; end
            6'd25: begin A=7'sd3; B=-7'sd4; C=8'sd157; end
            6'd26: begin A=7'sd3; B=-7'sd3; C=8'sd140; end
            6'd27: begin A=7'sd3; B=-7'sd3; C=8'sd128; end
            6'd28: begin A=7'sd3; B=-7'sd2; C=8'sd116; end
            6'd29: begin A=7'sd2; B=-7'sd2; C=8'sd109; end
            6'd30: begin A=7'sd2; B=-7'sd2; C=8'sd102; end
            6'd31: begin A=7'sd2; B=-7'sd2; C=8'sd95;  end

            // h = 4
            6'd32: begin A=7'sd4; B=-7'sd6; C=8'sd192; end
            6'd33: begin A=7'sd3; B=-7'sd4; C=8'sd170; end
            6'd34: begin A=7'sd3; B=-7'sd4; C=8'sd154; end
            6'd35: begin A=7'sd3; B=-7'sd3; C=8'sd139; end
            6'd36: begin A=7'sd3; B=-7'sd3; C=8'sd128; end
            6'd37: begin A=7'sd2; B=-7'sd2; C=8'sd119; end
            6'd38: begin A=7'sd2; B=-7'sd2; C=8'sd110; end
            6'd39: begin A=7'sd2; B=-7'sd2; C=8'sd103; end

            // h = 5
            6'd40: begin A=7'sd4; B=-7'sd6; C=8'sd208; end
            6'd41: begin A=7'sd3; B=-7'sd5; C=8'sd186; end
            6'd42: begin A=7'sd3; B=-7'sd4; C=8'sd167; end
            6'd43: begin A=7'sd3; B=-7'sd3; C=8'sd150; end
            6'd44: begin A=7'sd3; B=-7'sd3; C=8'sd138; end
            6'd45: begin A=7'sd2; B=-7'sd2; C=8'sd128; end
            6'd46: begin A=7'sd2; B=-7'sd2; C=8'sd119; end
            6'd47: begin A=7'sd2; B=-7'sd2; C=8'sd112; end

            // h = 6
            6'd48: begin A=7'sd4; B=-7'sd6; C=8'sd223; end
            6'd49: begin A=7'sd3; B=-7'sd5; C=8'sd199; end
            6'd50: begin A=7'sd3; B=-7'sd4; C=8'sd179; end
            6'd51: begin A=7'sd3; B=-7'sd4; C=8'sd163; end
            6'd52: begin A=7'sd3; B=-7'sd3; C=8'sd149; end
            6'd53: begin A=7'sd2; B=-7'sd3; C=8'sd140; end
            6'd54: begin A=7'sd2; B=-7'sd2; C=8'sd128; end
            6'd55: begin A=7'sd2; B=-7'sd2; C=8'sd120; end

            // h = 7
            6'd56: begin A=7'sd4; B=-7'sd7; C=8'sd240; end
            6'd57: begin A=7'sd3; B=-7'sd5; C=8'sd213; end
            6'd58: begin A=7'sd3; B=-7'sd4; C=8'sd191; end
            6'd59: begin A=7'sd3; B=-7'sd4; C=8'sd175; end
            6'd60: begin A=7'sd3; B=-7'sd3; C=8'sd159; end
            6'd61: begin A=7'sd2; B=-7'sd3; C=8'sd149; end
            6'd62: begin A=7'sd2; B=-7'sd2; C=8'sd137; end
            6'd63: begin A=7'sd2; B=-7'sd2; C=8'sd128; end

            default: begin A=0; B=0; C=0; end
        endcase
    end
endmodule
