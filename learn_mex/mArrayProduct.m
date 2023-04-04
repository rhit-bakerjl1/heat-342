function [product] = mArrayProduct(multiplier, array)
% MATLAB interface for the main C function found in arrayProduct.c
%
% INPUTS
% multiplier -- a scalar value
% array      -- a row vector
%
% OUTPUTS
% product    -- new row vector containing all elements of array multiplied
%               by multiplier
%
mex arrayProduct.c
product = arrayProduct(multiplier, array);
end