% la traccia chiede di ottenere i diagrammi di Bode per il sistema
% caratterizzato dalla funzione di trasferimento:
%fdt: g(s) = K/s(s+1)(s+5)
% bisogna tracciare i diagrammi per i valori di K=1, K=10; K=20
clear; clc; close all;
global CLEARANCE
CLEARANCE = 1;

K = [1 10 20];

[lower, upper] = calcBounds(1, [1 6 5 1]);
w = logspace(lower, upper, 1000);         % genero l'asse delle pulsazioni w a partire dai lower e upper bounds

for i= 1:3
    [mag, phase, w] = bode(K(i), [1 6 5 K(i)], w);    % creo i valori di modulo e fase del diagramma di bode

    magdB(:, i) = 20*log10(mag);
    phase2d(:, i) = phase;
end

% plot dei moduli
subplot(2,1,1)
semilogx(w, magdB(:,1), w, magdB(:,2), w, magdB(:,3));
grid on

max_arr = [max(magdB(:,1)), max(magdB(:,2)), max(magdB(:,3))];
min_arr = [min(magdB(:,1)), min(magdB(:,2)), min(magdB(:,3))];

ylim([min(min_arr) max(max_arr)+20]);

legend("K=1", "K=10", "K=20")


% plot delle fasi
subplot(2,1,2)
semilogx(w, phase2d(:,1), w, phase2d(:,2), w, phase2d(:,3));
legend("K=1", "K=10", "K=20")



function [lower, upper] = calcBounds(num, den)
    global CLEARANCE
    % ottengo gli zeri, i poli ed il guadagno
    [z, p, k] = tf2zp(num, den);
    p = p*-1;       % le frequenze sono il modulo dei poli
    p = p(p>0);     % se ci sono poli in origine non sono utili al calcolo delle frequenze, li tolgo
    
    % trovo l'esponente piu piccolo e quello piu grande, e prendo un intervallo
    % di un ordine di grandezza piu grande e piu piccolo.   Ricorda di prendere
    % sempre almeno un ordine di grandezza in piu e in meno!
    
    lower = floor(log10(abs(min(p)))) -CLEARANCE;   % prendo CLEARENCE ordini di grandezza in più
    upper = floor(log10(abs(max(p)))) +CLEARANCE;   % prendo CLEARENCE ordini di grandezza in meno
end