# To check whether a string is a palindrome or not

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
beq $t1,10,len_exit
addi $t0,$t0,1
j len

len_exit:
li $s0,0
addi $s1,$t0,-1

palindrome:
lb $t1,str($s0)
lb $t2,str($s1)
bge $s0,$s1,true
bne $t1,$t2,false
addi $s0,$s0,1
addi $s1,$s1,-1
j palindrome

true:
li $v0,4
la $a0,msg_true
syscall
j exit

false:
li $v0,4
la $a0,msg_false
syscall


exit:
li $v0,10
syscall

.data:
str: .space 100
msg_true: .asciiz " It is a Palindrome"
msg_false: .asciiz " It is not a Palindrome"
msg1: .asciiz " Enter a string: "
