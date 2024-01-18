clear; close all; clc

% questo modello ha solo 2 componenti: resistore ed induttore; in aggiunta
% c'è anche la cosiddetta Forza contro-elettromotrice, che si oppone al
% moto del motore (una sorta di attrito).

l = 1; % induttanza
b = 1; % coefficiente della coppia che si oppone alla coppia del motore
r = 1; % resistenza
j = 1; % Momento di inerzia (equivalente alla massa)
Kt = 1; % coefficiente della coppia del motore
Kv = 1; % costante della forza contro-elettromotrice
v = 10; % tensione

% G è la funzione di trasferimento di omega/v
s = tf('s');
G = Kt/((s*l+r)*(j*s+b)+Kt*Kv);

% Definisco un sistema a partire dallo spazio di stato (1)
A = [-r/l, -Kv/l; Kt/j, b/j];
B = [1/l, 0; 0, -1/j];
C = [0 1];
D = [0 0];

sys1 = ss(A, B, C, D);
%impulse(sys1)

A = [-r/l, -Kv/l, 0; Kt/j, b/j, 0; 0, 1, 0];
B = [1/l, 0; 0, -1/j; 0, 0];
C = [0 0 1];
D = [0 0];

sys2 = ss(A, B, C, D);
