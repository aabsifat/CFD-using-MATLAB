% ENGI 9977
% Winter 2019
% Abdullah Sifat

% FINAL EXAM

% 2D

% Residual


res = zeros(n,m) ;

% Bottom Left Corner
res(1,1) = abs(aP(1,1)*T(1,1) - aE(1,1)*T(2,1) - aN(1,1)*T(1,2) - b(1,1)) ; 

% Bottom Right Corner
res(n,1) = abs(aP(n,1)*T(n,1) - aW(n,1)*T(n-1,1) - aN(n,1)*T(n,2) - b(n,1)) ;

% Top Left Corner
res(1,m) = abs(aP(1,m)*T(1,m) - aE(1,m)*T(2,m) - aS(1,m)*T(1,m-1) - b(1,m)) ;

% Top Right Corner
res(n,m) = abs(aP(n,m)*T(n,m) - aW(n,m)*T(n-1,m) - aS(n,m)*T(n,m-1) - b(n,m)) ;

% Left Edge
for j = 2:m-1
    res(1,j) = abs(aP(1,j)*T(1,j) - aE(1,j)*T(2,j) - aN(1,j)*T(1,j+1) - aS(1,j)*T(1,j-1) - b(1,j)) ;
end

% Right Edge
for j = 2:m-1
    res(n,j) = abs(aP(n,j)*T(n,j) - aW(n,j)*T(n-1,j) - aN(n,j)*T(n,j+1) - aS(n,j)*T(n,j-1) - b(n,j)) ;
end

% Bottom Edge
for i = 2:n-1
    res(i,1) = abs(aP(i,1)*T(i,1) - aE(i,1)*T(i+1,1) - aW(i,1)*T(i-1,1) - aN(i,1)*T(i,2) - b(i,1)) ;
end

% Top Edge
for i = 2:n-1
    res(i,m) = abs(aP(i,m)*T(i,m) - aE(i,m)*T(i+1,m) - aW(i,m)*T(i-1,m) - aS(i,m)*T(i,m-1) - b(i,m)) ;
end

% Internal nodes
for i = 2:n-1
    for j = 2:m-1
        res(i,j) = abs(aP(i,j)*T(i,j) - aE(i,j)*T(i+1,j) - aW(i,j)*T(i-1,j) - aN(i,j)*T(i,j+1) - aS(i,j)*T(i,j-1) - b(i,j)) ;
    end
end

resmax = max(res,[],'all') ; % max of residual


