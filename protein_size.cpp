#include "mex.h"
#include "protein.h"

void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
    plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
    double *output = mxGetPr(plhs[0]);
    int len = mxGetN(prhs[0]);
    int w = mxGetM(prhs[0]);
    protein pro((double*)mxGetPr(prhs[0]), len, w);
    output[0] = pro.size();
}