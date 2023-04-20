function [] = func_movie_maker(x_vec, y_vec, T_mat_3d, fileName)
    % Creates a .mp4 file out of x and y coordinates, and 3D T matrix which
    % holds all the temperature information over a given time period. 
    % INPUTS
    % x_vec -- N x 1 vector of x-coordinates. 
    % y_vec -- M x 1 vector of y-coordinates.
    % T_mat_3d -- M x N x P 3D matrix of temperature information. P is the
    %             number of time steps taken in the computation.
    % filename -- (optional) name of the file to be exported. Should end in
    %             ".mp4"

    % Find dimensions of T_mat_3d
    [~, ~, Nt]    = size(T_mat_3d);
    
    % Checking for optional parameter fignum
    if (~exist('fileName', 'var'))
        fileName  = 'testmovie.mp4';
    end

    % Maximum and minimum temperature
    T_min   = min(T_mat_3d, [], "all");
    T_max   = max(T_mat_3d, [], "all");

    % Make the movie
    vidfile = VideoWriter(fileName, 'MPEG-4');
    open(vidfile);
    for i = 1:Nt
        surfc(x_vec, y_vec, T_mat_3d(:,:,i));
        xlabel("x");
        ylabel("y");
        zlabel("Temp. (C)");
        zlim([T_min, T_max]);
        frame   = getframe(gcf);
        writeVideo(vidfile, frame);
    end
    close(vidfile);

end