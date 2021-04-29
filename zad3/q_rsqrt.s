.section .data
threehalfs: .float 1.5
onehalf: .float 0.5

.section .text
.globl Q_rsqrt
Q_rsqrt:

    l.s $f8, onehalf # f8 = 0.5f
    l.s $f9, threehalfs # f9 = 1.5f

    mul.s $f10, $f12, $f8 # float x2 = number*0.5f

    mfc1 $t0, $f12 # int i = *(int*) &y

    lui $t1, 0x5f37
    ori $t1, 0x59df

    srl $t0, $t0, 1 # i >> 1
    subu $t0, $t1, $t0 # t0 = 0x5f3759df - (i >> 1)

    mtc1 $t0, $f5 # float y = * (int*) &i

    mul.s $f0, $f5, $f5 # f0 =  y*y
    mul.s $f0, $f0, $f10 # x2 *y*y

    sub.s $f0, $f9, $f0 # f0 = threehalfs - x2*y*y
    mul.s $f0, $f0, $f5


jr $ra
