close all; clear; clc;
k1 = 5;    % N/m
k2 = 2;    % N/m
k3 = 1;    % N/m
b = 10;      % Ns/m
m1 = 2000;   % kg
m2 = 4000;   % kg




A = [0, 0, 1, 0; 0, 0, 0, 1; -((k1+k2)/m1), -k2/m1, -b/m1 b/m1; 1/m1, -((k2+k3)/m2), b/m2, -b/m2];
B = [0 0 1 0];
C = [-1 1 0 0];
D = 0;

sys = ss(A, B', C, D);
t = 0:0.1:3000;


figure('Name',"Distanza tra i due vagoni")
subplot(2,2,1);
[y, t, ~] = step(sys, t);
plot(t,y);
xlabel("Tempo (s)");
ylabel("Distanza tra i due vagoni");
s = stepinfo(sys);
yline(y(end), '--');
title("Risposta ad un gradino unitario");


subplot(2,2,3);
[y, t, x] = impulse(sys);
plot(t,y);
xlabel("Tempo (s)");
ylabel("Distanza tra i due vagoni");
title("Risposta ad un impulso unitario");

subplot(2,2,2)
pzmap(sys);


% modello l'uscita in funzione dei valori singoli di x1 e x2 (posizioni)
C = [-1, 0, 0, 0; 0, 1, 0, 0];
sys1 = ss(A, B', C, D);
figure('Name',"Posizione dei due vagoni");
[y1, t1, x1] = step(sys1);
plot(t1, y1(:,1));
hold on
plot(t1, y1(:,2));
legend ('X1', 'X2');
title("Risposta ad un gradino unitario");
grid on

xlabel("tempo");
ylabel("Posizione")

