function [output] = mArrayProduct(multiplier, array)
mex arrayProduct.c
output = arrayProduct(multiplier, array);
end