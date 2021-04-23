#include "stdint.h"

void combinations(char *, uint32_t, uint32_t);

int main()
{
    char set[] = {'a', 'b'};
    combinations(set, 2, 2);
    return 0;
}