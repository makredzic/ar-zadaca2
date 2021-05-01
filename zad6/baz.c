//         (  $f12 ,    $a1    ,     $a2 ,   $a3 )
double baz(float f1, double* p1, float f2, int n) {
    if (*p1 == 0. || (f1 + f2 < n)) {
        return f1 + f2*n;
    }

    if (*p1 != 0.) {
        return (f1 - f2*n) / *p1;
    }

    return f1 * *p1 + n + f2;
}