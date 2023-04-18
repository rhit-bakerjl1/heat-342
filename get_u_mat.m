function [u_mat, x_vec, t_vec, delX, delT] = get_u_mat(kappa, T, L)
    % Constants
    H_rho   = 0.1;
    delX    = 0.01;
    delT    = 0.028;
    alpha   = 0;
    beta    = 0;
    
    % Vectors
    x_vec   = 0:delX:L;
    t_vec   = 0:delT:T;
    
    % Solution
    u_mat   = zeros(length(t_vec), length(x_vec));
    u_mat(1,:)      = linspace(alpha, beta, length(x_vec));
    u_mat(:,1)      = alpha;
    u_mat(:,end)    = beta;
    
    % Initial Conditions u(t,x)
    u_mat(2,:)  = u_mat(1,:) + delT*(exp(-10*(x_vec-L/2).^2) - exp(-10*(L/2)^2));
    
    % Time Stepping
    x_change    = 2:length(x_vec)-1;
    for t_pos = 2:length(t_vec)-1
        % Past u values
        uix1    = u_mat(t_pos,x_change+1);
        ui      = u_mat(t_pos,x_change);
        uix_1   = u_mat(t_pos,x_change-1);
        uit_1   = u_mat(t_pos-1,x_change);
    
        % Coefficients
        ai      = H_rho/delX^2;
        bi      = (2/delT^2 - 2*H_rho/delX^2);
        ci      = ai;
        di      = (kappa/2/delT - 1/delT^2);
        deni    = 1/delT^2 + kappa/2/delT;
    
        % Next u_mat
        u_mat(t_pos+1,x_change)     = (ai*uix1 + bi*ui + ci*uix_1 + di*uit_1)/deni;
    end
end