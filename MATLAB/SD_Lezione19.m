% risposta ad un gradino piu sinusoide
u1 = tf([1], [1, 0])        % trasformata di laplace di un gradino
u2 = tf(1, [1 3])           % trasformata di laplace di un exp

u3 = u1 + u2                % somma degli ingressi

G = tf([2 25], [1 4 25]);   % funzione di trasferimento

G1 = G*u3;                  % funzione di trasferimento "fittizia" ottenuta dalla moltiplicazione dei due input


[y, t] = impulse(G1);    % risposta al gradino
%plot(t, y, 'k', 'LineWidth', 2);


% ESEMPIO SUCCESSIVO
clear;
clc;

A = [-1 -1; 6.5 0];
B = [1 1; 1 0];
C = eye(2, 2);               % la funzione crea una matrice identità 2x2
D = zeros(2,2);              % la funzione crea una matrice di tutti zeri 2x2


G = ss(A, B, C, D);
Gtf = tf(G)

Gtf(1,1)                    % accedo alla prima funzione di trasferimento

[y1u1, t] = step(Gtf(1,1)); %uscita al gradino u1
%plot(t, y1u1)

[y1u2, t2] = step(Gtf(2,1)); %uscita al gradino u2

%plot(t, y1u1, 'k', t2, y1u2,'r');   % visualizzo entrambe

simulationTime = 0:0.01:15; % intervallo di tempo della simulazione


y1u1 = step(Gtf(1,1), simulationTime);   % fornisco gli istanti di tempo in cui deve calcolare la risposta
y1u2 = step(Gtf(2,1), simulationTime);

%plot(simulationTime, y1u1, 'k', simulationTime, y1u2,'r');   % visualizzo entrambe, nell'intervallo di tempo richiesto

% ESEMPIO SUCCESSIVO
clear;
clc;

num = [2 -6 15 -4];
den = conv([1 1], conv([1 10], [1 2*0.5*12 12^2]));
G = tf(num, den)

pole(G)             % poli della funzione di trasferimento
zero(G)             % zeri della tf

[r, p, k] = residue(num, den)

tempo = 0:0.01:2,
y1 = r(1)*exp(p(1)*tempo) + r(2)*exp(p(2)*tempo);
y3= r(3)*exp(p(3)*tempo); y4 = r(4)*exp(p(4)*tempo);
% plot(tempo, y1, 'k', tempo, y3, 'c', tempo, y4, 'r');   % visualizzo i vari modi


% supponiamo di avere una funzione di trasferimento che cambia al variare
% di zeta

zita = 0.1:0.1:1;
num = 1;
for i = 1:length(zita)
    den = [1 2*zita(i) 1];
    g{i} = tf(num, den);        % vettore di celle o oggetti generalmente diversi tra loro
    [y{i}, t{i}] = step(G{i});
end

plot(t{1}, y{1})

