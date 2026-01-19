import os

# --------------------------------------------------
# Get directory of this Python script
# --------------------------------------------------
script_dir = os.path.dirname(os.path.abspath(__file__))

input_file  = os.path.join(script_dir, "coeff_lut_final.txt")
output_file = os.path.join(script_dir, "Verilog_LUT.txt")

# --------------------------------------------------
# Read coefficient file
# --------------------------------------------------
coeffs = []

with open(input_file, "r") as f:
    lines = f.readlines()

for line in lines:
    line = line.strip()
    if not line or line.startswith("h"):
        continue

    h, k, A, B, C, _ = line.split()

    h = int(h)
    k = int(k)
    A = int(A)
    B = int(B)
    C = int(C)

    idx = h * 8 + k  # 6-bit LUT index (0–63)
    coeffs.append((idx, A, B, C))

# Sort by index for safety
coeffs.sort(key=lambda x: x[0])

# --------------------------------------------------
# Write Verilog LUT
# --------------------------------------------------
with open(output_file, "w") as f:
    for idx, A, B, C in coeffs:
        f.write(
            f"6'd{idx}:  begin "
            f"A= 7'sd{A}; "
            f"B=-7'sd{B}; "
            f"C= 8'sd{C}; "
            f"end\n"
        )

print("Verilog LUT generation complete.")
print("Input file :", input_file)
print("Output file:", output_file)
