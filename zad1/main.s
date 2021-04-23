.section .data
tekst: .asciiz "foo(%d, %d), %hd\n"

.section .text
.global main
main: 
addiu $sp, $sp, -32
sw $s0, 16($sp)
sw $s1, 20($sp)
sw $ra, 24($sp)

addiu $s0, $0, 2 # s0 = i = 2
j uslov1
tijelo1:

j uslov2
tijelo2:

addu $a0, $0, $s0
addu $a1, $0, $s1

jal foo

la $a0, tekst
addu $a1, $0, $s0
addu $a2, $0, $s1
addu $a3, $0, $v0
jal printf


addiu $s1, $s1, 1
uslov2: slti $t1, $s1, 7
bne $t1, $0, tijelo2


addiu $s0, $s0, 1
uslov1: slti $t0, $s0, 6
addiu $s1, $0, 3 # s1 = j = 3
bne $t0, $0, tijelo1



lw $s0, 16($sp)
lw $s1, 20($sp)
lw $ra, 24($sp)
addiu $sp, $sp, 32

addiu $v0, $0, 0
jr $ra