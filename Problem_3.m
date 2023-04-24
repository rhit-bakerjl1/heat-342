%% Making Movie for Problem 3
close;
clear;
clc;

p=2;
Lx=2;
Ly=2;
alpha = 2;
dx = 0.01;
dy = 0.01;
%dt = .99*dx*dy*sqrt(1/2);
dt = .0028;
T = 20;
PosX = unique([0-Lx/2:dx:Lx/2,Lx/2]);
PosY = unique([0-Ly/2:dy:Ly/2,Ly/2]);
Time = unique([0:dt:T,T]);
Sol = zeros(length(PosX), length(PosY), length(Time));
R = zeros(length(PosX), length(PosY));
for i=1:length(PosX)
    for j=1:length(PosY)
        R(i,j)=norm([PosX(i) PosY(j)],p);
        if abs(R(i,j)-1) <= min(dx,dy)/1.5
            Sol(i,j,1) = 0.1;
        end
        if R(i,j) <= 1+min(dx,dy)/1.5
            Sol(i,j,1) = (PosX(i)^2+PosY(j)^2)/10;
        end
        Sol(i,j,2) = Sol(i,j,1);
    end
end
rx = 2*dt^2 / dx^2;
ry = 2*dt^2 / dy^2;
indx = 2:length(PosX)-1;
indy = 2:length(PosY)-1;
for k = 3:length(Time)
    for i = 1:length(PosX)
        for j = 1:length(PosY)
%             Sol(i,j,k)=Sol(i,j,k-1);
            if R(i,j) < 1-min(dx,dy)/1.5
                Sol(i,j,k) = 2*Sol(i,j,k-1) - Sol(i,j,k-2) + ...
                    rx*(Sol(i+1,j,k-1) - 2*Sol(i,j,k-1) + ...
                    Sol(i-1,j,k-1)) + ry*(Sol(i,j+1,k-1) - ...
                    2*Sol(i,j,k-1) + Sol(i,j-1,k-1));
            elseif abs(R(i,j)-1) <= min(dx,dy)/1.5
                Sol(i,j,k) = .1;
            else
                Sol(i,j,k) = 0;
            end
        end
    end
end
func_movie_maker(PosX, PosY, Sol);