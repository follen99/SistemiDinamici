clc
num = [1 2 3];
den = [1 3 3 1];

[r, p, k] = residue(num, den);
r
p

[num, den] = residue(r, p, k);
printsys(num, den, 's');