.section .text
.globl bar
bar: #(f12, f14, a2 i a3) - argumenti na ovim lokacijama, 3. argument tipa double je u reg a2 i reg a3

    c.lt.s $f12, $f14 # if (f12 < f14)
    bc1f else1 # if false, go to else1

    addiu $t0, $0, 2
    mtc1 $t0, $f4
    cvt.s.w $f4, $f4 #convert 2 to 2.0f

    ceil.w.s $f5, $f12 # f5 = ceil(f12)
    cvt.s.w $f5, $f5 # posto se f5 mnozi sa floatom, mora se opet konvertat u float
    mul.s $f0, $f4, $f5 #f0 = 2.f*ceil(f1)

    round.w.s $f4, $f14 # round(f2)
    cvt.s.w $f4, $f4 #opet u float jer je i ovaj f0 iznad float i sa njim se oduzima
    sub.s $f0, $f0, $f4 # f0 - round(f2)

    mtc1 $a2, $f4
    mtc1 $a3, $f5

    trunc.w.d $f4, $f4 #trunc(d1)
    cvt.s.w $f4, $f4 # opet convert u float
    add.s $f0, $f0, $f4 # f0 + trunc(d1)

    jr $ra

    else1:
    c.eq.s $f12, $f14 # if (f12 == f14)
    bc1f else2

    ceil.w.s $f4, $f12 # ceil(f1)
    cvt.s.w $f4, $f4 #ceil(f1) je sad opet float

    floor.w.s $f5, $f14 # floor(f2)
    cvt.s.w $f5, $f5

    sub.s $f0, $f4, $f5 # f0 = ceil(f1) - floor(f2)

    mtc1 $a2, $f6
    mtc1 $a3, $f7

    trunc.w.d $f6, $f6
    cvt.s.w $f6, $f6

    add.s $f0, $f0, $f6 # f0 + trunc(d1)

    jr $ra

    else2:

    mtc1 $a2, $f6
    mtc1 $a3, $f7
    cvt.s.d $f0, $f6

jr $ra