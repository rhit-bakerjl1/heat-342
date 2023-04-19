% File used for testing boundary things such as PointTypes
close;
clear;
clc;

% Experimenting with Boundaries
pt_types = Exercise1_PointTypes(0.005,0.1,1);
pt_types2   = Circle_PointTypes(0.005,0.1,2);
pt_types3   = One_Norm_PointTypes(0.05,1,3);
pt_types4   = Three_Norm_PointTypes(0.005,0.1,4);
pt_types5   = Inf_Norm_PointTypes(0.05,1,5);

% Finding 3-Norm
x_vec   = -1:0.001:1;
y_vec1  = (1-abs(x_vec.^3)).^(1/3);
y_vec2  = (abs(x_vec.^3)-1).^(1/3);

% Plotting 3-Norm
% figure(6);
% clf;
% plot(x_vec, y_vec1);
% hold on;
% plot(x_vec, -y_vec1);