#DESCRIPTION - CHECK IF A NUMBER IS PERFECT OR NOT
.data
string1: .asciiz  "Enter the number\n"
string3: .asciiz "IT IS A PERFECT NUMBER \n"
string4: .asciiz "IT IS NOT A PERFECT NUMBER \n"
#------------------
# Main program body
#------------------
.text
main:
# Printing out the text
li $v0, 4
la $a0, string1
syscall

#Getting user input
li $v0, 5
syscall

li $t0 , 1  #counter
li $t2 , 0  #sum of divisors

check:
	bgt $t0,$v0,exit
	div $v0,$t0
	mfhi $t1
	beq $t1,$0, divisor
	addi $t0, $t0, 1
	j check
	
divisor:
	add $t2,$t2,$t0
	addi $t0,$t0,1
	j check
	
exit:
	sub $t2 , $t2 , $v0
	beq $t2,$v0,equal
	li $v0, 4
	la $a0,string4
	syscall
	j  halt
	
equal:
	li $v0, 4
	la $a0,string3
	syscall
	j  halt
	
halt:
	li $v0, 10
	syscall

	
	
