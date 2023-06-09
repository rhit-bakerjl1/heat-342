function [u_mat, x_vec, t_vec, delX, delT] = r_band_u_mat(kappa, T, L, h, x_pull, H_rho)
    % Constants
    % H_rho   = 0.011;
    % H_rho   = 100;
    % delX    = 0.01;
    delX    = L/100;
    % delT    = 0.9*delX*sqrt(1/H_rho);
    delT    = 0.9*delX*sqrt(1/H_rho);
    if (~exist("h", "var")) 
        h   = L/4;
    end
    if (~exist("x_pull", "var")) 
        x_pull  = L/2;
    end
    
    % Vectors
    x_vec   = 0:delX:L;
    t_vec   = 0:delT:T;
    
    % Solution
    u_mat   = zeros(length(t_vec), length(x_vec));

    % Initial Conditions u(t,x)
    u_mat(1,x_vec<=x_pull)  = (h/x_pull)*x_vec(x_vec<=x_pull);
    u_mat(1,x_vec>x_pull)   = -h/(L-x_pull)*x_vec(x_vec>x_pull) + h*L/(L-x_pull);

    % Initial Velocity Profile
    % v0_vec  = -u_mat(1,:)*6;
    % v0_vec  = -u_mat(1,:)*6*H_rho;
    v0_vec  = -u_mat(1,:)*5*H_rho;
    % u_mat(2,:)  = u_mat(1,:) + v0_vec*delT;
    u_mat(2,:)  = u_mat(1,:);
    
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