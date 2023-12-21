% la traccia chiede di ottenere i diagrammi di Bode per il sistema
% caratterizzato dalla funzione di trasferimento:
%fdt: g(s) = K/s(s+1)(s+5)
% bisogna tracciare i diagrammi per i valori di K=1, K=10; K=20
clear; clc; close all;
CLEARANCE = 2;

K = 1;
num = [0 0 0 K];
den = [1 6 5 0];

sys1 = tf(num, den);

% ottengo gli zeri, i poli ed il guadagno
[z, p, k] = tf2zp(num, den);
p = p*-1;       % le frequenze sono il modulo dei poli
p = p(p>0);     % se ci sono poli in origine non sono utili al calcolo delle frequenze, li tolgo

% trovo l'esponente piu piccolo e quello piu grande, e prendo un intervallo
% di un ordine di grandezza piu grande e piu piccolo.   Ricorda di prendere
% sempre almeno un ordine di grandezza in piu e in meno!

lower = floor(log10(abs(min(p)))) -CLEARANCE;   % prendo CLEARENCE ordini di grandezza in più
upper = floor(log10(abs(max(p)))) +CLEARANCE;   % prendo CLEARENCE ordini di grandezza in meno

w = logspace(lower, upper);         % genero l'asse delle pulsazioni w a partire dai lower e upper bounds

[mag, phase, w] = bode(sys1, w);    % creo i valori di modulo e fase del diagramma di bode

% non possiamo usare "mag" così com'è perchè è un'array tridimensionale [1x1x50],
% dobbiamo quindi convertirlo in un array bidimensionale [1x50].
n = length(w);                      
mod2d(1:n) = 20*log10(mag(1,1,:));  % converto in un array bidimensionale e ne calcolo il valore in decibel.
phase2d(1:n) = phase(1,1,:);          % della fase non mi serve il valore in dB.

%#################### DISPLAY ####################
grid on;

subplot(2,1,1);
semilogx(w, mod2d);                 % posso finalmente fare il plot dei moduli
title("Diagramma di Bode dei moduli");
xlabel("Pulsazioni");
ylabel("Moduli in dB");
drawBreakingPoints(p);              % disegno i punti di rottura


subplot(2,1,2);
semilogx(w, phase2d);
title("Diagramma di Bode delle fasi");
xlabel("Pulsazioni");
ylabel("Fasi in gradi");
drawBreakingPoints(p);


% funzione che disegna delle linee verticali in corrispondenza dei punti di
% rottura
function drawBreakingPoints(p)
    for i = 1:length(p)
        xline(p(i))
    end
end