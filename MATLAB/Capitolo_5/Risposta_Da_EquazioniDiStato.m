clear
clc
%esercizio 5.3 pagina 182
% l'esercizio fornisce una rappresentazione nello spazio di stato e chiede
% di ottenere la risposta al gradino unitario.
A = [-1 -1; 6.5 0];
B = [1 1; 1 0];
C = [1 0; 0 1];
D = [0 0; 0 0];

sys = ss(A, B, C, D);
step(sys);