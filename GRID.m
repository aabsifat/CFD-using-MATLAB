% ENGI 9977
% Winter 2019
% Abdullah Sifat

% FINAL EXAM

% 2D

% GRID


DX = xl/(n-1) ; % assume evenly spaced x locations

for i = 1:m
    x(:,i) = transpose(0:DX:xl) ; % location of x (m)
end


DY = yl/(m-1) ; % assume evenly spaced y locations

% location of y (m)
for i = 1:n
    y(i,:) = 0:DY:yl ;
end



