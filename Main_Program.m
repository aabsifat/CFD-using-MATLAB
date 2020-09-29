% ENGI 9977
% Winter 2019
% Abdullah Sifat

% FINAL EXAM

% 2D

% Main Program


clear
close all
clc

tic

DATA       % call DATA routine
GRID       % call GRID routine
INITIALIZE % call Initialize routine

t = tstart ;
while t < tend
    t = t + dt ;
    for r = 1:iter
        GAMSOR % call GAMSOR routine 
        COEFF % call COEFF routine
        TDMA2D % call solver 
    end
    Told = T ;
end

toc

%%%%%%%%%%%%%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure (1)
surf (x,y,T) ;
colormap hot ;
title ('2D - Temperature Distribution') ;
xlabel ('x (m)') ;
ylabel ('y (m)') ;
zlabel ('Temperature (C)') ;