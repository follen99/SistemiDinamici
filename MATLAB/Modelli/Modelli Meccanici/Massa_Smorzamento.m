% in questo modello abbiamo solo due elementi: massa e smorzatore. La fdt
% dipende quindi solo da due valori: massa e smorzamento.

close all; clc; clear;

m = 2;
b = [1 10 100];

t = 0:0.01:16;

s = tf('s');
%G = 1/(m*s+b(3))

G_array = [1/(m*s+b(1))];   % primo elemento dell'array composto da funzioni di trasferimento

for i = 2:length(b)
    G_curr = 1/(m*s+b(i));
    G_array = [G_array, G_curr];
end

G_array


figure('name', 'Mappa degli zeri e dei poli');  % fingure 1
for i = 1:length(G_array)
    pzmap(G_array(i));
    hold on;
    legend('Elemento k')
end
grid on;

U11 = 1/s;
U12 = tf([0 1], [1 0], 'inputDelay', 1);
U1 = U11 + U12;
figure(3);
impulse(U1)

figure('name', 'Risposte nel tempo');           % figure 2
for i = 1:length(G_array)
%     [y, t, x] = step(G_array(i),t);
%     plot(t, y, 'DisplayName',append('b = ',string(b(i))))
    
    Y1 = G_array(i) * U1;
    [y, t, x] = impulse(Y1, t);
    plot(t, y, 'DisplayName',append('b = ',string(b(i))));

    hold on;
end
legend show


