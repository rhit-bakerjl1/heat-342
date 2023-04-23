function [] = Exercise1(rho, c, kappa, filename)
% INPUTS
%   rho -- material density of the metal being used
%     c -- heat capacity of the metal being used
% kappa -- thermal conductivity of the metal being used

% Defining the radius of our desired curve and side length of our inner
% square in meters
radius = 0.1;

% Defining the size of vertical and horizontal step to take
dx = 0.001;

% Defining the size of our time step to take
dt = 0.0001;

% Defining our interval at which to add the temperatures to the movie
dtMovie = 0.005;

% Defining the maximum time to calculate to
tMax = 2;

% Getting our point types for each segment of our shape, according to the
% following encoding:
% Type 0: Outside the curve
% Type 1: On the straight line on right
% Type 2: On the curve at top
% Type 3: Interior
padding = 2;
pointTypes = Exercise1_PointTypes(dx, radius, padding, 1, 0);

% Initival value of all points
% u(x, y, 0) = 60;

% Time step for exterior points (type 0)
% u(x, y, t+dt) = NaN

% Time step for points on straight line (type 1)
% u(x, y, t+dt) = 60

% Time step for points on curve (type 2)
% partial(u)/partial(x)*nx + partial(u)/partial(y)*ny = -1
% partial(u)/partial(x) = 1/2dx*(3u(x,y,t)-4u(x-dx,y,t)+u(x-2dx,y,t)
% partial(u)/partial(y) = 1/2dx*(3u(x,y,t)-4u(x,y-dy,t)+u(x,y-2dy,t)
% u(x, y, t+dt) = u(x, y, t) - 1
% TODO: ACTUALLY SOLVE THIS EQUATION

% Time step for interior points (type 3)
% u(x, y, t+dt) = (kappa*dt/(c*rho*dx^2)) (u(x+dx, y, t) + u(x, y+dy, t) + 
%                                          u(x-dx, y, t) + u(x, y-dy, t) -
%                                          4*u(x, y, t))

% Initialize all point temps inside (and on) the curve to 60 C
[xLen, yLen] = size(pointTypes);

pointTemps = zeros(xLen, yLen);
insideTemp = 60;
outsideTemp = NaN;
for x = 1 : xLen
    for y = 1 : yLen
        if pointTypes(x, y) ~= 0
            pointTemps(x, y) = insideTemp;
        else
            pointTemps(x, y) = outsideTemp;
        end
    end
end

moviePointTemps = zeros(xLen, yLen, tMax/dtMovie);
moviePointTemps(:,:,1) = pointTemps;
movieIndex = 2;

for t = 0 : dt : tMax
    newTemps = pointTemps;
    for x = 1 : xLen
        for y = 1 : yLen
            type = pointTypes(x, y);
            if type == 0
                newTemps(x, y) = outsideTemp;
            elseif type == 1
                newTemps(x, y) = 60;
            elseif type == 2
                normX = (((x-1-padding)*dx)-(2*radius))/radius;
                normY = ((y-1-padding)*dx)/radius;
                newTemps(x, y) = pointTemps(x, y) - (normX^2*dt);
            else
                newTemps(x, y) = pointTemps(x, y) + ((kappa * dt / (c*rho*dx^2)) * ((pointTemps(x+1, y) + pointTemps(x-1, y) + pointTemps(x, y+1) + pointTemps(x, y-1) - (4*pointTemps(x, y)))));
            end
        end
    end
    pointTemps = newTemps;
    if mod(t, dtMovie) == 0
        moviePointTemps(:,:,movieIndex) = pointTemps;
        movieIndex = movieIndex + 1;
    end
end

% Remove padding
% moviePointTemps = moviePointTemps(1+padding:end-padding, 1+padding:end-padding, :);

[xLenTot, yLenTot, ~] = size(moviePointTemps);

% func_movie_maker([1:yLenTot]', [1:xLenTot]', mpt3, "Exercise1.mp4")
func_movie_maker([1:yLenTot]', [1:xLenTot]', moviePointTemps, filename)