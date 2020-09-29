% ENGI 9977
% Winter 2019
% Abdullah Sifat

% FINAL EXAM

% 2D

% GAMSOR


% conductivity at each node - (W/m/K)
k(1:n,1:m) = 1 + 0.05*T ; % KA
k(20:31,5:7) = 2 ; % KB
k(6:10,6:16) = 1 ; % KC
k(17:22,12:16) = 1 ; % KC
k(29:34,12:16) = 1 ; % KC


% density of materials at each node (kg/m^3)
rho(1:n,1:m) = 500 ; % rho A
rho(20:31,5:7) = 1000 ; % rho B
rho(6:10,6:16) = 1500 ; % rho C
rho(17:22,12:16) = 1500 ; % rho C
rho(29:34,12:16) = 1500 ; % rho C


% specific heat at each node (J/kg/K)
cp(1:n,1:m) = 800 + 2*T ; % cp A
cp(20:31,5:7) = 1000 ; % cp B
cp(6:10,6:16) = 1500 ; % cp C
cp(17:22,12:16) = 1500 ; % cp C
cp(29:34,12:16) = 1500 ; % cp C


% Source term (W/m^3)
% Sc = S - dt/dS

Sc(1:n,1:m) = 0 ; % Sc A & B
Sc(6:10,6:16) = 1e6 ; % Sc C
Sc(17:22,12:16) = 1e6 ; % Sc C
Sc(29:34,12:16) = 1e6 ; % Sc C
    
% Sp = dt/dS
Sp(1:n,1:m) = 0 ; % Sp A & B
Sp(6:10,6:16) = -1000*T(6:10,6:16) ; % Sp C
Sp(17:22,12:16) = -1000*T(17:22,12:16) ; % Sp C
Sp(29:34,12:16) = -1000*T(29:34,12:16) ; % Sp C
    
% Activate Sink at B after 900 seconds
if t > 900
    Sc(20:31,5:7) = -1e6 ; % Sc B
end



