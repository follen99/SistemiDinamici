% disegnamo la funzione vista a lezione

%definisco l'insieme del tempo
T = 2*pi;
beta = pi - 0.01; %asin(1/sqrt(1+(44/3)^2))

A = 3/5 * sqrt(1 + (44/3)^2);


t = 0:T/10:3*T; % vediamo 3 periodi con un campionamento di T/10
size(t) % ci stampa il numero di righe e colonne del vettore
size(t') %stampa righe e colonne rel vettore trasposto

g = -A * sin(t + beta);

% plot(t,g) vecchio plot


t1 = 0:T/100:3*T;
g1 = -A * sin(t1 + beta);

plot(t,g,t,g,'o',t1,g1,'*')


ee1 = exp(-t1 / T) %ci permette di vedere più oscillazioni
h1 = ee1 .*g1;%il comando .* ci permette di fare il prodotto elemento per elemento (vettore in out)


plot(t1,g1,'*', t1, h1)


f1 = 3/5*(q-(sqrt(1+(44/3)^2))exp(-2 * t1)*sin(t1+beta)) %non c'è bisogno di aggiungere il "." all'addizione o sottrazione perche matlab interpreta l'addizione di una costante come un vettore di tutti uno.
