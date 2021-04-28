.section .data
tekst: .asciiz "%c" #tekst za printf

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


addu $a0, $0, $a2 
jal malloc

la $t0, d
sw $v0, ($t0) # d = return od malloc(r)

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
    sw $s0, 36($sp) # s0 je prezervirani registar a odlucio sam ga koristit dole, zato je stored na stack
    sw $s1, 40($sp)

    bne $a3, $0, else 
    addu $a0, $0, $a1 # a0 = maxr
    jal print_comb # print_comb(maxr)
    j return

else:

    addiu $s0, $0, 0 # s0 = i = 0
    addu $s1, $0, $a2
    j uslov
tijelo:

    la $t0, d
    lw $t0, ($t0) # t0 = d 

    subu $t1, $a1, $a3 # t1 = maxr - r
    addu $t0, $t0, $t1 # t0 = d + maxr - r // adresa + maxr-r

    addu $t1, $a0, $s0 # t1 = chars + i  
    lb $t1, ($t1)
    
    sb $t1, ($t0)

    addiu $a3, $a3, -1

    jal combinations_impl
    addiu $s0, $s0, 1
uslov:
    slt $t0, $s0, $s1
    bne $t0, $0, tijelo

    j return #bespotrebno jer svakako je sljedeca instrukcija u returnu


return:
    lw $ra, 16($sp)
    lw $s0, 36($sp) # s0 je prezervirani registar a odlucio sam ga koristit dole, zato je stored na stack
    lw $s1, 40($sp)
    addiu $sp, $sp, 64
jr $ra



print_comb:
    addiu $sp, $sp, -32
    sw $ra, 16($sp)
    sw $s0, 20($sp) # s0 = i \\ u ovoj funkcij opet koristim prezervirani registar pa ga zato i pohranjujem ovdje
    sw $s1, 24($sp)

    addu $s1, $0, $a0
    addiu $s0, $0, 0 # s0 = i = 0
    j uslov1
tijelo1:
    la $a0, tekst # pointer na na niz 2 charactera %c
    la $a1, d #adresa od d, d cuva adresu takodjer a ne vrijednost neku
    lw $a1, ($a1) # ucitamo adresu koju d cuva

    addu $a1, $a1, $s0 # &d[i]
    lb $a1, ($a1) #a1 = d[i]

    jal printf
    addiu $s0, $s0, 1
uslov1:
    slt $t0, $s0, $s1
    bne $t0, $0, tijelo1
 
end:
    lw $ra, 16($sp)
    lw $s0, 20($sp)
    lw $s1, 24($sp)
    addiu $sp, $sp, 32
jr $ra