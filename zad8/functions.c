#include "stdint.h"

//static jer se ova funkcija samo u ovom fileu koristi
//                          $a0  ,           $a1
static void roundToTick(double* p, uint32_t precision) {
   uint32_t r = *p * precision;
   *p = (double)r / precision;
}

//static jer se ova funkcija samo u ovom fileu koristi
//                        $f12,$f13
static double getTick(double num) {
    if (num == 0) return 0.;
    if (num < 10) return 0.001;
    if (num < 100) return 0.01;
    if (num < 1000) return 0.1;
    return 1.;
}

//                        ($f12,$f13),  $a2
double calculateAmount(double price, int quantity) {
    roundToTick(&price, 1 / getTick(price));
    return price*quantity;
}