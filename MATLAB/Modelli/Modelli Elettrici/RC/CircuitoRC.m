% in questo esempio è possibile vedere la risposta nel tempo ed in
% frequenza di un circuito RC
% le costanti sono R - Resistenza e C - Capacita'
clear; clc; close all;
R = 470;
C = 1*10^-3;

num = [0 1];
den = [R*C 1];
t = 0:0.01:100;

sys1 = tf(num, den)


% trovo la risposta ad un gradino unitario
[y, t, x] = step(sys1, t);

subplot(2,2,1)
plot(t, y);         % disegno l'andamento della risposta nel tempo
title("Risposta al gradino unitario");
xlim([0,5]);        % visualizzo solo l'intervallo di tempo da 0 a 5

subplot(2,2,3)
impulse(sys1);

w = logspace(-2, 2,100);
[mag, phase, w] = bode(sys1, w);

n = length(w);   
mod2d(1:n) = 20*log10(mag(1,1,:));
phase2d(1:n) = phase(1,1,:);


subplot(2,2,2)
semilogx(w, mod2d);
grid on
title("Diagramma dei moduli");

subplot(2,2,4)
semilogx(w, phase2d);
grid on
title("Diagramma delle fasi");


