#include "stdio.h"

int foo(double, float, float);

int main() {

    double a = 100.5;
    float b = 3.2f, c = 1.25f;

    // prvi je %f iako je double zato sto nema oznake za double
    // uvijek se vrsi promocija floata svakako u double pri
    // pozivu printf sa float-om
    printf("foo(%f, %f, %f) = %d\n", a, b, c, foo(a, b, c));

    a = 50.5, b = 3.2f, c = 50.5f;
    printf("foo(%f, %f, %f) = %d\n", a, b, c, foo(a, b, c));

    a = 29.6, b = 29.6f, c = 12.3f;
    printf("foo(%f, %f, %f) = %d\n", a, b, c, foo(a, b, c));

    a = -12.6, b = 0.f, c = 34.4f;
    printf("foo(%f, %f, %f) = %d\n", a, b, c, foo(a, b, c));

    return 0;
}