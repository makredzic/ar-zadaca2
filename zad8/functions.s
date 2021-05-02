.section .text
roundToTick:

    l.d $f4, ($a0)

    mtc1 $a1, $f6 # $f6 = precision
    cvt.d.w $f6, $f6 # $f6 = (double)precision
    mul.d $f4, $f4, $f6 # $f4 = *p * (double)precision
    
    cvt.w.d $f4, $f4 # uint32_t r = *p * precision
    cvt.d.w $f4, $f4 # $f4 = (double)r

    div.d $f4, $f4, $f6 # (double)r / (double)precision

    s.d $f4, ($a0)
    

jr $ra 

getTick:

    li.d $f4, 0.0
    c.eq.d $f12, $f4 # if ( num == 0)
    bc1f else1
    li.d $f0, 0.0

    j return

    else1:
    li.d $f4, 10.0
    c.lt.d $f12, $f4 # if (num < 10)
    bc1f else2
    li.d $f0, 0.001

    j return

    else2:
    li.d $f4, 100.0
    c.lt.d $f12, $f4 # if (num < 100)
    bc1f else3
    li.d $f0, 0.01

    j return

    else3:
    li.d $f4, 1000.0
    c.lt.d $f12, $f4 # if (num < 1000)
    bc1f else4
    li.d $f0, 0.1

    j return

    else4:
    li.d $f0, 1.0

return:
jr $ra

.globl calculateAmount
calculateAmount: # calculateAmount(($f12,$f13), $a2)
    addiu $sp, $sp, -32
    sw $ra, 16($sp)
    sw $a2, 20($sp)
    swc1 $f12, 24($sp)
    swc1 $f13, 28($sp)

    jal getTick # samo pozovemo jer je vec u f12,f13 argument

    addiu $a0, $sp, 24 # $a0 = &price

    li.d $f4, 1.0
    div.d $f4, $f4, $f0 # 1 / getTick(price)
    cvt.w.d $f4, $f4 # (int)(1/getTick(price))
    mfc1 $a1, $f4 # $a1 = $f4
        
    jal roundToTick # ($a0, $a1)

    l.d $f6, 24($sp) # $f6 = price

    lw $a2, 20($sp) # $a2 = quantity
    mtc1 $a2, $f4
    cvt.d.w $f4, $f4 # $f4 = (double)quantity

    mul.d $f0, $f4, $f6 # (double)quantity * price

lw $ra, 16($sp)
addiu $sp, $sp, 32
jr $ra