// From "Writing MATLAB C/MEX code (Getreur)

#include "mex.h"
#include <iostream>
#include <vector>
#include <math.h>
#include "matrix.h"

using namespace std;

class protein {
public:
    vector<int> m;
    vector<int> x;
    vector<int> y;
    vector<int> z;
public:
    // Insert functions
    ~protein(){}
};

// Monomer interaction energys as a random uniform distribution
double J[20][20] = 
{
    {-2.9072,-2.1607,-2.1395,-2.7015,-2.3511,-3.7573,-2.1829,-3.5401,-2.1672,-2.6092,-2.2258,-3.5171,-3.085,-2.3573,-2.851,-2.6494,-2.6557,-2.1708,-3.5473,-3.7515  },
    {-3.3333,-2.8891,-2.1403,-2.9439,-2.4795,-2.7797,-2.5704,-3.8092,-2.684,-2.0305,-2.5272,-3.9446,-3.3736,-2.725,-2.9469,-3.7517,-3.7858,-2.3509,-2.6595,-2.2815  },
    {-2.3417,-3.7514,-3.7257,-2.4363,-3.1187,-2.054,-2.2831,-3.5181,-2.796,-2.9412,-2.1421,-3.1423,-3.8734,-3.0156,-3.2595,-2.3426,-3.4455,-3.7259,-3.5657,-2.4591  },
    {-2.3143,-3.0846,-2.3537,-2.6392,-3.7375,-3.8742,-2.9814,-3.468,-2.8312,-3.3982,-2.9561,-3.9532,-2.6752,-3.9755,-3.0354,-2.1474,-2.7031,-3.8039,-3.6191,-3.6519 },
    {-3.0525,-2.7351,-3.3903,-2.7365,-3.5503,-3.7853,-2.5805,-3.9954,-3.7812,-3.139,-3.9389,-3.3235,-3.3777,-2.4622,-3.2199,-3.4806,-2.2199,-3.3518,-2.7068,-3.5383 },
    {-2.4224,-2.5687,-3.4185,-2.224,-3.6554,-3.5766,-2.1562,-3.9737,-2.4147,-2.5753,-3.9064,-3.4882,-2.7564,-2.9655,-3.1312,-3.7739,-3.1906,-3.2251,-3.7715,-2.7869 },
    {-3.2636,-3.1046,-3.9189,-3.812,-2.4959,-3.5382,-2.0858,-2.3499,-2.02,-3.357,-3.1691,-2.2513,-3.7337,-2.44,-2.9101,-2.0592,-2.5319,-2.0799,-2.4502,-3.4454      },
    {-2.2654,-3.7772,-2.8917,-3.3521,-2.0019,-2.4695,-2.4229,-2.584,-2.1113,-3.3099,-3.1255,-2.1582,-2.0238,-2.6417,-3.645,-2.4019,-2.1564,-2.2284,-3.6276,-2.4476  },
    {-2.0941,-2.8352,-2.2885,-3.6523,-3.7706,-3.1476,-3.5759,-3.4043,-2.9769,-2.5354,-3.7979,-3.8877,-2.8266,-2.648,-3.7547,-2.3953,-2.7074,-2.6883,-3.1305,-3.1436 },
    {-2.8947,-3.224,-2.9157,-2.5656,-2.4614,-3.0632,-2.8576,-3.6977,-3.2499,-2.6146,-2.3491,-2.7695,-2.3286,-2.2767,-3.0146,-2.1329,-2.2125,-2.2955,-3.3612,-3.1037 },
    {-3.9135,-3.5847,-2.0436,-2.5863,-3.9608,-2.268,-3.1121,-2.9786,-3.9996,-2.8951,-2.879,-3.3754,-3.0493,-2.7632,-3.2083,-2.7811,-2.245,-3.123,-2.9507,-2.7423    },
    {-3.1613,-3.4099,-2.0037,-3.681,-2.8514,-2.4508,-2.1278,-3.1735,-3.953,-3.95,-3.8722,-2.6736,-3.4576,-2.7674,-2.6752,-3.8732,-2.5022,-3.7979,-2.5567,-2.1928    },
    {-3.0234,-3.2542,-3.8906,-3.9642,-3.3383,-3.0109,-3.1967,-3.0164,-3.1379,-2.3759,-3.1136,-2.9589,-2.3725,-3.7598,-2.6586,-3.2484,-3.9469,-3.4546,-2.6333,-2.9251},
    {-2.2982,-3.7083,-2.6946,-2.0003,-2.7008,-3.5343,-2.9069,-3.1222,-2.4891,-2.0861,-3.8579,-3.5199,-3.7659,-3.4876,-2.012,-2.7168,-2.4779,-2.3402,-3.03,-2.7445   },
    {-3.0712,-3.63,-3.8146,-2.1478,-3.0949,-3.4067,-2.4315,-3.4006,-2.0896,-3.6182,-3.3995,-2.8724,-2.2294,-2.4396,-3.7495,-2.0727,-2.1144,-3.5488,-3.6731,-3.9033  },
    {-3.7566,-3.2679,-2.5887,-2.8162,-3.1779,-3.1087,-2.8281,-3.1454,-3.5341,-2.4682,-3.8332,-2.7016,-2.1774,-3.2668,-3.3186,-3.8924,-2.7627,-3.881,-2.5922,-2.4113 },
    {-2.3201,-3.6556,-3.4549,-3.5489,-2.3302,-2.8691,-2.7597,-2.2117,-3.739,-3.5892,-2.2624,-3.6909,-3.1662,-2.601,-2.325,-3.4956,-2.4406,-2.7328,-3.2527,-2.0883   },
    {-2.8379,-2.1506,-3.5908,-2.4429,-3.7717,-2.3442,-2.8168,-3.3258,-3.8934,-2.0444,-3.8437,-3.501,-2.7284,-3.184,-2.7479,-3.1891,-3.3989,-2.5679,-3.2479,-3.425   },
    {-2.5147,-3.9603,-2.4628,-3.3819,-3.052,-2.4579,-2.5058,-2.1873,-3.4306,-2.2086,-3.6162,-3.0271,-3.4017,-3.2654,-3.0185,-3.1235,-2.7362,-3.9852,-3.5186,-2.8442 },
    {-2.9924,-3.9726,-2.5132,-2.2691,-2.1803,-2.3227,-3.5556,-3.946,-3.3302,-2.0497,-3.9566,-2.2914,-2.2002,-2.4324,-3.2102,-2.9991,-2.4959,-2.5511,-3.0951,-3.7847 }
};

