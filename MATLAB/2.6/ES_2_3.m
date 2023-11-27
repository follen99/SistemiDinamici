clear
clc
num = [1 3];
den = [1 3 2];
fprintf('Funzione iniziale:');
printsys(num, den, 's');

[r, p, k] = residue(num, den);
z = zeros(num);
r
p

printsys(r,p)