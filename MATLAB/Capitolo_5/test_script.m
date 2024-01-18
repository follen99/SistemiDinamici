close; clear; clc
MAGNITUDE = 0.1;
SIGNAL_BEFORE_ZERO_VISUALIZATION = 10;   % Il valore minimo per cui si vuole visualizzare un segnale nullo primad dello zero.

t = 0:MAGNITUDE:100;                     % ATTENZIONE - la simulazione arriva fino a 100*0.01 ma la visualizzazione fino a 50!
num = [0 0 1];
den = [1 0.2 1];

% L'importante è che la lunghezzxa di signal_before_zero e di t_before_zero
% siano la stessa!
signal_before_zero = zeros(SIGNAL_BEFORE_ZERO_VISUALIZATION/MAGNITUDE,1);
t_before_zero = (-SIGNAL_BEFORE_ZERO_VISUALIZATION:MAGNITUDE:(0-MAGNITUDE))';       % ATTENZIONE l'apice indica il trasposto

sys1 = tf(num, den);
[y, t, x] = impulse(sys1, t);

t = [t_before_zero; t];
y = [signal_before_zero; y];

plot(t, y)
xlim([-10 100])