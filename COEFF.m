% ENGI 9977
% Winter 2019
% Abdullah Sifat

% FINAL EXAM

% 2D

% COEFF


dxe = zeros(n,m) ;
dxw = zeros(n,m) ;
dyn = zeros(n,m) ;
dys = zeros(n,m) ;
for i = 1:n-1
    for j = 1:m
        dxe(i,j) = x(i+1,j) - x(i,j) ; % delta X east
    end
end
dxw(2:n,1:m) = dxe(1:n-1,1:m) ; % delta X west
for i = 1:n
    for j = 1:m-1
        dyn(i,j) = y(i,j+1) - y(i,j) ; % delta Y north
    end
end
dys(1:n,2:m) = dyn(1:n,1:m-1) ; % delta Y north

Deltax = (dxe+dxw)/2 ; % delta X - length of cv face
Deltay = (dyn+dys)/2 ; % delta Y - height of cv face

vol = Deltax.*Deltay ; % control volume

ke = zeros (n,m) ;
kw = zeros (n,m) ;
kn = zeros (n,m) ;
ks = zeros (n,m) ;
for i = 1:n-1
    for j = 1:m
        ke(i,j) = 2*k(i,j)*k(i+1,j)/(k(i,j)+k(i+1,j)) ; % k east
    end
end
kw(2:n,1:m) = ke(1:n-1,1:m) ; % k west
for i = 1:n
    for j = 1:m-1
        kn(i,j) = 2*k(i,j)*k(i,j+1)/(k(i,j)+k(i,j+1)) ; % k north
    end
end
ks(1:n,2:m) = kn(1:n,1:m-1) ; % k south

% calculate coefficients at each node
aW = (kw./dxw).*Deltay ;
aE = (ke./dxe).*Deltay ;
aS = (ks./dys).*Deltax ;
aN = (kn./dyn).*Deltax ;
aPo = rho.*cp.*vol./dt ;
aP = aW + aE + aS + aN + aPo - Sp.*vol ;
b = Sc.*vol + aPo.*Told ;

% boundary conditions
aW(1,:) = 0 ; % left surface
aE(n,:) = 0 ; % right surface
aS(:,1) = 0 ; % bottom surface
aN(:,m) = 0 ; % top surface
aP(1,:) = aE(1,:) + aS(1,:) + aN(1,:) + aPo(1,:) - Sp(1,:).*vol(1,:) + hl(1,:).*Deltay(1,:) ; % left surface
aP(n,:) = aW(n,:) + aS(n,:) + aN(n,:) + aPo(n,:) - Sp(n,:).*vol(n,:) + hr(n,:).*Deltay(n,:) ; % right surface
aP(:,1) = aE(:,1) + aW(:,1) + aN(:,1) + aPo(:,1) - Sp(:,1).*vol(:,1) + hb(:,1).*Deltax(:,1) ; % bottom surface
aP(:,m) = aE(:,m) + aW(:,m) + aS(:,m) + aPo(:,m) - Sp(:,m).*vol(:,m) + ht(:,m).*Deltax(:,m) ; % top surface
b(1,:) = Sc(1,:).*vol(1,:) + aPo(1,:).*Told(1,:) + hl(1,:).*Tfl(1,:).*Deltay(1,:) ; % left surface
b(n,:) = Sc(n,:).*vol(n,:) + aPo(n,:).*Told(n,:) + hr(n,:).*Tfr(n,:).*Deltay(n,:) ; % right surface
b(:,1) = Sc(:,1).*vol(:,1) + aPo(:,1).*Told(:,1) + hb(:,1).*Tfb(:,1).*Deltax(:,1) ; % bottom surface
b(:,m) = Sc(:,m).*vol(:,m) + aPo(:,m).*Told(:,m) + ht(:,m).*Tft(:,m).*Deltax(:,m) ; % top surface
aP(1,m) = aE(1,m) + aS(1,m) + aPo(1,m) - Sp(1,m)*vol(1,m) + hl(1,m)*Deltay(1,m) + ht(1,m)*Deltax(1,m) ; % top left corner
aP(n,m) = aW(n,m) + aS(n,m) + aPo(n,m) - Sp(n,m)*vol(n,m) + hr(n,m)*Deltay(n,m) + ht(n,m)*Deltax(n,m) ; % top right corner
aP(1,1) = aE(1,1) + aN(1,1) + aPo(1,1) - Sp(1,1)*vol(1,1) + hb(1,1)*Deltax(1,1) + hl(1,1)*Deltay(1,1) ; % bottom left corner
aP(n,1) = aW(n,1) + aN(n,1) + aPo(n,1) - Sp(n,1)*vol(n,1) + hb(n,1)*Deltax(n,1) + hr(n,1)*Deltay(n,1) ; % bottom right corner
b(1,m) = Sc(1,m)*vol(1,m) + aPo(1,m)*Told(1,m) + hl(1,m)*Tfl(1,m)*Deltay(1,m) + ht(1,m)*Tft(1,m)*Deltax(1,m) ; % top left corner
b(n,m) = Sc(n,m)*vol(n,m) + aPo(n,m)*Told(n,m) + hr(n,m)*Tfr(n,m)*Deltay(n,m) + ht(n,m)*Tft(n,m)*Deltax(n,m) ; % top right corner
b(1,1) = Sc(1,1)*vol(1,1) + aPo(1,1)*Told(1,1) + hb(1,1)*Tfb(1,1)*Deltax(1,1) + hl(1,1)*Tfl(1,1)*Deltay(1,1) ; % bottom left corner
b(n,1) = Sc(n,1)*vol(n,1) + aPo(n,1)*Told(n,1) + hb(n,1)*Tfb(n,1)*Deltax(n,1) + hr(n,1)*Tfr(n,1)*Deltay(n,1) ; % bottom right corner

% relaxation
aP = aP/alpha ;
b = b + (1-alpha)*aP.*T ;
