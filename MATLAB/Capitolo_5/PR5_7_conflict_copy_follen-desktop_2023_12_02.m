clear
clc

% L'bbiettivo è di trovare il tempo di salita, tempo di picco,
% sovraelongazione massima e tempo di assestamento di un sistema del
% secondo ordine

global MAGNITUDE
MAGNITUDE = 0.005;

num = [0 0 25];     % --> wn = 5
den = [1 6 25];     % --> z = 0.6

sys = tf(num, den);

t = 0:MAGNITUDE:5;
[y, t, x] = step(sys, t);

plot(t, y);

% Trovo il tempo di salita: ovvero il tempo che la risposta impiega ad
% arrivare per la prima volta al valore di regime.
% Siccome il valore di regime della risposta sarà 1, allora ci basta
% trovare l'indice del primo valore maggiore di 1:


r = 1;              % gli array partono da 1 su matlab
while (y(r) < (1 + MAGNITUDE)) r = r+1; end         % trovo l'indice di y tale che il suo valore è maggiore di 1

r = y(1:find(y>1, 1));





