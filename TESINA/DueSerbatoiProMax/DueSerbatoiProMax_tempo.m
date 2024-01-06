% Questo modello descrive un sistema composto da due serbatoi connessi da
% una condotta molto lunga (ha quindi una resistenza ed un'induttanza); al
% di sopra di entrambi i serbatoi è posto un rubinetto, quindi abbiamo due
% flussi in entrata. Abbiamo inoltre un flusso in "uscita" dato da una
% condotta anch'essa molto lunga (quindi caratterizzata da un'altra
% resistenza e conduttanza) che sfocia "a valle", quindi in condizioni di
% "pressione Atmosferica". Abbiamo quindi una differenza di pressione tra
% l'inizio della condotta e la fine.
clc; clear;
DEFAULT_EXIT = 1;

% La resistenza idraulica si misura in [Differenza di pressione]/[portata]
R1 = 1;
R2 = 1;

% Capacità serbatoio in litri
% La dimensione più precisamente è [Superficie]/[Ro*g], dove
% ro = [kg]/[m^3]
% g = [m]/[s^2]
C1 = 100;       
C2 = 120;

% L'induttanza idraulica si misura come [ro * h] / [s], dove
% ro = [kg]/[m^3]
% h = m
% s = m^2
L1 = 1;
L2 = 1;

% Pressione atmosferica espressa in gradi
Pa = 5;

ro = 1000;
g = 9.81;

% Siccome voglio cambiare i valori di capacità, induttanza e resistenza, mi
% conviene utilizzare una funzione che aggiorna i valori ogni volta che mi
% serve.
[A, B, C, D] = updateMatrixes(C1, C2, R1, R2, L1, L2);

G_default = ss(A, B, C, D);         % Sistema a partire dallo spazio di stato              

TFs = tf(G_default);                % Funzioni di trasferimento per i diversi input


% ########## VISUALIZZO ZERI E POLI NEL PIANO DI GAUSS ##########
figure('Name',"Piano complesso")
pzmap(G_default)

% ########## TROVO LA RISPOSTA AD UN SEGNALE COMPOSTO DA 3 INPUT ##########
figure('Name',"Risposta al gradino")
t = 0:0.1:1500;

% Ricordando che 
% u1 = flusso tank 1
% u2 = flusso tank 2
% u3 = pressione atmosferica Pa

% Voglio ad esempio trovare la risposta quando i due flussi valgono 1 e la
% pressione atmosferica vale 5:
[y1, t1] = step(G_default(1), t);       % input 1
subplot(2,3,1)
plot(t1,y1);
xlabel("tempo (s)")
ylabel("Ampiezza")
title("Modo da input 1 - flusso tank 1");

[y2, t2] = step(G_default(2), t);       % input 2
subplot(2,3,2)
plot(t1,y2);
xlabel("tempo (s)")
ylabel("Ampiezza")
title("Modo da input 2 - flusso tank 2");

% Per l'entrata 3, ovvero la pressione atmosferica, devo "creare" un segnale custom, 
% calcolare l'uscita e farne l'antitrasformata:
s = tf('s');
U1 = 5 * 1/s;                       % gradino di ampiezza 5 nel dominio di Laplace
Y1 = G_default(3)*U1;               % calcolo l'uscita nel dominio di Laplace
[y3, t3] = impulse(Y1, t);          % calcolo l'antitrasformata

subplot(2,3,3)
plot(t1,y3);
xlabel("tempo (s)")
ylabel("Ampiezza")
title(sprintf("Modo da input 3 - Pressione atmosferica = %i", Pa))

subplot(2,3,[4 5])
plot(t1, y1+y2+y3, 'LineWidth',2)
title(sprintf("Uscita totale con Pa = %i", Pa))
hold on
plot(t1,y1);
plot(t1,y2);
plot(t1,y3);
xlabel("tempo (s)")
ylabel("Ampiezza")
legend('Uscita totale', 'Input 1','Input 2','Input 3');
hold off

% ########## RISPOSTA AD UN SEGNALE CUSTOM ##########

% Se ad esempio volessi modificare l'input 1, magari dicendo che dopo 500
% secondi cambia valore, potrei farlo:

U21 = 1/s;                                  % Gradino unitario
U22 = tf([0 1], [1 0], 'inputDelay', 500);  % Gradino ritardato di 100
U2 = U21 + U22;                             % Trovo il segnale risultante

Y3 = G_default(1) * U2;
[y2, t2] = impulse(Y3);
subplot(2,3,6)
plot(t2, y2);
title("Input 1 cambia valore da 1 a 2 dopo 500s");
xlabel("tempo (s)")
ylabel("Ampiezza")


% ########## USCITA AL VARIARE DEI PARAMETRI ##########
figure('Name',"Uscita al variare della capacità")

