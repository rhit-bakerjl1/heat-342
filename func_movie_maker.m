function [] = func_movie_maker(x_vec, y_vec, T_mat_3d, t_max, fignum)
    % Creates a movie out of x and y coordinates, and 3D T matrix which
    % holds all the temperature information over a given time period. 
    % INPUTS
    % x_vec -- N x 1 vector of x-coordinates. 
    % y_vec -- M x 1 vector of y-coordinates.
    % T_mat_3d -- N x M x P 3D matrix of temperature information. P is the
    %             number of time steps taken in the computation.
    % t_max -- Maximum time in seconds that the computation runs.
    % fignum -- (optional) figure number desired

    % Find dimensions of T_mat_3d
    [~, ~, Nt]    = size(T_mat_3d);
    
    % Find timestep
    delT    = t_max/(Nt-1);

    % Checking for optional parameter fignum
    if (~exist('fignum', 'var'))
        fignum  = 1;
    end

    % Maximum and minimum temperature
    T_min   = min(T_mat_3d, [], "all");
    T_max   = max(T_mat_3d, [], "all");

    % Make the movie
    figure(fignum);
    clf;    
    for i = 1:Nt
        surfc(x_vec, y_vec, T_mat_3d(:,:,i));
        xlabel("x");
        ylabel("y");
        zlabel("Temp. (C)");
        zlim([T_min, T_max]);
        pause(delT);
    end

end