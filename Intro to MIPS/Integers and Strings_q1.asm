# MIPS Program to reverse a two digit number 


.data 
msg1: .asciiz "Enter a two digit number: "
msg2: .asciiz "its reverse is: "
.text 
.globl main
main:
	li $v0, 4
	la $a0, msg1
	syscall 
	

	li $v0, 5
	syscall


	move $t0, $v0
	li $t1, 10
	div $t0, $t1
	mflo $t2
	mfhi $t3
	mult $t3, $t1
	mflo $t3
	add $t4,$t3,$t2

	li $v0, 4
	la $a0, msg2
	syscall 

	li $v0, 1
	move $a0, $t4
	syscall 

	li $v0,10
	syscall