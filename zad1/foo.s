.section .text
.global foo
foo: # a0 = short a, a1 = short b

  addiu $sp, $sp, -32 # ------- STACK OPERACIJE
  sw $ra, 16($sp)
  sh $a0, 20($sp)
  sh $a1, 22($sp)

  slti $t0, $a0, 2 # if a < 2
  beq $t0, $0, else1

  addiu $v0, $0, 0 # if a<2 true, return 0
  j return

else1:
  slti $t0, $a1, 3 # if b < 3
  beq $t0, $0, else2

  addiu $v0, $0, 1
  j return
  
else2:
  slt $t0, $a0, $a1 # if (a < b)
  beq $t0, $0, else

  addiu $a0, $a0, -1 # a-1
  addiu $a1, $a1, -3 # b-3


  jal foo # foo(a-1, b-3)

  lw $ra, 16($sp)
  lh $a0, 20($sp)

  addu $v0, $a0, $v0 # a + foo(a-1, b-3)
  j return

else:
  addiu $a0, $a0, -2 #a-2
  addiu $a1, $a1, -1 #b-1


  jal foo #foo(a-2, b-1)

  lw $ra, 16($sp)
  lh $a0, 20($sp)
  lh $a1, 22($sp)

  subu $a0, $a0, $a1
  addu $v0, $a0, $v0
  j return

return:

  addiu $sp, $sp, 32
  jr $ra