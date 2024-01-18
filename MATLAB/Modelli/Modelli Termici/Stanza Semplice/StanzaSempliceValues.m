% La temperatura esterna alla stanza
Ta = 10;

%Flusso del radiatore, banalmente la temperatura che eroga il radiatore
Q = 50;

% Capacità termica della stanza
C = 100;

% Resistenza termica delle pareti della stanza
R = 2;

s = tf('s');
G = ((R/((s*R*C)+1))*Q) - (1/(s*R*C + 1))*Ta
step(G)

A = [-1/R*C];
B = [1/C 1/(R*C)];
C = [1];
D = [0 0];

G1 = ss(A, B, C, D)
step(G1)
