#include "mex.h"
#include <random>

void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
    plhs[0] = mxCreateDoubleMatrix(20, 20, mxREAL);
    double *J = mxGetPr(plhs[0]);
    double mean = *mxGetPr(prhs[0]);
    double dev  = *mxGetPr(prhs[1]);
    
    std::default_random_engine generator(time(NULL));
    std::normal_distribution<double> distribution(mean, dev);
    for (int x = 0; x < 20; x++) {
        for (int y = 0; y < 20; y++) {
            J[x + 20 * y] = distribution(generator);
        }
    }
}