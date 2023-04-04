/*==========================================================
 * arrayProduct.c - example in MATLAB External Interfaces
 *
 * Multiplies an input scalar (multiplier) 
 * times a 1xN matrix (inMatrix)
 * and outputs a 1xN matrix (outMatrix)
 *
 * The calling syntax is:
 *
 *		outMatrix = arrayProduct(multiplier, inMatrix)
 *
 * This is a MEX-file for MATLAB.
 * Copyright 2007-2012 The MathWorks, Inc.
 *
 *========================================================*/

#include "mex.h"

// Multiply all elements in y by x, store in z
void arrayProduct(double x, double *y, double *z, mwSize n)
{
    mwSize i;
    for (i=0; i<n; i++) {
        z[i] = x * y[i];
    }
}

// Gateway function
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    // Defining input and output variables
    double multiplier;  // Input scalar
    double *inMatrix;   // Input matrix   (1xN)
    size_t ncols;       // Size of vector (N)
    double *outMatrix;  // Output matrix  (1xN)

    // Check for proper number of input arguments
    if(nrhs!=2) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nrhs","Two inputs required.");
    }
    // Check for proper number of output arguments
    if(nlhs!=1) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nlhs","One output required.");
    }
    // Ensure first argument is a scalar
    if(!mxIsDouble(prhs[0]) || 
       mxIsComplex(prhs[0]) || 
       mxGetNumberOfElements(prhs[0])!=1 ) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:notScalar","Input multiplier must be a scalar.");
    }
    // Ensure second input argument is a double
    if(!mxIsDouble(prhs[1]) || 
       mxIsComplex(prhs[1])) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:notDouble","Input matrix must be type double.");
    }
    // Ensure second argument is a row vector
    if(mxGetM(prhs[1]) != 1) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:notRowVector","Input must be a row vector.");
    }
    // Extracting the value of the multiplier
    multiplier = mxGetScalar(prhs[0]);
    // Creating a pointer to the real data of the input matrix
    #if MX_HAS_INTERLEAVED_COMPLEX
    inMatrix = mxGetDoubles(prhs[1]);
    #else
    inMatrix = mxGetPr(prhs[1]);
    #endif
    // Getting the dimensions of the input matrix
    ncols = mxGetN(prhs[1]);
    // Allocating space for the output matrix
    plhs[0] = mxCreateDoubleMatrix(1,(mwSize)ncols,mxREAL);
    // Getting the pointer to the output matrix
    #if MX_HAS_INTERLEAVED_COMPLEX
    outMatrix = mxGetDoubles(plhs[0]);
    #else
    outMatrix = mxGetPr(plhs[0]);
    #endif
    // Call the arrayProduct method
    arrayProduct(multiplier,inMatrix,outMatrix,(mwSize)ncols);
}
