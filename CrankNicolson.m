% Abdullah Sifat
% MATH 451
% Project

% Crank-Nicolson


function T = CrankNicolson (delx,delt,tf)

% Initial & Boundary Conditions
A = 0.1 ;   %ft^2/hr   diffusivity
L = 1;   %  ft   total thickness of the wall 
IM = (L/delx)+1;
NM = (tf/delt)+1;
d = (A*delt)/(delx^2);


% tri diagonal matrix
a = -(d/2);
b = (1+d);
c = -(d/2);
Diag1 = zeros(1,IM-2)+b;
Diag2 = zeros(1,IM-3)+a;
Diag3 = zeros(1,IM-3)+c;
Mx1 = diag(Diag1);
Mx2 = diag(Diag2,1);
Mx3 = diag(Diag3,-1);
M = Mx1+Mx2+Mx3;


% initial & boundary conditions (Temp deg F)
T = zeros(IM,NM);
T(:,1) = 100;
T(1,:) = 300;
T(IM,:) = 300;


% right hand side known variables
for t = 1:NM-1
    for x = 2:IM-1
        RHS(x-1,t) = (1-d)*T(x,t) + (d/2)*T(x+1,t) + (d/2)*T(x-1,t) - a*T(x-1,t+1); 
        RHS(IM-2,t) = (1-d)*T(x,t) + (d/2)*T(x+1,t) + (d/2)*T(x-1,t) - (c*T(x+1,t+1));
    end
    RHS1(:,t) = RHS(:,t);
    % Solve the linear equations
    U = linsolve(M,RHS1);
    % Put the first column of calculated data into T matrix
    for p = 1:19
        T(p+1,t+1) = U(p,t);
    end
end


% Open file to print solution
table = fopen('Crank_Nicolson.txt','wt'); 
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








