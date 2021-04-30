.section .data
tekst: .asciiz "Inverse sqrt of %f is: %f\n"

.section .text
.globl main
main:
    addiu $sp, $sp, -32
    sw $ra, 28($sp)
    sw $s0, 24($sp)

    li.s $s0, 35.5
    mtc1 $s0, $f12
    
    jal Q_rsqrt

    la $a0, tekst # a0 = char*

    mtc1 $s0, $f4 # s0 u f4
    cvt.d.s $f4, $f4 # convert iz float u double
    mfc1 $a2, $f4 # a2 = prva polovica 35.5 koji je double
    mfc1 $a3, $f5 # a3 = druga polovica 35.5 koji je double

    cvt.d.s $f6, $f0 # convert return od q_rsqrt u double

    mfc1 $t0, $f6 # t0 = prva polovica 
    mfc1 $t1, $f7 # t1 = druga polovica

    sw $t0, 16($sp)
    sw $t1, 20($sp)

    jal printf # treci argument trazi na stacku 16+sp i 20+sp 

    lw $ra, 28($sp)
    lw $s0, 24($sp)
    addiu $sp, $sp, 32

addiu $v0, $0, 0
jr $ra
