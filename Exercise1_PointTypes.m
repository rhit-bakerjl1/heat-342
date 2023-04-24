function [pointTypes] = Exercise1_PointTypes(density, r, padding, full, plot)
% Only solves top right quadrant, then pass through a function to reflect
% to the other four quadrants.
%
% INPUTS
% density -- density of points to generate
%       r -- radius of curve and side length of square
%    full -- whether or not to generate all four quadrants rather than
%            just the upper left quadrant (DEFAULT: 0)
%    plot -- whether or not to display results (DEFUALT: 0)
%
% OUTPUTS
% pointTypes -- a matrix containing the point types of each point according
% to the encoding below
%
% POINT TYPES
% Type 0: Outside the curve
% Type 1: On the straight line on right
% Type 2: On the curve at top
% Type 3: Interior

% Set full to 0 if no argument was provided
if ~exist("full", "var") || isempty(full)
    full = 0;
end

% Set plot to 0 if no argument was provided
if ~exist("plot", "var") || isempty(plot)
    plot = 0;
end

% Define a function that converts from point to index
ptoi = @(x) round(1 + (x/density));

% Initialize point types 2D matrix
xLen = (r/density)+3;
yLen = (2*r/density)+3;
pointTypes = zeros(xLen, yLen);

% Defines how wide to make the border on the curve
% Default value of 7. To make thicker line, make widthFactor smaller
widthFactor = 7;

% Define all points on and inside curve
maxDist = density/widthFactor/sqrt(2);
for x = 0 : density : r
    for y = r : density : 2*r
        dist = x^2 + (y-r)^2 - r^2;
        if dist < -maxDist
            pointTypes(ptoi(x), ptoi(y)) = 3;
        elseif dist <= maxDist
            pointTypes(ptoi(x), ptoi(y)) = 2;
        end
    end
end

% Define all points inside box
for x = 0 : density : r-density
    for y = 0 : density : r
        pointTypes(ptoi(x), ptoi(y)) = 3;
    end
end

% Define all points on straight line
x = r;
for y = 0 : density : r
    pointTypes(ptoi(x), ptoi(y)) = 1;
end

% Reflect the points across themselves to complete the shape
if full
    pt2 = cat(1, flip(pointTypes, 1), pointTypes);
    pt3 = cat(2, flip(pt2, 2), pt2);
    pointTypes = pt3(2:end, 2:end);
end

pointTypes = padarray(pointTypes, [padding, padding], 0, "both");

% If plot is set to true, plot the points by color
if plot ~= 0
    axis equal;
    graph = pcolor(pointTypes);
    set(graph, "EdgeColor", "None")
end

% Flip the axes to be what is expected
pointTypes = pointTypes';
