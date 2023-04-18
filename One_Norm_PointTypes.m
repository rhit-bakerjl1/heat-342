function [pt3] = One_Norm_PointTypes(density, r, plot)
% Only solves top right quadrant, then pass through a function to reflect
% to the other four quadrants.
%
% INPUTS
% density -- density of points to generate
%       r -- width of x and y range
%    plot -- whether or not to display results (DEFUALT: 0)
%
% OUTPUTS
% pointTypes -- a matrix containing the point types of each point according
% to the encoding below
%
% POINT TYPES
% Type 0: Outside the curve
% Type 1: UNUSED!!!
% Type 2: On circular boundary
% Type 3: Interior

% Set plot to 0 if no argument was provided
if ~exist("plot", "var") || isempty(plot)
    plot = 0;
end

% Define a function that converts from point to index
ptoi = @(x) round(1 + (x/density));

% Initialize point types 2D matrix
xLen = (r/density)+2;
yLen = (r/density)+2;
pointTypes = zeros(xLen, yLen);

% Defines how wide to make the border on the curve
% Default value of 10. To make thicker line, make widthFactor smaller
widthFactor = 8;

% Define all points on and inside curve
maxDist = density/widthFactor/sqrt(2);
for x = 0 : density : r
    for y = 0 : density : r
        dist = abs(x) + abs(y) - r;
        if dist < -maxDist
            % Interior
            pointTypes(ptoi(x), ptoi(y)) = 3;
        elseif dist <= maxDist
            % On Circle Boundary
            pointTypes(ptoi(x), ptoi(y)) = 2;
        end
    end
end

% % Define all points on straight line
% x = r;
% for y = 0 : density : r
%     pointTypes(ptoi(x), ptoi(y)) = 1;
% end

pointTypes = pointTypes';

% Reflect the points across themselves to complete the shape
pt2 = cat(1, flip(pointTypes, 1), pointTypes);
pt3 = cat(2, flip(pt2, 2), pt2);

% If plot is set to true, plot the points by color
if plot ~= 0
    figure(plot);
    clf;
    axis equal;
    pcolor(pt3);
end
