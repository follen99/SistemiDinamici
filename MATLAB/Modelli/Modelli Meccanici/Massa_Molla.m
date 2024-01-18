% in questo modello abbiamo solo due elementi: massa e molla. La fdt
% dipende quindi solo da due valori: massa e coefficiente k.

close all; clc; clear;

m = 2;
k = [5 10 20];      % array dei coefficienti delle molle, maggiore è il coefficiente minore sarà l'ampiezza dell'oscillazione

t = 0:0.01:5;

num = [0 1];

figure('name','zeri e poli')                                            % figure 1
for i = 1:length(k)
    pzmap(tf(num, [m 0 k(i)]));
    hold on;
end

figure('name', 'Risposte nel tempo al variare della molla');           % figure 2
for i = 1:length(k)
    [y, t, x] = step(tf(num, [m 0 k(i)]), t);
    plot(t, y, 'DisplayName',append('molla k = ',string(k(i))))

    hold on;
end
xlabel("tempo");
ylabel("ampiezza");
legend show


