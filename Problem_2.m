%% Making Movie for Problem 2
close;
clear;
clc;

% Constants
T_max   = 50;
L       = 2;
% kappa   = 0.971796754;    % Minimum where no negative displacement
kappa_g = 0.1;

T_optim     = 6:0.5:T_max;
kappa_optim = zeros(size(T_optim));
for i = 1:length(T_optim)
    kappa_optim(i) = fmincon(@(k)func_resid_Pb2(k, T_optim(i), L), kappa_g, -1, 0);
end

% Find u_mat and x_vec
[u_mat, x_vec, t_vec, delX, delT]  = get_u_mat(kappa_optim(end), T_optim(end), L);

disp("Minimum displacement: " + min(min(u_mat)));

% Kappa Plot
figure(1);
clf;
plot(T_optim, kappa_optim);
xlabel("Time (s)");
ylabel("Optimal Kappa Value");

% Movie
figure(2);
clf;
for i = 1:length(t_vec)
    figure(2);
    plot(x_vec, u_mat(i,:));
    xlim([0,L]);
    ylim([-1,1]);
    xlabel("x position");
    ylabel("u displacement");
    pause(delT);
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