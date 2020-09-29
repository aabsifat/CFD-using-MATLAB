% Abdullah Sifat
% MATH 451
% Project

% FTCS explicit


function T = FTCS (delx,delt,tf)

% Initial & Boundary Conditions
A = 0.1 ;   %ft^2/hr   diffusivity
L = 1;   %  ft   total thickness of the wall 
IM = (L/delx)+1;
NM = (tf/delt)+1;
d = (A*delt)/(delx^2);

T = zeros(IM,NM);

% boundary condition (Temp deg F)
T(1,1:NM) = 300;
T(IM,1:NM) = 300;

% initial condition (Temp deg F)
T(2:IM-1,1) = 100;


% Temperature Distribution Numerical Solution
for t = 1:NM-1
    for x = 2:IM-1
    T(x,t+1) = T(x,t) + (d*(T(x+1,t) - 2*(T(x,t)) + T(x-1,t)));
    end
end


% Open file to print solution
table = fopen('FTCS.txt','wt'); 
fprintf(table,'X(ft)      t = 0.0       t = 0.1       t = 0.2       t = 0.3       t = 0.4       t = 0.5\n');
if delt == 0.01
    ft = 0 ;
    for p = 1:IM
    if p == 1
        fprintf (table,'0.0        %0.3f       %0.3f       %0.3f       %0.3f       %0.3f       %0.3f\n' , T(p,1),T(p,11),T(p,21),T(p,31),T(p,41),T(p,51));
    else
        fprintf (table,'%0.2f       %0.3f       %0.3f       %0.3f       %0.3f       %0.3f       %0.3f\n' , ft,T(p,1),T(p,11),T(p,21),T(p,31),T(p,41),T(p,51));
    end
    ft = ft + delx;
    end
elseif delt == 0.05
    ft = 0 ;
    for p = 1:IM
    if p == 1
        fprintf (table,'0.0        %0.3f       %0.3f       %0.3f       %0.3f       %0.3f       %0.3f\n' , T(p,3),T(p,5),T(p,7),T(p,9),T(p,11));
    else
        fprintf (table,'%0.2f      %0.3f       %0.3f       %0.3f       %0.3f       %0.3f       %0.3f\n' , ft,T(p,3),T(p,5),T(p,7),T(p,9),T(p,11));
    end
    ft = ft + delx;
    end
end
fclose(table);



end














