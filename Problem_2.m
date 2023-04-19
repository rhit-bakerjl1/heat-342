%% Making Movie for Problem 2
close;
clear;
clc;

% Constants
T_max   = 30;
L       = 0.1;
% kappa   = 0.971796754;    % Minimum where no negative displacement
kappa_g = 0.5;

% Rubber Band Constants
h       = 5;
x_pull  = L/2;
fast_forward    = 5;

% optimize?
optim   = 0;
movie   = 1;
test_k  = 0;
r_band  = 1;

% Find optimal kappa for each value
if (optim)
    T_optim     = 6:0.5:T_max;
    kappa_optim = zeros(size(T_optim));
    for i = 1:length(T_optim)
        kappa_optim(i) = fmincon(@(k)func_resid_Pb2(k, T_optim(i), L), kappa_g, -1, 0);
    end

    % Find u_mat and x_vec
    [u_mat, x_vec, t_vec, delX, delT]  = get_u_mat(kappa_optim(end), T_optim(end), L);
    disp("Minimum displacement: " + min(min(u_mat)));
end

% Test multiple kappa values and display them on the same graph
if (test_k)
    % Initial Test
    T   = 15;
    [u_mat_0,~,~,~,~] = get_u_mat(0,T,L);
    kappa_test  = linspace(0,1,6);
    % Setup for Loop
    u_max_solns = zeros(length(kappa_test), width(u_mat_0));
    u_min_solns = zeros(length(kappa_test), width(u_mat_0));
    % Finding min/max vectors for each test
    for i = 1:length(kappa_test)
        [u_mat,x_vec_plt,~,~,~] = get_u_mat(kappa_test(i), T, L);
        [u_max_solns(i,:), u_min_solns(i,:)]    = find_u_max_min(u_mat);
    end
end

% Kappa Plot
if (optim)
    figure(1);
    clf;
    plot(T_optim, kappa_optim);
    xlabel("Time (s)");
    ylabel("Optimal Kappa Value");
end

% Rubber Band Testing
if (r_band)
    [u_mat, x_vec, t_vec, delX, delT]   = r_band_u_mat(kappa_g, T_max, L, h, x_pull);
end

% Testing kappa plot
if (test_k)
    % Max Plot
    figure(2);
    clf;
    legend_labels   = strings(size(kappa_test));
    for i = 1:length(kappa_test)
        plot(x_vec_plt, u_max_solns(i,:));
        hold on;
        legend_labels(i)    = "kappa = " + kappa_test(i);
    end
    xlabel("x location");
    ylabel("u displacement");
    legend(legend_labels);

    % Min Plot
    figure(3);
    clf;
    for i = 1:length(kappa_test)
        plot(x_vec_plt, u_min_solns(i,:));
        hold on;
    end
    xlabel("x location");
    ylabel("u displacement");
    legend(legend_labels);
end

% Movie
if (movie)
    movie_plt   = 4;
    figure(movie_plt);
    clf;
    max_u   = max(max(u_mat));
    min_u   = min(min(u_mat));
    for i = 1:length(t_vec)
        figure(movie_plt);
        plot(x_vec, u_mat(i,:));
        xlim([0,L]);
        ylim([min_u,max_u]);
        xlabel("x position");
        ylabel("u displacement");
        pause(delT/fast_forward);
    end
end


%% Helpful Functions
function [f] = func_resid_Pb2(kappa, T, L)
    % Getting u stuff
    [u_mat]     = get_u_mat(kappa, T, L);
    u_min       = min(min(u_mat));

    % Minimization function
    f   = kappa;
    if (u_min < 0) 
        f = f - u_min*10000;
    end
end

function [u_max, u_min] = find_u_max_min(u_mat)
    [~, maxRowInd] = max(sum(u_mat,2));
    [~, minRowInd] = min(sum(u_mat,2));
    u_max   = u_mat(maxRowInd,:);
    u_min   = u_mat(minRowInd,:);
end