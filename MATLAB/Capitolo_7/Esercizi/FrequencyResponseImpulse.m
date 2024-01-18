% è possibile ottenere la risposta a regime con un "trucchetto": sfruttiamo
% il fatto che la LT di un impulso è 1, quindi:
clear; clc; close all;

R = 470;
C = 10*10^-3;

num = [0 1];
den = [R*C 1];


G = tf(num, den)
subplot(1,2,1)
bode(G);
grid on

sin = tf(0.1, [1 0 0.1^2])

Y = G*sin           % moltiplico nel dominio di laplace funzione di trasferimento ed input
t = 0:0.001:1000;

subplot(1,2,2)
impulse(Y,t);
%xlim([10,10.5])