.data 
msg1: .asciiz "Enter any 3 digit number: "
msg2: .asciiz "Spy numbers from 100 to n: "
space : .asciiz " "

.text
.globl main
main:
li $v0, 4
la $a0, msg1
syscall


li $v0,5
syscall

li $t4, 0
li $t5, 0
move $t0, $v0
li $t7,10


li $v0, 4
la $a0, msg2
syscall 


loop:
beq $t7, $t0, endloop
li $t1, 10
div $t7, $t1
mfhi $s0
mflo $t2
div $t2, $t1
mfhi $s1
mflo $s2


add $t4, $s1, $s0
add $t4, $t4, $s2


mult $s0, $s1
mflo $t5
mult $t5, $s2
mflo $t5

move $a0, $t7
addi $t7, $t7, 1
bne $t4, $t5, loop


li $v0, 1
syscall


li $v0, 4
la $a0, space
syscall


 
j loop


endloop:
li $v0,10
syscall