double monomer_energy(int x, protein& pro);

void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
    mxArray *e_out;
    int w, len;  // dimensions of protein
    double *p = (double*)mxGetPr(prhs[0]);
    double *e;
    
    plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
    e = mxGetPr(plhs[0]);
    protein pro;    // protein object for more readable cod
    
    
    double energy = 0;
    len = mxGetN(prhs[0]);
    w = mxGetM(prhs[0]);
    
    
    for (int i = 0; i < len; i++) {
        pro.m.push_back( p[i * w]);
        pro.x.push_back( p[i * w + 1]);
        pro.y.push_back( p[i * w + 2]);
        pro.z.push_back( p[i * w + 3]);
    }
    /*
    for (int i = 0; i < len; i++) {
        mexPrintf("%d-", pro.m[i]);
    }
    mexPrintf("\n");
    for (int i = 0; i < len; i++) {
        mexPrintf("%d-", pro.x[i]);
    }
    mexPrintf("\n");
    for (int i = 0; i < len; i++) {
        mexPrintf("%d-", pro.y[i]);
    }
    mexPrintf("\n");
    for (int i = 0; i < len; i++) {
        mexPrintf("%d-", pro.z[i]);
    }
    mexPrintf("\n");*/
    for (int i = 0; i < len; i++) {
        energy += monomer_energy(i, pro);
    }
    //mexPrintf("%lf", energy / 2);
    e[0] = energy / 2;
    
    return;
}

double monomer_energy(int m, protein& pro)
{
    double energy = 0;
	for (int i = 0; i < pro.m.size(); i++) {
        if (abs(i - m) > 1) {
            // Neighbour to the right
            if ( (pro.x[m] + 1 == pro.x[i]) 
            && (pro.y[m] == pro.y[i])
            && (pro.z[m] == pro.z[i]) ) {
                energy += J[pro.m[i]][pro.m[m]];
            }
            // Neighbour to the left
            if ( (pro.x[m] - 1 == pro.x[i]) 
            && (pro.y[m] == pro.y[i])
            && (pro.z[m] == pro.z[i]) ) {
                energy += J[pro.m[i]][pro.m[m]];
            }
            // Neighbour above
            if ( (pro.x[m] == pro.x[i]) 
            && (pro.y[m] + 1 == pro.y[i]) 
            && (pro.z[m] == pro.z[i]) ) {
                energy += J[pro.m[i]][pro.m[m]];
            }
            // Neighbour below
            if ( (pro.x[m] == pro.x[i]) 
            && (pro.y[m] - 1 == pro.y[i])
            && (pro.z[m] == pro.z[i]) ) {
                energy += J[pro.m[i]][pro.m[m]];
            }
            // Neighbour forwards
            if ( (pro.x[m] == pro.x[i]) 
            && (pro.y[m] == pro.y[i])
            && (pro.z[m] + 1 == pro.z[i]) ) {
                energy += J[pro.m[i]][pro.m[m]];
            }
            // Neighbour backwards
            if ( (pro.x[m] == pro.x[i]) 
            && (pro.y[m] == pro.y[i])
            && (pro.z[m] - 1 == pro.z[i]) ) {
                energy += J[pro.m[i]][pro.m[m]];
            }
            
        }

	}
	return energy;
}