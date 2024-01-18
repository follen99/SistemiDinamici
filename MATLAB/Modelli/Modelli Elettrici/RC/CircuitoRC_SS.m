% in questo esempio è possibile vedere la risposta nel tempo ed in
% frequenza di un circuito RC
% le costanti sono R - Resistenza e C - Capacita'
clear; clc; close all;

R = 470;
C = 1*10^-3;

A = [-1/(R*C)];
B = [1/(R*C)];
C = [1];
D = [0];

sys1 = ss(A, B, C, D);
sys1

step(sys1)