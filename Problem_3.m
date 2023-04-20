%% Making Movie for Problem 3
close;
clear;
clc;

p=2;
Lx=2;
Ly=2;
T = 60;
alpha = 0.05;
dx = 0.01;
dy = 0.01;
dt = 0.028;
PosX = unique([0-Lx/2:dx:Lx/2,Lx/2]);
PosY = unique([0-Ly/2:dy:Ly/2,Ly/2]);
Time = unique([0:dt:T,T]);
Sol = zeros(length(PosX), length(PosY), length(Time));
for i=1:length(PosX)
    for j=1:length(PosY)
        v = [PosX(i) PosY(j)];
        if abs(norm(v,p)-1) <= min(dx,dy)/1.5
            Sol(i,j,1) = 0.1;
        end
        if norm(v,p) <= 1+min(dx,dy)/1.5
            Sol(i,j,2) = (PosX(i)^2+PosY(j)^2)/10;
        end
    end
end
rx = alpha*dt^2 / dx^2;
ry = alpha*dt^2 / dy^2;
indx = 2:length(PosX)-1;
indy = 2:length(PosY)-1;
for k = 3:length(Time)
    for i = 1:length(PosX)
        for j = 1:length(PosY)
%             Sol(i,j,k)=Sol(i,j,k-1);
            v = [PosX(i) PosY(j)];
            r = norm(v,p);
            if r < 1-min(dx,dy)/1.5
                Sol(i,j,k) = 2*Sol(i,j,k-1) - Sol(i,j,k-2) + ...
                    (rx*(Sol(i+1,j,k-1) - 2*Sol(i,j,k-1) + ...
                    Sol(i-1,j,k-1)) + ry*(Sol(i,j+1,k-1) - ...
                    2*Sol(i,j,k-1) + Sol(i,j-1,k-1)))/2;
            elseif abs(r-1) <= min(dx,dy)/1.5
                Sol(i,j,k) = .1;
            else
                Sol(i,j,k) = 0;
            end
        end
    end
end
func_movie_maker(PosX, PosY, Sol);