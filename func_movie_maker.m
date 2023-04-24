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

    fprintf("Size x_vec: %d x %d\n", size(x_vec))
    fprintf("Size y_vec: %d x %d\n", size(y_vec))
    fprintf("Size T_mat: %d x %d x %d\n", size(T_mat_3d))

    % Find dimensions of T_mat_3d
    [~, ~, Nt]    = size(T_mat_3d);
    
    % Checking for optional parameter fileName
    if (~exist('fileName', 'var')) || isempty(fileName)
        fileName  = 'testmovie.mp4';
    end

    % Maximum and minimum temperature
    T_min   = min(T_mat_3d, [], "all");
    T_max   = max(T_mat_3d, [], "all");
    T_range = T_max - T_min;
    z_min   = T_min - T_range;
    z_max   = T_max + T_range;
    titleName = strrep(extractBefore(fileName, "."), "_", " ");
    % Make the movie
    vidfile = VideoWriter(fileName, 'MPEG-4');
    open(vidfile);
    for i = 1:Nt
        graph = surfc(x_vec, y_vec, T_mat_3d(:,:,i));
%         view(mod(i, 360), 25);
        set(graph, "EdgeColor", "None");
        title(titleName);
        xlabel("x");
        ylabel("y");
        zlabel("u displacement");
        zlim([z_min, z_max]);
        frame   = getframe(gcf);
        writeVideo(vidfile, frame);
    end
    close(vidfile);

end