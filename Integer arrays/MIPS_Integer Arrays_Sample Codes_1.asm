# Using proper formatting, input an integer array from the user
# and print the array. Appropriate messages need to be shown


.globl main
main:

li $v0,4
la $a0,msg1
syscall

li $v0,5
syscall
move $s1,$v0
li $t0,0

input:
beq $t0,$s1,end_input
sll $t2,$t0,2
li $v0,4
la $a0,msg2
syscall
li $v0,5
syscall
sw $v0,arr($t2)
addi $t0,$t0,1
j input

end_input:
li $t1,0

li $v0,4
la $a0,msg3
syscall

print:
beq $t1,$s1,exit
sll $t2,$t1,2
lw $t3,arr($t2)
li $v0,1
move $a0,$t3
syscall
li $v0,11
li $a0,32
syscall
addi $t1,$t1,1
j print

exit:
li $v0,10
syscall

.data:

arr: .space 100
msg1: .asciiz "Enter N:"
msg2: .asciiz "Enter integer:"
msg3: .asciiz "The array is :"
