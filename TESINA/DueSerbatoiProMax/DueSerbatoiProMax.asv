% Questo modello descrive un sistema composto da due serbatoi connessi da
% una condotta molto lunga (ha quindi una resistenza ed un'induttanza); al
% di sopra di entrambi i serbatoi è posto un rubinetto, quindi abbiamo due
% flussi in entrata. Abbiamo inoltre un flusso in "uscita" dato da una
% condotta anch'essa molto lunga (quindi caratterizzata da un'altra
% resistenza e conduttanza) che sfocia "a valle", quindi in condizioni di
% "pressione Atmosferica". Abbiamo quindi una differenza di pressione tra
% l'inizio della condotta e la fine.
clc; clear;

R1 = 1;
R2 = 1;

% Capacità serbatoio in litri
C1 = 100;       
C2 = 120;

L1 = 1;
L2 = 1;

Pa = 1;

ro = 1000;
g = 9.81;


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

G = ss(A, B, C, D);         % Sistema a partire dallo spazio di stato              

TFs = tf(G);                % Funzioni di trasferimento per i diversi input

step(G);


