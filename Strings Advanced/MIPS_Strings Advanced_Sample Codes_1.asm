# access and print each character of a string ( excluding and including \n character)
#input : hello wil be stored as ['h','e','l','l','o','\n','\0']

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
print:
lb $t2,str($t0)
beqz $t2,exit
li $v0,11
move $a0,$t2
syscall
li $v0,11
li $a0,'\n'
syscall
addi $t0,$t0,1
j print

exit:
li $v0,10
syscall




.data:
str: .space 100
msg1: .asciiz "Enter the string:"