% VARIA L'INDUTTANZA DEL TANK 1
n = 5;
legend_text = cell(n, 1);               % preallocazione della memoria
for i=1:n
    G_capcity_1 = ss(A, B, C, D);       % Rappresento il sistema con il valore di C1 corrente

    [yn, tn] = step(G_capcity_1);       % Calcolo la risposta al gradino unitario
    yn_sum = sum(yn, [2 3]);            % Sommo le uscite dei 3 ingressi
    plot(tn, yn_sum)                    % Disegno le diverse uscite
    hold on;

    legend_text{i} = sprintf("Capacita' = %i", C1);         % Attribuisco ad ogni curva un nome per la legenda
    C1 = C1 + 50;                       % Aggiorno il valore di C per la prossima iterazione
    [A, B, C, D] = updateMatrixes(C1, C2, R1, R2, L1, L2);  % Aggiorno le matrici con il valore di C corrente
end
xlabel("tempo (s)")
ylabel("Ampiezza")
title("Uscita totale al variare della capacità del Tank 1")

legend(legend_text)                     % Mostro la legenda
C1 = 100;                               % Ripristino il valore iniziale di C1 ed aggiorno
[A, B, C, D] = updateMatrixes(C1, C2, R1, R2, L1, L2);
hold off;


% VARIA L'INDUTTANZA DELLA CONDOTTA 1
figure('Name',"Uscita al variare dell'induttanza")

n = 5;
legend_text = cell(n, 1);               % preallocazione della memoria
for i=1:n
    G_inductance_1 = ss(A, B, C, D);       % Rappresento il sistema con il valore di C1 corrente

    [yn, tn] = step(G_inductance_1);       % Calcolo la risposta al gradino unitario
    yn_sum = sum(yn, [2 3]);            % Sommo le uscite dei 3 ingressi
    plot(tn, yn_sum)                    % Disegno le diverse uscite
    hold on;

    legend_text{i} = sprintf("Induttanza L1 = %i", L1);         % Attribuisco ad ogni curva un nome per la legenda
    L1 = L1 + 150;                       % Aggiorno il valore di C per la prossima iterazione
    [A, B, C, D] = updateMatrixes(C1, C2, R1, R2, L1, L2);  % Aggiorno le matrici con il valore di C corrente
end

xlabel("tempo (s)")
ylabel("Ampiezza")
title("Uscita totale al variare dell'induttanza della condotta 1")

legend(legend_text)                     % Mostro la legenda
L1 = 1;                               % Ripristino il valore iniziale di C1 ed aggiorno
[A, B, C, D] = updateMatrixes(C1, C2, R1, R2, L1, L2);
hold off;

% VARIA LA RESISTENZA DELLA CONDOTTA 1
figure('Name',"Uscita al variare della resistenza")

n = 5;
legend_text = cell(n, 1);               % preallocazione della memoria
resistance_time = 0:100:10^5/2;
for i=1:n
    G_resistance_1 = ss(A, B, C, D);       % Rappresento il sistema con il valore di C1 corrente

    [yn, tn] = step(G_resistance_1,resistance_time);       % Calcolo la risposta al gradino unitario
    yn_sum = sum(yn, [2 3]);            % Sommo le uscite dei 3 ingressi
    plot(tn, yn_sum)                    % Disegno le diverse uscite
    hold on;

    legend_text{i} = sprintf("Resistenza R1 = %i", R1);         % Attribuisco ad ogni curva un nome per la legenda
    R1 = R1 + 15;                       % Aggiorno il valore di C per la prossima iterazione
    [A, B, C, D] = updateMatrixes(C1, C2, R1, R2, L1, L2);  % Aggiorno le matrici con il valore di C corrente
end

xlabel("tempo (s)")
ylabel("Ampiezza")
title("Uscita totale al variare dell'induttanza della condotta 1")

legend(legend_text)                     % Mostro la legenda
R1 = 1;                               % Ripristino il valore iniziale di C1 ed aggiorno
[A, B, C, D] = updateMatrixes(C1, C2, R1, R2, L1, L2);
hold off;



% ###### FUNZIONI ######
function [A, B, C, D] = updateMatrixes(C1, C2, R1, R2, L1, L2)
    A = [   0,      0,      -1/C1,      0;
        0,      0,      1/C2,       -1/C2;
        1/L1,   -1/L1,  -R1/L1,      0;
        0,      1/L2,   0,          -R2/L2
    ];

    B = [   1/C1,   0,      0;
            0,      1/C2,   0;
            0,      0,      0;
            0,      0,      -1/L2
        ];
    
    C = [1, 0, 0, 0];
    D = [0, 0, 0];
end

