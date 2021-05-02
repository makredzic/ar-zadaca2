.section .text
.globl mymax
mymax:

    addiu $t0, $0, 0 # t0 = 0 = i  
    j uslov
    tijelo:


    sll $t3, $t0, 3 # $t3 = 8*i // mnozimo i sa 8 jer je pointer na double koji je 8 bajta
    addu $t2, $a2, $t3 # $t2 = $a2(adresa) + 8*i

    l.d $f4, ($t2) # $f4 = nums[i]
    c.lt.d $f12, $f4 # if ( start < nums[i])
    bc1f kraj

    mov.d $f12, $f4 # start = nums[i]

    kraj:
    addiu $t0, $t0, 1

    uslov:
    slt $t1, $t0, $a3 # if (i < size)
    bne $t1, $0, tijelo

mov.d $f0, $f12
jr $ra