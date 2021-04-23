.section .data
set: .asciiz "ab"

.section .text
.globl main
main:

addiu $sp, $sp, -32
sw $ra, 16($sp)

la $a0, set # a0 = chars*
addiu $a1, $0, 2 # a1 = size
addiu $a2, $0, 3 # a2 = r
jal combinations

lw $ra, 16($sp)
addiu $sp, $sp, 32

addiu $v0, $0, 0
jr $ra