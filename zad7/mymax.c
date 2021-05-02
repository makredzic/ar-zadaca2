#include "stdint.h"

//           ( ($f12, $f13),  $a2            ,      $a3)
double mymax(double start, const double* nums, uint32_t size) {
    for (int i = 0; i < size; ++i) {
        if (nums[i] > start) start = nums[i];
    }

    return start;
}