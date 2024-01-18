clear
clc

% Lo scopo del programma è quello di visualizzare una funzione di
% trasferimento al variare di zeta; siamo nel caso sottosmorzato quindi
% zeta va da 0 a 1  (estremi esclusi ma li includiamo per vedere tutti i
% casi, tranne quello del sistema instabile).

t = 0:0.1:10;
num = [0 0 1];
z = 0:0.2:1;            % creo zeta da zero ad 1 con incrementi di 0.2



for i = 1:length(z)             % scorro su tutti gli zeta
    den = [1 2*z(i) 1];         % denominatore dato dalla traccia
    sys_n = tf(num, den);       % definisco un diverso sistema per ogni zeta
    step(sys_n, t);             % stampo l'uscita per ogni sistema
    hold on
end
