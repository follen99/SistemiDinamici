% in questo esempio abbiamo 3 componenti: massa molla e smorzatore.
close all; clear; clc;


m = [1 5 10 50];      % massa
k = [-1 0 1 5 10];    % molla
b = [-1 0 1 5 10];    % smorzamento

t = 0:0.01:150;


num = [0 0 1];
den = [m(1) b(3) k(1)];

G_arr = [tf(num, den)];

% varia la molla
for i = 2:length(k)
    g_curr = tf([0 0 1], [m(1) b(3) k(i)]);
    G_arr = [G_arr, g_curr];
end

figure('Name','Risposta al gradino al variare di k (molla)')
for i = 1 : length(G_arr)
    [y, t, x] = step(G_arr(i), t);
    plot(t, y, 'DisplayName', append('molla k = ', string(k(i))));
    hold on
end
xlim([0 3]);
ylim([0 2]);
legend('Location','northwest')
legend show

G_arr = [tf([0 0 1], [m(1) b(3) k(3)])]; % pulisco G_arr

for i = 2:length(m)
    g_curr = tf([0 0 1], [m(i) b(3) k(3)]);
    G_arr = [G_arr, g_curr];
end

figure('Name','Risposta al gradino al variare di m (massa)')

for i = 1 : length(m)
    [y, t, x] = step(G_arr(i), t);
    plot(t, y, 'DisplayName', append('Massa m = ', string(m(i))));
    hold on
end
xlim([0 80])
legend show
