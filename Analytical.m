% Abdullah Sifat
% MATH 451
% Project

% Analytical Solution        


function Soln = Analytical (delx,delt,tf)

% Constants
A = 0.1 ;   %ft^2/hr   diffusivity
L = 1;   %  ft   total thickness of the wall 
IM = (L/delx)+1;
NM = (tf/delt)+1;
d = (A*delt)/(delx^2);
t = 0;

Soln = zeros(IM,NM);

for q = 1:NM
    if q == 1
        t = 0;
    else
        t = t + delt;
    end
    x = 0;
    for w = 1:IM  
        if w == 1
            x = 0;
        else
            x = x + delx;
        end
        S1 = 0;
        for m = 1:50 
            S2 = (exp(-((m*pi/L)^2)*A*t))*((1-((-1)^m))/(m*pi))*(sin(m*pi*x/L));
            S1 = S1 + S2;
        end
        Soln(w,q) = 300 + 2*(100-300)*S1;
    end
end


% Print Analytical Solution to file
tab = fopen('Analytical.txt','wt'); 
fprintf(tab,'X(ft)      t = 0.0       t = 0.1       t = 0.2       t = 0.3       t = 0.4       t = 0.5\n');
if delt == 0.01
    ft = 0 ;
    for p = 1:IM
    if p == 1
        fprintf (tab,'0.0        %3.3f       %3.3f       %3.3f       %3.3f       %3.3f       %3.3f\n' , Soln(p,1),Soln(p,11),Soln(p,21),Soln(p,31),Soln(p,41),Soln(p,51));
    else
        fprintf (tab,'%3.3f      %3.3f       %3.3f       %3.3f       %3.3f       %3.3f       %3.3f\n' , ft,Soln(p,1),Soln(p,11),Soln(p,21),Soln(p,31),Soln(p,41),Soln(p,51));
    end
    ft = ft + delx;
    end
elseif delt == 0.05
    ft = 0 ;
    for p = 1:IM
    if p == 1
        fprintf (tab,'0.0        %0.3f       %0.3f       %0.3f       %0.3f       %0.3f       %0.3f\n' , Soln(p,3),Soln(p,5),Soln(p,7),Soln(p,9),Soln(p,11));
    else
        fprintf (tab,'%0.3f      %0.3f       %0.3f       %0.3f       %0.3f       %0.3f       %0.3f\n' , ft,Soln(p,3),Soln(p,5),Soln(p,7),Soln(p,9),Soln(p,11));
    end
    ft = ft + delx;
    end
end
fclose(tab);


end




