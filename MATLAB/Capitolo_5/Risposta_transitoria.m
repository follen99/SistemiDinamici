clear
clc
% rappresentiamo una funzione di trasferimento G(s)
num = [0 2 25];     % aggiungendo uno zero posso rendere i due vettori della stessa lunghezza e quindi poterli sommare direttamente
den = [1 4 25];

%step(num, den)      % crea automaticamente la risposta al gradino per
%questa specifica funzione di trasferimento

sys = tf(num, den)      % serve per creare la funzione di trasferimento a partire da num e den, inoltre stampa a schermo la tf "graficamente"
[y, t, x] = step(sys);
plot(t,y);
plot(t,x);
