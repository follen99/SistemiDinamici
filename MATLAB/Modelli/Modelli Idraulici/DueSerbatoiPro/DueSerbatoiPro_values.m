clear; clc;

% La corrente che viene riversata nei due serbatoi
Q11 = 1;
Q12 = 2;

Q21 = 1;
Q22 = 3;

% La capacità di ogni serbatoio
C1 = 10;
C2 = 10;

% La resistenza delle condotte che collegano i serbatoi
R1 = 1  ;
R2 = 1;

% La pressione atmosferica alla base. Se P2>>Pa allora Pa = 0
Pa = 0; 

% Densità volumetrica [kh/m^3]
ro = 1000;

% Costante gravitazionale terrestre [m/s^2]
g = 9.81;