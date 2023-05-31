# code for finding the maximum element in an array

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

li $t0,0
li $t1,-10000
max:
beq $t0,$s1,end
sll $t2,$t0,2
lw $t3,arr($t2)
bgt $t3,$t1,max_change
addi $t0,$t0,1
j max

max_change:
move $t1,$t3
addi $t0,$t0,1
j max

end:
li $v0,4
la $a0,msg3
syscall

li $v0,1
move $a0,$t1
syscall




.data:
arr: .space 100
msg1: .asciiz "Enter N:"
msg2: .asciiz " Enter Integer Input:"
msg3: .asciiz " The greatest element:"
