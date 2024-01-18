% La corrente che viene riversata nei due serbatoi
Q1 = 1;
Q2 = 1;

% La capacità di ogni serbatoio
C1 = 1;
C2 = 1;

% La resistenza della condotta che collega i serbatoi
R = 1;

% Induttanza della condotta
L = 1;

ro = 1000;
g = 9.81;

A = [0, 0, -1/C1; 0, 0, 1/C2; 1/L, -1/L, -R/L];
B = [1/C1 0 0];
%C = [0 1/ro*g 0];
C = [0 1 0];
D = 0;

G = ss(A, B', C, D);
step(G);
