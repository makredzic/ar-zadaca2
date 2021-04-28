.section .data
tekst: .asciiz "%c"

.section .bss
d: .word

.section .text
.globl combinations
combinations:
    addiu $sp, $sp, -64
    sw $ra, 16($sp)
    sw $a0, 20($sp)
    sw $a1, 24($sp)
    sw $a2, 28($sp)

    addu $a0, $0, $a2 # a0 = a2 = r
    jal malloc # malloc(r)

    la $t0, d
    sw $v0, ($t0) #d = malloc(r)

    lw $a0, 20($sp) #a0 = chars
    lw $a1, 24($sp) #a1 = size
    lw $a2, 28($sp) #a2 = r

    addu $a3, $0, $a2 # a3 = r
    addu $a2, $0, $a1 # a2 = size
    addu $a1, $0, $a3 # a1 = r
    jal combinations_impl

    lw $ra, 16($sp)
    addiu $sp, $sp, 64 

jr $ra



combinations_impl:
    addiu $sp, $sp, -64
    sw $ra, 16($sp)

    bne $a3, $0, else # if (r != 0) goto else
    addu $a0, $0, $a1 # a0 = maxr
    jal print_comb

    lw $ra, 16($sp) 
    addiu $sp, $sp, 64
    jr $ra


    else: 
        sw $s0, 20($sp)
        sw $s1, 24($sp)

        sw $a0, 28($sp)
        sw $a1, 32($sp)
        sw $a2, 36($sp)
        sw $a3, 40($sp)

        addiu $s0, $0, 0 # s0 = i = 0
        addu $s1, $0, $a2 # s1 = size
        j uslov
    tijelo:

        lw $a0, 28($sp)
        lw $a1, 32($sp)
        lw $a2, 36($sp)
        lw $a3, 40($sp)

        la $t0, d
        lw $t0, ($t0) #t0 = d

        subu $t1, $a1, $a3 # t1 = maxr-r
        addu $t0, $t0, $t1 # t0 = d + maxr-r

        addu $t1, $a0, $s0 # t1 = chars + i 
        lb $t1, ($t1) # t1 = chars[i]
        sb $t1, ($t0) # d[maxr-r] = chars[i]


        addiu $a3, $a3, -1  
        jal combinations_impl

        addiu $s0, $s0, 1
    uslov:
        slt $t0, $s0, $s1 # i < size
        bne $t0, $0, tijelo 

lw $ra, 16($sp)
lw $s0, 20($sp)
lw $s1, 24($sp)
addiu $sp, $sp, 64
jr $ra


print_comb:
    addiu $sp, $sp, -64
    sw $ra, 16($sp)
    sw $s0, 20($sp)
    sw $s1, 24($sp)


    addu $s1, $0, $a0 # s1 = maxr
    addiu $s0, $0, 0 # s0 = i = 0
    j uslov1
    tijelo1:

        la $t0, d
        lw $t0, ($t0) # t0 = d

        la $a0, tekst
        addu $a1, $t0, $s0 # t0 = d[i]

        lb $a1, ($a1)
        jal printf

        addiu $s0, $s0, 1 # i++
    uslov1:
        slt $t0, $s0, $s1 # if i < maxr
        bne $t0, $0, tijelo1

lw $ra, 16($sp)
lw $s0, 20($sp)
lw $s1, 24($sp)
addiu $sp, $sp, 64
jr $ra


