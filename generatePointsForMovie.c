/*==========================================================
 * generatePointsForMovie.c
 *
 * INPUTS
 * r    -- radius of curve and side length of inner square
 * dx   -- horizontal and vertical step length
 * dt   -- time step duration
 * dtm  -- movie time step duration
 * tmax -- maximum time
 * pt   -- encoded point types
 * 
 * Multiplies an input scalar (multiplier) 
 * times a 1xN matrix (inMatrix)
 * and outputs a 1xN matrix (outMatrix)
 *
 * The calling syntax is:
 *
 *		mpts = arrayProduct(multiplier, inMatrix)
 *
 * This is a MEX-file for MATLAB.
 * Copyright 2007-2012 The MathWorks, Inc.
 *
 *========================================================*/

#include "mex.h"

// Main computational routine
void getMoviePoints(double r, double dx, double dt, double dtm,
                    double tmax, double** pt, double*** mpts,
                    mwSize xLen, mwSize yLen)
{
    mwSize i;
    /* multiply each element y by x */
    for (i=0; i<n; i++) {
        z[i] = x * y[i];
    }
}

/* The gateway function */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    double r;       // input scalar
    double dx;      // input scalar
    double dt;      // input scalar
    double dtm;     // input scalar
    double tmax;    // input scalar
    double* pt;     // input matrix
    double* mpts;   // output matrix

    // Validate number of arguments
    if(nrhs!=5) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nrhs","Five inputs required.");
    }
    if(nlhs!=1) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nlhs","One output required.");
    }

    // Ensure first input argument is a scalar
    if( !mxIsDouble(prhs[0]) || 
         mxIsComplex(prhs[0]) ||
         mxGetNumberOfElements(prhs[0])!=1 ) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:notScalar","Input multiplier must be a scalar.");
    }
    // Retrieve value of first input argument
    r = mxGetScalar(prhs[0]);
    // Ensure second input argument is a scalar
    if( !mxIsDouble(prhs[1]) || 
         mxIsComplex(prhs[1]) ||
         mxGetNumberOfElements(prhs[1])!=1 ) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:notScalar","Input multiplier must be a scalar.");
    }
    // Retrieve value of second input argument
    dx = mxGetScalar(prhs[1]);
    // Ensure third input argument is a scalar
    if( !mxIsDouble(prhs[2]) || 
         mxIsComplex(prhs[2]) ||
         mxGetNumberOfElements(prhs[2])!=1 ) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:notScalar","Input multiplier must be a scalar.");
    }
    // Retrieve value of third input argument
    dt = mxGetScalar(prhs[2]);
    // Ensure fourth input argument is a scalar
    if( !mxIsDouble(prhs[3]) || 
         mxIsComplex(prhs[3]) ||
         mxGetNumberOfElements(prhs[3])!=1 ) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:notScalar","Input multiplier must be a scalar.");
    }
    // Retrieve value of fourth input argument
    dtm = mxGetScalar(prhs[3]);
    // Ensure fifth input argument is a scalar
    if( !mxIsDouble(prhs[4]) || 
         mxIsComplex(prhs[4]) ||
         mxGetNumberOfElements(prhs[4])!=1 ) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:notScalar","Input multiplier must be a scalar.");
    }
    // Retrieve value of fifth input argument
    tmax = mxGetScalar(prhs[4]);
    // Ensure sixth input argument is a matrix
    if( !mxIsDouble(prhs[5]) || 
         mxIsComplex(prhs[5])) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:notDouble","Input matrix must be type double.");
    }
    // Retrieve value of sixth input argument
    #if MX_HAS_INTERLEAVED_COMPLEX
    pt = mxGetDoubles(prhs[5]);
    #else
    pt = mxGetPr(prhs[5]);
    #endif

    // Get dimensions of point types
    xLen = mxGetN(prhs[5]);
    yLen = mxGetN(prhs[5][0]);

    // Create output matrix
    plhs[0] = mxCreateDoubleMatrix((mwSize)xLen, (mwSize)yLen, mxREAL);

    // Get pointer to real data in output matrix
    #if MX_HAS_INTERLEAVED_COMPLEX
    mpts = mxGetDoubles(plhs[0]);
    #else
    mpts = mxGetPr(plhs[0]);
    #endif

    // Call the computational routine
    getMoviePoints(r, dx, dt, dtm, tmax, pt, xLen, yLen);
}
