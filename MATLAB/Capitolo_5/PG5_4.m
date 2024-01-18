clear
clc

num = [0 0 25];
den = [1 4 25];

sys = tf(num, den);
[y, t, x] = step(sys);

plot(t, y, 'r', 'LineWidth',1);