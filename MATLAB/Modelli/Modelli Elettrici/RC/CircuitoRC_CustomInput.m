% possiamo trovare la risposta ad un input custom (che decidiamo noi)
% andando a sfruttare il fatto che la trasformata dell'impulso è 1, quindi
% possiamo moltiplicare nel dominio di laplace le due trasformate (G e U)
% per poi fare "l'anti trasfromata" tramite il comando impulse()
clear; close all; clc

% num e den rappresentano in questo caso la trasformata di un integratore
% 1/S

num = [0 1];
den = [1 0];

G = tf(num, den)

% definisco il segnale custom, ad esempio un gradino di ampiezza 2
s = tf('s');    % assegno alla variabile s il compito di variabile di laplace s in modo da scrivere più semplicemente i segnali

U1 = 1/s

% calcolo l'uscita nel dominio di laplace
Y1 = G * U1

% "calcolo" l'antitrasformata
% possiamo notare che la risposta nel tempo è una retta infinita; ce lo
% aspettiamo: l'integrale di una costante è proprio una retta.

subplot(2,1,1);
impulse(Y1);
title("Risposta ad un gradino unitario di un integratore.")

% se però proviamo a calcolare l'uscita ad un segnale di tipo finestra,
% l'uscita non sara' più una retta infinita, ma una retta finche' non si
% esaurisce l'input; siccome la G ha un polo nell'origine, il sistema
% "ricorda" l'input precedente e non torna a zero, ma resta all'ultimo
% valore:

% devo separare i due segnali in modo da poter applicare ad ogni singolo
% segnale il ritardo corrispondente; successivamente sommerò (con il segno
% opportuno) i vari segnali per ottenere l'input desiderato. 

U21 = 1/s;                                          % gradino unitario
U22 = tf([0 1], [1 0], 'inputDelay', 1);            % gradino unitario ritardato

U2 = U21 - U22;
Y2 = G * U2;

subplot(2,1,2);
impulse(Y2);                                        %"antitrasformo"
title("Risposta alla finestra di ampiezza 1 e durata 1 di un integratore.")



