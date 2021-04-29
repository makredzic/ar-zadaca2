#include <stdio.h>


float Q_rsqrt (float);

int main() {

    float x = 35.5;
    float inversSqrt = Q_rsqrt(x);
    printf("Inverse square root of %f is: %f\n", x, inversSqrt);

    return 0;
}