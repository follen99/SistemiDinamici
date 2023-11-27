% sistema dinamico di tipo termico, visto nella lezione 14
clear
clc
close all

R1 = 1;
R2 = 10;
Cr = 0.1;
Cs = 10;


%Variabili di stato: temperatura radiatore, temperatura stanza
%Ingressi: flusso termici radiatore e temperatura ambiente
%Uscite: Flusso termico e temperatura esterna

% prima equazione
A(1,1) = -1/(R1*Cr);
A(1,2) = -A(1,1);

B(1,1) = 1/Cr;
B(1,2) = 0;


% seconda equazione
A(2,1) = 1/(R1*Cs);
A(2,2) = -1/Cs*(1/R1+1/R2);

B(2,1) = 0; %temperatura ambiente
B(2,2) = 1 /(R2*Cs);


% definisco l'uscita: Temperatura Stanza Ts
C = [0 1];
D = 0;


% definisco lo spazio di stato
% MT = ss(A, B, C, D)

MT = ss(A,B,C,D);
G = tf(MT);

%numeratore della seconda funz
num2 = G(2).Numerator{1};
den2 = G(2).Denominator{1};

G2 = tf(num2, den2)
step(G2);
%step(G) % due funzioni di trasferimento

poli = pole(G2);
zeri = zero(G2);

