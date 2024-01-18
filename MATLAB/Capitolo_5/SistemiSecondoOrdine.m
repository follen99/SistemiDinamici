clear
clc

%Definisco la funzione di trasferimento del secondo ordine
wn = 5;                                 % ovvero omega_n
damping_ratio = 0.4;                    % ovvero zita

[num, den] = ord2(wn, damping_ratio);   % definisco numeratore e denominatore tramite la funzione ord2()

printsys(num, den);                     % questo comando ci restituisce la funzione di trasferimento senza il wn al num

% dobbiamo quindi moltiplicarla per wn^2 (ovvero l'ampiezza):
num = num*wn^2;
printsys(num, den)

sys = tf(num, den);                     % definisco il sistema tramite la funzione tf()
step(sys)                               % visualizzo la risposta del sistema al gradino