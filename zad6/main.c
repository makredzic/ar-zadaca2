#include "stdio.h"

double baz(float f1, double* p1, float f2, int n);

int main() {
    float a = 3.2f;
    double bv = 0.; double* b = &bv;
    float c = 60.6f;
    int d = 3;
    
    printf("baz(%f, %f, %f, %d) = %f\n", a, *b, c, d, baz(a, b, c, d));

    bv = 3.; 
    printf("baz(%f, %f, %f, %d) = %f\n", a, *b, c, d, baz(a, b, c, d));
    return 0;
}