.section .text
.globl baz
baz:

    l.d $f4, ($a1) # $f4 = *p1
    
    mtc1 $0, $f6
    cvt.d.w $f6, $f6 # $f6 = 0.
    
    c.eq.d $f4, $f6 # if(*p1 == 0.)
    bc1t tijelo1

    mtc1 $a2, $f5
    add.s $f4, $f12, $f5 # $f4 = f1+f2

    mtc1 $a3, $f5
    cvt.s.w $f5, $f5 # $f5 = (float)n

    c.lt.s $f4, $f5 # if (f1+f2 < n)
    bc1f else1

    tijelo1:

    mtc1 $a3, $f4
    cvt.s.w $f4, $f4 # $f4 = (float)n

    mtc1 $a2, $f5 # $f5 = f2

    mul.s $f4, $f5, $f4 # $f4 = f2*(float)n
    add.s $f4, $f12, $f4 # f1 + f2*(float)n

    cvt.d.s $f0, $f4
    jr $ra

    else1:

    l.d $f4, ($a1)
    mtc1 $0, $f6
    cvt.d.w $f6, $f6 # $f6 = 0.

    c.eq.d $f4, $f6 # if (*p1 == 0)
    bc1t else2 # if (*p1 == 0) goto else2


    mtc1 $a3, $f4
    cvt.s.w $f4, $f4 # $f4 = (float)n

    mtc1 $a2, $f5 # $f5 = f2

    mul.s $f4, $f5, $f4 # $f4 = f2*(float)n
    sub.s $f4, $f12, $f4 # f1 - f2*(float)n

    cvt.d.s $f4, $f4 
    
    l.d $f6, ($a1)
    div.d $f0, $f4, $f6

    jr $ra

    else2:

    cvt.d.s $f4, $f12 # $f4 = (double)f1
    l.d $f6, ($a1) # $f6 = *p1

    mul.d $f4, $f4, $f6 # $f4 = f1 * *p1
    
    mtc1 $a3, $f6
    cvt.d.w $f6, $f6 # $f6 = (double)n

    add.d $f4, $f4, $f6 # f1 * *p1 + n

    mtc1 $a2, $f6
    cvt.d.s $f6, $f6

    add.d $f0, $f4, $f6 # f1 * *p1 + n + f2

    jr $ra
