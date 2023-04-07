%% Testing the Movie Maker
close;
clear;
clc;

% Boundaries
x_min   = 0;
x_max   = 10;
y_min   = 0;
y_max   = 10;
t_min   = 0;
t_max   = 3;

% Number of points
Nx      = 30;
Ny      = 40;
fps     = 48;
Nt      = t_max*fps+1;

% Vector: both direction... and... magnitude! Oh yeah!
x_vec   = linspace(x_min, x_max, Nx);
y_vec   = linspace(y_min, y_max, Ny);
t_vec   = linspace(t_min, t_max, Nt);

% Making T matrix
T_mat_3d    = get_temp(x_vec, y_vec, t_vec);

% Movie Time!
func_movie_maker(x_vec, y_vec, T_mat_3d);

%% Helpful Functions
function T_mat = get_temp(x_vec, y_vec, t_vec)
    
    T_mat   = zeros(length(y_vec), length(x_vec), length(t_vec));
    y_vec_temp   = y_vec';
    for i = 1:length(t_vec)
        T_x     = (x_vec - x_vec(1)).*(x_vec - x_vec(end));
        T_y     = (y_vec_temp - y_vec_temp(1)).*(y_vec_temp - y_vec_temp(end));
        T_mat(:,:,i)    = T_x.*T_y*exp(-0.5*t_vec(i));
    end
    
end
