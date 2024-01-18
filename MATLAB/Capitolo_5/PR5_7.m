clear
clc
global MAGNITUDE
MAGNITUDE = 0.005;

% L'bbiettivo è di trovare il tempo di salita, tempo di picco,
% sovraelongazione massima e tempo di assestamento di un sistema del
% secondo ordine

num = [0 0 25];     % --> wn = 5
den = [1 6 25];     % --> z = 0.6

sys = tf(num, den);

t = 0:MAGNITUDE:2;
[y, t, x] = step(sys, t);

plot(t, y);         % disegno
xlim([0 2]);        % limite asse x
ylim([0 1.4]);      % limite asse y
hold on             % da questo momento scrivo sullo stesso grafico

%########## TEMPO DI SALITA ##########

% Trovo il tempo di salita: ovvero il tempo che la risposta impiega ad
% arrivare per la prima volta al valore di regime.
% Siccome il valore di regime della risposta sarà 1, allora ci basta
% trovare l'indice del primo valore maggiore di 1:

r = find(y > 1, 1);     % trovo l'indice del primo elemento di y che è maggiore di 1, potrei farlo anche con un while.

% di conseguenza il tempo di salita in secondi
rise_time = (r-1)*MAGNITUDE;

yline(1,':')                                    % disegno una linea orizzontale per demarcare il valore a regime
plot([rise_time rise_time],[0 y(r)], ':r');     % disegno una linea verticale che rappresenta il tempo di salita
plot(rise_time, y(r), 'ro', 'MarkerSize',5)
text(rise_time, y(r) + .1, 'Tr');

%########## TEMPO DI PICCO ##########

t_max = find(y == max(y));
y_max_coord = y(t_max);
x_max_coord = t_max*MAGNITUDE;

plot([x_max_coord x_max_coord], [0 y_max_coord], ':r' );
plot(x_max_coord, y_max_coord, 'ro', 'MarkerSize',5)
text(x_max_coord, y_max_coord + .1, 'Tp');

%########## SOVRAELONGAZIONE MASSIMA ##########
plot([x_max_coord x_max_coord], [1 y_max_coord], 'blue', 'LineWidth', 1.3);
Mp = y_max_coord - 1;
text(x_max_coord + 0.05, y_max_coord - (Mp/2), 'Mp', 'Color', 'blue');

%########## TEMPO DI ASSESTAMENTO ##########
max_percentage = 5;
% DA CALCOLARE!!!


%########## FUNZIONI ##########
% posso calcolare tutti i valori con la seguente funzione
s = stepinfo(sys)
