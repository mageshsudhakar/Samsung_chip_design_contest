import numpy as np
import cvxpy as cp

NX = 8
NY = 8
NSX = 20
NSY = 20

LSB_A = 2**-2
LSB_B = 2**-2
LSB_C = 2**-7

dx = 1.0 / NX
dy = 1.0 / NY

def exact_division(mx, my):
    return (1.0 + mx) / (1.0 + my)

coeff_table = {}

for h in range(NX):
    for k in range(NY):
        mx0 = h * dx
        my0 = k * dy

        mx_samples = mx0 + (np.arange(NSX) + 0.5) * dx / NSX
        my_samples = my0 + (np.arange(NSY) + 0.5) * dy / NSY

        A = cp.Variable(integer=True)
        B = cp.Variable(integer=True)
        C = cp.Variable(integer=True)
        U = cp.Variable((NSX, NSY), nonneg=True)

        constraints = []

        for i in range(NSX):
            for j in range(NSY):
                mx = mx_samples[i]
                my = my_samples[j]

                P = exact_division(mx, my)

                mx_diff = mx - mx0
                my_diff = my - my0

                P_approx = (
                    A * LSB_A * mx_diff +
                    B * LSB_B * my_diff +
                    C * LSB_C
                )

                constraints.append(P - P_approx <= U[i, j] * P)
                constraints.append(P_approx - P <= U[i, j] * P)

        objective = cp.Minimize(cp.sum(U))
        problem = cp.Problem(objective, constraints)
        problem.solve(solver=cp.ECOS_BB, verbose=False)

        if problem.status not in ["optimal", "optimal_inaccurate"]:
            raise RuntimeError("Solver failed")

        coeff_table[(h, k)] = (
            int(A.value),
            int(B.value),
            int(C.value),
            float(np.mean(U.value))
        )

print("h k A B C MRED")

with open("coeff_lut.txt", "w") as f:
    f.write("h k A B C mred\n")
    for h in range(NX):
        for k in range(NY):
            A, B, C, mred = coeff_table[(h, k)]
            f.write(f"{h} {k} {A} {B} {C} {mred}\n")
            print(h, k, A, B, C, mred)
