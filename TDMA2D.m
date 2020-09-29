% ENGI 9977
% Winter 2019
% Abdullah Sifat

% FINAL EXAM

% 2D

% TDMA 2D Solver


RESIDUAL % call residual routine
it=0; % define the iteration counter
while (resmax > resmaxfinal) && (it < iterTDMA)
    it=it+1;
    % i-sweep (along constant j-lines)
    j=1;
    i=1;
    bstar=b(i,j)+aN(i,j)*T(i,j+1);
    P(i)=aE(i,j)/aP(i,j);
    Q(i)=bstar/aP(i,j);
    for i=2:1:n-1
        bstar=b(i,j)+aN(i,j)*T(i,j+1);
        P(i)=aE(i,j)/(aP(i,j)-aW(i,j)*P(i-1));
        Q(i)=(bstar+aW(i,j)*Q(i-1))/(aP(i,j)-aW(i,j)*P(i-1));
    end
    i=n;
    bstar=b(i,j)+aN(i,j)*T(i,j+1);
    P(i)=0;
    Q(i)=(bstar+aW(i,j)*Q(i-1))/(aP(i,j)-aW(i,j)*P(i-1));
    T(i,j)=Q(i);
    for i=n-1:-1:1
        T(i,j)=P(i)*T(i+1,j)+Q(i);
    end
    for j=2:1:m-1
        i=1;
        bstar=b(i,j)+aN(i,j)*T(i,j+1)+aS(i,j)*T(i,j-1);
        P(i)=aE(i,j)/aP(i,j);
        Q(i)=bstar/aP(i,j);
        for i=2:1:n-1
            bstar=b(i,j)+aN(i,j)*T(i,j+1)+aS(i,j)*T(i,j-1);
            P(i)=aE(i,j)/(aP(i,j)-aW(i,j)*P(i-1));
            Q(i)=(bstar+aW(i,j)*Q(i-1))/(aP(i,j)-aW(i,j)*P(i-1));
        end
        i=n;
        bstar=b(i,j)+aN(i,j)*T(i,j+1)+aS(i,j)*T(i,j-1);
        P(i)=0;
        Q(i)=(bstar+aW(i,j)*Q(i-1))/(aP(i,j)-aW(i,j)*P(i-1));
        T(i,j)=Q(i);
        for i=n-1:-1:1
            T(i,j)=P(i)*T(i+1,j)+Q(i);
        end
    end
    j=m;
    i=1;
    bstar=b(i,j)+aS(i,j)*T(i,j-1);
    P(i)=aE(i,j)/aP(i,j);
    Q(i)=bstar/aP(i,j);
    for i=2:1:n-1
        bstar=b(i,j)+aS(i,j)*T(i,j-1);
        P(i)=aE(i,j)/(aP(i,j)-aW(i,j)*P(i-1));
        Q(i)=(bstar+aW(i,j)*Q(i-1))/(aP(i,j)-aW(i,j)*P(i-1));
    end
    i=n;
    bstar=b(i,j)+aS(i,j)*T(i,j-1);
    P(i)=0;
    Q(i)=(bstar+aW(i,j)*Q(i-1))/(aP(i,j)-aW(i,j)*P(i-1));
    T(i,j)=Q(i);
    for i=n-1:-1:1
        T(i,j)=P(i)*T(i+1,j)+Q(i);
    end
    % j-sweep (along constant i-lines)
    i=1;
    j=1;
    bstar=b(i,j)+aE(i,j)*T(i+1,j);
    P(j)=aN(i,j)/aP(i,j);
    Q(j)=bstar/aP(i,j);
    for j=2:1:m-1
        bstar=b(i,j)+aE(i,j)*T(i+1,j);
        P(j)=aN(i,j)/(aP(i,j)-aS(i,j)*P(j-1));
        Q(j)=(bstar+aS(i,j)*Q(j-1))/(aP(i,j)-aS(i,j)*P(j-1));
    end
    j=m;
    bstar=b(i,j)+aE(i,j)*T(i+1,j);
    P(j)=0;
    Q(j)=(bstar+aS(i,j)*Q(j-1))/(aP(i,j)-aS(i,j)*P(j-1));
    T(i,j)=Q(j);
    for j=m-1:-1:1
        T(i,j)=P(j)*T(i,j+1)+Q(j);
    end
    for i=2:1:n-1
        j=1;
        bstar=b(i,j)+aE(i,j)*T(i+1,j)+aW(i,j)*T(i-1,j);
        P(j)=aN(i,j)/aP(i,j);
        Q(j)=bstar/aP(i,j);
        for j=2:1:m-1
            bstar=b(i,j)+aE(i,j)*T(i+1,j)+aW(i,j)*T(i-1,j);
            P(j)=aN(i,j)/(aP(i,j)-aS(i,j)*P(j-1));
            Q(j)=(bstar+aS(i,j)*Q(j-1))/(aP(i,j)-aS(i,j)*P(j-1));
        end
        j=m;
        bstar=b(i,j)+aE(i,j)*T(i+1,j)+aW(i,j)*T(i-1,j);
        P(j)=0;
        Q(j)=(bstar+aS(i,j)*Q(j-1))/(aP(i,j)-aS(i,j)*P(j-1));
        T(i,j)=Q(j);
        for j=m-1:-1:1
            T(i,j)=P(j)*T(i,j+1)+Q(j);
        end
        i=n;
        j=1;
        bstar=b(i,j)+aW(i,j)*T(i-1,j);
        P(j)=aN(i,j)/aP(i,j);
        Q(j)=bstar/aP(i,j);
        for j=2:1:m-1
            bstar=b(i,j)+aW(i,j)*T(i-1,j);
            P(j)=aN(i,j)/(aP(i,j)-aS(i,j)*P(j-1));
            Q(j)=(bstar+aS(i,j)*Q(j-1))/(aP(i,j)-aS(i,j)*P(j-1));
        end
        j=m;
        bstar=b(i,j)+aW(i,j)*T(i-1,j);
        P(j)=0;
        Q(j)=(bstar+aS(i,j)*Q(j-1))/(aP(i,j)-aS(i,j)*P(j-1));
        T(i,j)=Q(j);
        for j=m-1:-1:1
            T(i,j)=P(j)*T(i,j+1)+Q(j);
        end
    end
    RESIDUAL % call residual routine
end
