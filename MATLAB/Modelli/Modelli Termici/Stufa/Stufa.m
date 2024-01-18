clear; clc;
C1 = 1;         %Capacità termica della stufa
C2 = 1;         %Capacità termica della stanza

% k1 = 0.7;               % conducibilità termica del ferro
% width1 = 0.05;          % Spessore della parete della stufa in metri (1cm)
% R1 = width1/k1;         % Resistenza termica della stufa
% 
% k2 = 1.5;               % conducibilità termica del cemento
% width2 = .3;            % Spessore del muro in metri (30cm)
% R2 = width2/k2;         % Resistenza termica della stanza

R1 = 1;
R2 = 1;

Tr = 1;         % Temperatura della stufa (Radiatore)
Ts = 1;         % Temperatura della stanza

%Q = 0;          % U1 - Flusso
Q1 = 0;         % U1 - Flusso stufa (iniziale)
Q2 = 5;         % U1 - Flusso stufa (Finale)


Te1 = 1;         % U2 - Temperatura esterna alla stanza (iniziale)
Te2 = 5;         % U2 - Temperatura esterna alla stanza (finale)

A = [-1/C1*R1, 1/C1*R1; 1/C2*R1, -(R1+R2)/(C2*R1*R2)];
B = [1/C1, 0; 0, 1/C2*R2];
C = [0 1];
D = 0;

G = ss(A, B, C, D);
pzmap(G)

% [y, t, x] = step(G);
% plot(t, y(:, 1));
% hold on
% plot(t, y(:,2));
% 
% sum = y(:,1) + y(:,2);
% plot(t, sum)
% xlabel("Tempo");
% ylabel("Temperatura")
% 
% legend('Effetto da q', 'Effetto da Te', 'Sovrapposizione degli effetti');


