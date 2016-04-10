#include <math.h>
#include <vector>

#pragma once

using std::vector;

class protein {
public:
    vector<int> m;
    vector<int> x;
    vector<int> y;
    vector<int> z;
    double J[20][20];
public:
    protein(double*, int, int, double*);
    ~protein(){}
    double size();
    double monomer_energy(int m);
    double energy();
};

inline protein::protein(double* p, int len, int w, double* j)
{
    for (int i = 0; i < len; i++) {
        m.push_back( p[i * w] );
        x.push_back( p[i * w + 1] );
        y.push_back( p[i * w + 2] );
        z.push_back( p[i * w + 3] );
    }
    for (int x = 0; x < 20; x++){
        for (int y = 0; y < 20; y++){
            J[x][y] = j[x + y];
        }
    }
}

inline double protein::size()
{
    // Length of protein
    int len = m.size();
    //mexPrintf("len=%d\n", len);
    // Initial center of mass coordinates set to 0
    double c_x = 0;
    double c_y = 0;
    double c_z = 0;
    // Initial ruggedness set to 0;
    double s = 0;
    
    for (int i = 0; i < len; i++) {
        c_x += (double)x[i];
        c_y += (double)y[i];
        c_z += (double)z[i];
    }
    c_x /= (double)len;
    c_y /= (double)len;
    c_z /= (double)len;
    
    for (int i = 0; i < len; i++) {
        s += pow((double)x[i] - c_x, 2) + pow((double)y[i] - c_y, 2) + pow((double)z[i] - c_z, 2);
    }
    return (s / len);
}

inline double protein::monomer_energy(int mono)
{
    double energy = 0;
	for (int i = 0; i < m.size(); i++) {
        if (abs(i - mono) > 1) {
            // Neighbour to the right
            if ( (x[mono] + 1 == x[i]) && (y[mono] == y[i]) && (z[mono] == z[i]) ) {
                energy += J[m[i]][m[mono]];
            }
            // Neighbour to the left
            if ( (x[mono] - 1 == x[i]) && (y[mono] == y[i]) && (z[mono] == z[i]) ) {
                energy += J[m[i]][m[mono]];
            }
            // Neighbour above
            if ( (x[mono] == x[i]) && (y[mono] + 1 == y[i]) && (z[mono] == z[i]) ) {
                energy += J[m[i]][m[mono]];
            }
            // Neighbour below
            if ( (x[mono] == x[i]) && (y[mono] - 1 == y[i]) && (z[mono] == z[i]) ) {
                energy += J[m[i]][m[mono]];
            }
            // Neighbour forwards
            if ( (x[mono] == x[i]) && (y[mono] == y[i]) && (z[mono] + 1 == z[i]) ) {
                energy += J[m[i]][m[mono]];
            }
            // Neighbour backwards
            if ( (x[mono] == x[i]) && (y[mono] == y[i]) && (z[mono] - 1 == z[i]) ) {
                energy += J[m[i]][m[mono]];
            }
        }
	}
	return energy;
}

inline double protein::energy()
{
    double energy = 0;
    for (int i = 0; i < m.size(); i++) {
        energy += monomer_energy(i);
    }
    return energy;
}
