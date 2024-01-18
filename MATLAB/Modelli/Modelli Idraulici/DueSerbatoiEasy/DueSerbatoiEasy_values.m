
% La corrente che viene riversata nei due serbatoi
Q11 = 1;
Q12 = 5;
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

num = [1/ro*g];
den = [L*C1*C2 R*C1*C2 C1+C2];

G = tf(num, den)
step(G)