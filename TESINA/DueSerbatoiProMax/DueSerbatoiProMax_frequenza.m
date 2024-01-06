clc; clear;
DEFAULT_EXIT = 2;

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

sys = ss(A, B, C, D);
% chiamando questa funzione posso calcolare automaticamente la banda che mi
% interessa nella visualizzazione dei diagrammi di bode.
% come ultimo argomento viene passato il valore di CLEARANCE, ovvero quante
% decadi voglio prendere in più rispetto alle freq corrispondenti ai punti
% di rottura.
[lower_bound, upper_bound] = calcBounds(A, B, C, D, 2);
w = logspace(lower_bound, upper_bound);


mag_phase_w = cell(1,3);        % pre-alloco della memoria per posizionare i valori di mag e fase dei 3 output


figure('Name',"Modulo e fase dai diversi input")
subplot(2,2,1)
[mag, phase, w] = bode(sys, w);
magdB(:,:,1) = 20*log10(mag);
semilogx(w, magdB);
title("Diagramma dei moduli dai diversi input")
grid on

subplot(2,2,3)
phase2d(:,:,1) = phase;
semilogx(w, phase2d);
title("Diagramma delle fasi dai diversi input")
grid on


% % metodo "a manella"
% arr1 = magdB(1,:);
% arr2 = magdB(2,:);
% arr3 = magdB(3,:);
% bode_summ = arr1+arr2+arr3;

magdB_sum = sum(magdB, [1 3]);      % sommo membro a membro i valori della matrice
subplot(2,2,2)
semilogx(w, magdB_sum)
title("Diagramma dei moduli totale")
grid on

phase_sum = sum(phase2d, [1 3]);
subplot(2,2,4)
semilogx(w, phase_sum)
title("Diagramma delle fasi totale")
grid on



% ##### FUNZIONI #####

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

function [lower, upper] = calcBounds(A, B, C, D, CLEARANCE)
    % ottengo gli zeri, i poli ed il guadagno
    lower = 10;
    upper = -10;

    % Posiziono l'operazione in un for perchè abbiamo 3 input diversi; mi
    % serve inoltre l'upper bound ed il lower bound; mi interessa prendere
    % quelli in assoluto più grandi a seconda dell'input, quindi controllo:
    for i = 1:3
        [z, p, k] = ss2zp(A, B, C, D, i);
        p = p*-1;       % le frequenze sono il modulo dei poli
        p = p(p>0);     % se ci sono poli in origine non sono utili al calcolo delle frequenze, li tolgo
        % trovo l'esponente piu piccolo e quello piu grande, e prendo un intervallo
        % di un ordine di grandezza piu grande e piu piccolo.   Ricorda di prendere
        % sempre almeno un ordine di grandezza in piu e in meno!
        
        
        lower_curr = floor(log10(abs(min(p)))) -CLEARANCE;   % prendo CLEARENCE ordini di grandezza in più
        if lower_curr < lower
            lower = lower_curr;
        end

        upper_curr = floor(log10(abs(max(p)))) +CLEARANCE;   % prendo CLEARENCE ordini di grandezza in meno
        if upper_curr > upper
            upper = upper_curr;
        end
    end

    
end