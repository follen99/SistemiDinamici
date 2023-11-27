clc
% Definisco numeratore e denominatore
num = [2 5 3 6];
den = [1 6 11 6];
printsys(num, den, 's')

[r, p, k] = residue(num, den)


%% utilizzo residue per ricavare i fratti semplici
%newNum = [2 5 3 6];
%newDen = [1 6 11 6];
[newNum, newDen] = residue(r, p, k);
printsys(newNum, newDen, 's')