#DESCRIPTION - CHECK IF A NUMBER IS ARMSTRONG OR NOT
.data
string1: .asciiz   "Enter the number \n"
string3: .asciiz "IT IS AN ARMSTRONG NUMBER \n"
string4: .asciiz "IT IS NOT AN ARMSTRONG NUMBER \n"
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

add $t0, $v0 , $0  #creates a copy of the original number
li $t1, 0 #stores the sum of the cube of digits
li $t2, 10 #stores 10 for division purposes

loop: 
	div $t0,$t2
	mfhi $t3 #remainder i.e each digit
	mflo $t0
	mul $t4,$t3,$t3
	mul $t4,$t4,$t3
	add $t1,$t1,$t4
	bgt $t0,$0,loop
	j exit
	
exit:
	beq $t1,$v0,equal
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
	
