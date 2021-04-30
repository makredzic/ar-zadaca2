#include "stdio.h"

float bar(float , float , double );

int main() {

    float a = 1.3, b = 1.2;
    double c = 1.5;

    float res = bar(a, b, c);
    printf("bar(1.2, 1.3, 1.5) = %f\n", res);

    return 0;
}
