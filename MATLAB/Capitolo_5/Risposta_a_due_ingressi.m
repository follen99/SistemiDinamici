clear
clc
% Programma 5.2 Pagina 184
% L'obbiettivo di questo programma è quello di estrapolare l'uscita al
% sistema quando uno dei due ingressi è zero
MAX_TIME = 10;
MAGNITUDE = 0.01;

global LABEL_X_POSITION
LABEL_X_POSITION = 3;

DEFAULT_TOLERANCE = 0.05;
global t
t = 0:0.1:MAX_TIME;



A = [-1 -1; 6.5 0];
B = [1 1; 1 0];
C = [1 0; 0 1];
D = [0 0; 0 0];

sys = ss(A, B, C, D);
[y, t, x] = step(sys, t);

%Bisogna notare che y è una MATRICE che contiene due uscite per ogni
%ingresso (2 input) e quindi è una matrice 2x2;
% possiamo accedere ad ogni segnale di output nel seguente modo:

% uscite quando u2 = 0
y11 = y(:, 1, 1);   
y12 = y(:, 2, 1);

% uscite quando u1 = 0
y21 = y(:, 1, 2);   
y22 = y(:, 2, 2);

plot(t,y11,t,y21);
title('Risposta al gradino quando u2=0 (è presente solo u1)');


drawLabel(y11, DEFAULT_TOLERANCE, 'Y1')
drawLabel(y21, DEFAULT_TOLERANCE, 'Y2')

% questa funzione serve a disegnare un label in corrispondenza della
% curva. Accetta tre parametri:
% - array: l'array contenente la curva
% - tolerance: quanto vogliamo vicino il label
% - label: il testo da disegnare
function nienti = drawLabel(array, tolerance, label)
    global LABEL_X_POSITION
    global t

    y_coord = array(t==LABEL_X_POSITION);    %t==5 corrisponde a find(t==5)
    hold on
    text(LABEL_X_POSITION, y_coord+calculateOffset(array, tolerance), label);

    nienti = 1; % ok
end

% questa funzione serve a calcolare l'offset massimo della curva
function offset = calculateOffset(array, tolerance)
    % calcolo la distanza dalla curva a cui voglio posizionare il testo.
    M = max(array);
    m = min(array);
    distance = M-m;

    % voglio che il testo sia al 5% di distanza dalla curva rispetto alla sua
    % escursione (tra max e min)
    offset = tolerance*distance;
end


