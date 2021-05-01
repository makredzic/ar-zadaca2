.section .text
.globl foo
foo: # (f12 i f13, f14, a3)


    mtc1 $a3, $f4 # prebacit f2 arg u $f4 registar
    cvt.d.s $f4, $f4 #convert f4 iz float u double jer se promocija radi


    c.le.d $f12, $f4  # f12 <= f4 //inverzno od ovog je f12 > f4
    bc1t else1

    mtc1 $a3, $f4
    add.s $f4, $f14, $f4 # f1 + f2
    
    cvt.d.s $f4, $f4 # (double)(f1+f2)
    sub.d $f4, $f4, $f12 # f1 + f2 - d1

    addiu $t0, $0, 3
    mtc1 $t0, $f6 # f6 = 3
    cvt.d.w $f6, $f6 # f6 = 3.

    div.d $f4, $f4, $f6 # (f1+f2-d1)/3.

    cvt.w.d $f4, $f4 # (int)((f1+f2-d1)/3.)
    mfc1 $v0, $f4

    jr $ra
    else1:    


    mtc1 $a3, $f4
    cvt.d.s $f4, $f4 # (double)f2
    
    c.eq.d $f12, $f4 # if (d1 == f2)
    bc1f else2

    cvt.d.s $f4, $f14 # f4 = (double)f14

    c.eq.d $f12, $f4 # if (d1 == f1)
    bc1t else2 # if (d1 == f1) goto else2, if (d1 != f1) continue

    mtc1 $0, $f4 # f4 = 0
    cvt.d.w $f4, $f4 # f4 = 0.

    c.eq.d $f12, $f4 # if (d1 == 0.)
    bc1t else2 # if (d1 == 0.) goto else2, if (d1 != 0.) continue


    cvt.d.s $f4, $f14 # f4 = (double)f1

    addiu $t0, $0, 3
    mtc1 $t0, $f6
    cvt.d.w $f6, $f6 # f6 = 3.

    mul.d $f4, $f4, $f6 # f4 = f1*3.
    div.d $f4, $f4, $f12 # f4 = (f1*3.)/d1

    cvt.w.d $f4, $f4
    mfc1 $v0, $f4

    jr $ra
    else2:


    mtc1 $a3, $f4 
    cvt.d.s $f4, $f4 # $f4 =  (double)f2
    
    c.lt.d $f12, $f4  # if (d1 < f2)
    bc1f else3 # if !(d1<f2) goto else3

    cvt.d.s $f4, $f14 # $f4 = (double)f1
    c.eq.d $f12, $f4 # if(d1 == f1)
    bc1f else3

    mtc1 $0, $f4
    cvt.d.w $f4, $f4

    cvt.d.s $f4, $f14 # $f4 = (double)f1
    c.eq.d $f6, $f4 # if(f1 == 0)
    bc1t else3 # if (f1 == 0) goto else3

    mtc1 $a3, $f4
    cvt.d.s $f4, $f4 # $f4 = (double)f2

    sub.d $f4, $f12, $f4 # $f4 = d1 - (double)f2
    abs.d $f4, $f4 # abs(d1-(double)f2)
    
    cvt.d.s $f6, $f14 # $f6 = (double)f1
    
    div.d $f4, $f4, $f6 # $f4 = abs(d1-(double)f2) / (double)f1
    cvt.w.d $f4, $f4 # (int)$f4

    mfc1 $v0, $f4
    jr $ra 
    else3:

    mtc1 $a3, $f6
    mul.s $f4, $f14, $f6 # $f4 = f1*f2

    addiu $t0, $0, 12
    mtc1 $t0, $f6
    cvt.d.w $f6, $f6 # $f6 = 12.

    mul.d $f6, $f6, $f12 # $f6 = 12. * d1

    cvt.d.s $f4, $f4
    sub.d $f4, $f4, $f6

    cvt.w.d $f4, $f4
    mfc1 $v0, $f4

    jr $ra