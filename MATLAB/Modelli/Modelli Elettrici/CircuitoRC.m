% Modello di un circuito RC; le variabili sono proprio R e C.
clc; clear all


R = 0.1;
C = 0.001;

num = 1;
den = [R*C 1];

model = tf(num, den)
t = 0:0.001:0.001;
[y_r, t_r, x_r] = step(model,t);
[y_i, t_i, x_i] = impulse(model, t);

subplot(1,2,1)
plot(t_r, y_r, 'r')
ylabel("risposta ad un segnale gradino");
xlabel("tempo");

subplot(1,2,2)
plot(t_i, y_i, 'g')
ylabel("risposta ad un segnale impulso");
xlabel("tempo");
