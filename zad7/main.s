.section .data
tekst: .asciiz "MyMax: %f\n"
nums: .double 1.0,5.7,9.4,14.8,7.1,8.2,10.5

.section .text
.globl main
main:
    addiu $sp, $sp, -32
    sw $ra, 24($sp)

    addiu $a3, $0, 7 # $a3 = 7

    la $a2, nums # $a2 = nums
    l.d $f12, ($a2) # $f12 = num[0]

    jal mymax

    la $a0, tekst

    mfc1 $a2, $f0
    mfc1 $a3, $f1

    jal printf



    lw $ra, 24($sp)
    addiu $sp, $sp, 32

jr $ra