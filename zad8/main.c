#include "stdio.h"

double calculateAmount(double, int);

int main() {

    for (double i = 3.451748; i < 4000.; i*=10.) {
        printf("Amount (%f, 307) = %f\n", i, calculateAmount(i,307));
    }

    return 0;
}