# Finding the length of a string

.globl main
main:

li $v0,4
la $a0,msg1
syscall

li $v0,8
la $a0,str
li $a1,100
syscall

li $t0,0
len:
lb $t1,str($t0)
beq $t1,10,exit
addi $t0,$t0,1
j len

exit:
li $v0,4
la $a0,msg2
syscall
li $v0,1
move $a0,$t0
syscall



.data:
str: .space 100
msg1: .asciiz "Enter STRING:"
msg2: .asciiz "length of string is "
