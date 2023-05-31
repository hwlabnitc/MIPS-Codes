# FINDING THE SUM OF ELEMENTS OF AN ARRAY

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
sll $t1,$t0,2
li $v0,4
la $a0,msg2
syscall
li $v0,5
syscall
sw $v0,arr($t1)
addi $t0,$t0,1
j input

end_input:
li $t1,0
li $t0,0
sum:
beq $t0,$s1,end
sll $t2,$t0,2
lw $t3,arr($t2)
add $t1,$t1,$t3
addi $t0,$t0,1
j sum

end:

li $v0,4
la $a0,msg3
syscall
li $v0,1
move $a0,$t1
syscall

li $v0,10
syscall




.data:
arr: .space 100
msg1: .asciiz "Enter N:"
msg2: .asciiz "Enter integer:"
msg3: .asciiz "Sum of the numbers is:"
