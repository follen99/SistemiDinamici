clc; clear all; close all;

% Esempio 5.5 - L'obbiettivo è ottenere la risposta del sitema, dato dalla
% funzione di trasferimento, all'impulso unitario.
main_figure = figure('Name', "Risposta all'impulso unitario", 'NumberTitle','off');
MAGNITUDE = 0.01;
before_zero_amount = 10;

t = 0:MAGNITUDE:100;                     % ATTENZIONE - la simulazione arriva fino a 100*0.01 ma la visualizzazione fino a 50!
num = [0 0 1];
den = [1 0.2 1];


sys1 = tf(num, den);


%##### RISPOSTA ALL IMPULSO UNITARIO #####
[y, t, x] = impulse(sys1, t);
signal_before_zero = zeros(10, 1); % creo un array di 100 elementi tutti a valore zero


signal_before_zero = zeros(before_zero_amount/MAGNITUDE, 1);
t_before_zero = (-before_zero_amount:MAGNITUDE:(0-MAGNITUDE))'      % l'apice indica il trasposto, rende il vettore riga un vettore colonna

t = [t_before_zero; t];
y = [signal_before_zero; y];

subplot(2,2,1);
plot(t, y, 'LineWidth',2);
xlim([-5 50]);                       % visualizzo fino a 50
ylim([-1 1]);
xlabel("Risposta all'impulso");

subplot(2,2,3);
impulse_values = zeros((50+5), 1);
impulse_values(6) = 1;              % l'indice corrispondente a zero è proprio 6.
impulse_time = -5:1:49;

stem(impulse_time, impulse_values, 'r');
xlim([-5 50]);                       % visualizzo fino a 50
ylim([0 1.1]);
xlabel("Impulso");


%##### RISPOSTA AL GRADINO UNITARIO #####

% risposta
[y_step, t_step, x_step] = step(sys1, t);
subplot(2,2,2);
plot(t_step, y_step);
xlim([-5 50]);
ylim([0 2]);
xlabel('Risposta al gradino unitario.')

% gradino
step_time = -5:0.01:49;
step_signal = zeros(length(step_time),1);
step_signal((5/0.01)+1: end) = 1;

subplot(2,2,4);
plot(step_time, step_signal);
xlim([-5 50]);
ylim([0 2]);
xlabel('Gradino unitario.')


