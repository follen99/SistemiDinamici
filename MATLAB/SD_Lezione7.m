T = 0.01;
omega = 2*pi/T;
num = [1 3];
den = [1 3 2];

printsys(num, den);
g = tf(num, den); % è la nostra funzinoe trasformata

pole(g) %stampa i poli
zero(g) %stampa gli zeri

%vogliamo fare la scomposizioni in fratti semplici con residue
[r, p, k] = residue(num, den); %calcola i residui, poli ed eventuale guadagno.

% voglio scegliere un tempo tale che il passi di campionamento sia un decimo di quello più veloce, quindi prendiamo il massimo del vettore p ma in valore assoluto (il più piccolo)
% 1/max(abs(p)) è la pendenza della retta della costante di tempo dell'esponenziale più veloce di tutti
deltat = 1/max(abs(p))/10;
t = 0:deltat:10;

%calcoliamo la soluzione (antitrasformata) x(t)
x= r(1)*exp(p(1)*t) + r(2)*exp(p(2)*t);


x1 = r(1)*exp(p(1)*t);
x2 = r(2)*exp(p(2)*t);


plot(t, x, 'LineWidth', 5)
hold on

plot(t, x1, 'r+', t, x2, 'k*')
hold off

%approssimazione lineare di x1 in zero
applinx1 = r(1) + r(1) * p * t;

% (applinx1 <= 0) ci da un vettore di zero ed uno, è tutti uno quando applinx1 è minore di zero; in questo modo filtriamo applinx1 fino a quando i suoi valori sono minori di zero
applinx1_trunc = applinx1 .* (applinx1 <=0);

figure(2);
plot(t,x1, 'k', t, applinx1, '--')


%voglio trovare l'istante di tempo in cui un determinato segnale si annulla
% la prima cosa da capire è se esiste un istante di tempo in cui si annulla; non è detto che nel vettore del tempo da noi creato ci sia l'istante di tempo in cui la funzione si annulla.

%find trova l'indice per il quale la condizione è soddisfatta
indfin = max(find(applinx1<= 0))

tt = t(1:indfin);
plot(t, applinx1, 'LineWidth', 4)
hold on