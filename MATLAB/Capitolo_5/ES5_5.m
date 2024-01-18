clc; clear all; close all;

% Esempio 5.5 - L'obbiettivo è ottenere la risposta del sitema, dato dalla
% funzione di trasferimento, all'impulso unitario.
main_figure = figure('Name', "Risposta all'impulso unitario", 'NumberTitle','off');
MAGNITUDE = 0.01;
before_zero_amount = 10;

t = 0:MAGNITUDE:100;                     % ATTENZIONE - la simulazione arriva fino a 100*0.01 ma la visualizzazione fino a 50!
num = [0 0 1];
den = [1 0.2 1];

signal_before_zero = zeros(10, 1); % creo un array di 100 elementi tutti a valore zero


sys1 = tf(num, den);
[y, t, x] = impulse(sys1, t);

signal_before_zero = zeros(before_zero_amount/MAGNITUDE, 1);
t_before_zero = (-before_zero_amount:MAGNITUDE:(0-MAGNITUDE))'      % l'apice indica il trasposto, rende il vettore riga un vettore colonna

t = [t_before_zero; t];
y = [signal_before_zero; y];

subplot(2,1,1);
plot(t, y, 'LineWidth',2);
xlim([-5 50]);                       % visualizzo fino a 50
ylim([-1 1]);
legend("Risposta all'impulso");

subplot(2,1,2);
stem(0, 1, 'r');
xlim([-5 50]);                       % visualizzo fino a 50
ylim([0 1.1]);




