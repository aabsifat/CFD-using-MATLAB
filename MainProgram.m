% Abdullah Sifat
% MATH 451
% Project

% Main_Program



clear all 
close all
clc



% Ask User for Step Sizes
button = questdlg('Choose a delT','Step Size','delT = 0.01','delT = 0.05','delT = 0.01');
switch button
    case 'delT = 0.01'
        delt = 0.01;
    case 'delT = 0.05'
        delt = 0.05;
end



% inputs
prompt = {'Enter the time duration of temperature distribution in hour'};
name = 'Duration';
default = {'0.5'};
answer = inputdlg(prompt,name,1,default);
tf = str2double(answer);



% time and length vectors
delx = 0.05;   % ft
L = 1;
x = 0:delx:L ;
time = meshgrid(0:delt:tf) ;



% Ask user which solution method to use
% Call functions to compute numerical solutions               
button = questdlg('Choose a Solution Method','Methods','FTCS','Crank-Nicolson','Analytical','FTCS');
switch button
    case 'FTCS'
        T = FTCS (delx,delt,tf) ;         % FTCS explicit method
    case 'Crank-Nicolson'
        T = CrankNicolson (delx,delt,tf) ;  % Crank-Necolson method
    case 'Analytical'
        T = Analytical (delx,delt,tf);
end





% Temperature distribution plot
% Ask user to chose a plotting method - 2D or 3D
button = questdlg('Choose a plotting method','Plotting Method','2D','3D','2D');
switch button
    case '2D'
        % Temperature distribution 2D Plots
        figure
        n = length(time);
        for i = 1:n
            plot(x,T(:,i))
            hold on
            title('Temperature distribution');
            ylabel('Temperature (deg F)');
            xlabel('X (ft)');
            drawnow
            pause(0.05)
        end
    case '3D'
        % Temperature distribution 3D Plots
        figure
        n = length(time);
        for i = 1:n-1
            Z = T(:,i:i+1);
            t = time(i,i:i+1);
            surf(t,x,Z)
            hold on
            xlabel('Time (hour)')
            ylabel('Y (ft)');
            zlabel('Temperature (deg F)');
            axis([0 tf 0 L 100 300])
            view(150,40)
            drawnow
            pause(0.05)
        end
end
    







