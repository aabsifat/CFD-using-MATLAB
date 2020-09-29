% ENGI 9977
% Winter 2019
% Abdullah Sifat

% FINAL EXAM

% 2D

% DATA


xl = 0.04 ; % length (x direction) of domain - (m)

yl = 0.02 ; % height (y direction) of the domain - (m)  

n = 41 ; % number of nodes in x direction - left to right

m = 21 ; % number of nodes in y direction - bottom to top


% Convection coefficient at left surface (W/m^2/C)
hl(1,1:m) = 40 ;
hl(1,16:m) = 0 ;

% fluid temperature at left surface - (deg C)
Tfl(1,1:m) = 30 ;
Tfl(1,16:m) = 0 ;


% Convection coefficient at right surfac (W/m^2/C)
hr(n,1:m) = 10 ;
hr(n,16:m) = 0 ;

% fluid temperature at right surface - (deg C)
Tfr(n,1:m) = 30 ;
Tfr(n,16:m) = 0 ;


% Convection coefficient at top surface (W/m^2/C)
ht(1:n,m) = 10 ;

% fluid temperature at top surfac - (deg C)
Tft(1:n,m) = 30 ;


% Convection coefficient at bottom surface (W/m^2/C)
hb(1:n,1) = 10 ;
hb(16:26,1) = 0 ;

% fluid temperature at bottom surface - (deg C)
Tfb(1:n,1) = 30 ;
Tfb(16:26,1) = 0 ;


Tinit = 20 ; % uniform initial temperature


tstart = 0 ; % start time (seconds)

tend = 1800 ; % end time (seconds)


dt = 100 ; % time step (seconds) 


iter = 2 ; % number of iterations per time step to find k


iterTDMA = 1000 ; % number of iterations for TDMA 2D Solver

resmaxfinal = 5e-4 ; % final acceptable residual


alpha = 1 ; % relaxation parameter

