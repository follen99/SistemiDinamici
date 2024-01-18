clear
clc

% andiamo a definire dei polinomi

B = [0 3 -1]; % polinomio al nominatore

A = [1 3 2]; % polinomio al denominatore

length(A) % stampa la lunghezza del vettore

[r, p, k] = residue(B, A);     % ha come output [r, p, k]

printsys(B, A);

p' %serve per fare il trasposto

% facciamo un disegno dell'anti trasformata
% (1) Definire un vettore tempo
t = 0:0.05:5 % il passo di campionamento è un decimo della costante di tempo del segnale più veloce (che ha una costante di 1/2)
% (2) definiamo la funzione
f = 7 * exp(-2 * t) - 4* exp(-t) % essendo t un vettore ci viene restituito un altro vettore fatto da tanti elementi quanti sono quelli di t

% (3) disegno la funzione
plot(t, f)