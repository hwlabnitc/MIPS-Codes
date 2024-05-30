#DESCRIPTION -TO PRINT PRIME NUMBERS IN A GIVEN RANGE
.data
string1: .asciiz "Enter the LOWER LIMIT \n"
string2: .asciiz "Enter the UPPER LIMIT \n"

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

add $t0 , $v0 , $0  #storing lower limit in $t0

# Printing out the text
li $v0, 4
la $a0, string2
syscall

#Getting user input
li $v0, 5
syscall

add $t1 , $v0 , $0  #storing upper limit in $t1

li $t2,2

j prime

loop: 
	addi $t0,$t0,1
	bgt $t0,$t1,halt
	li $t2 , 2 #$t2 is the counter
	j prime
	
prime:
	bge $t2,$t0,print
	div $t0,$t2
	mfhi $t4
	addi $t2,$t2,1
	beq $t4,$0,loop
	j prime
	
print:
	li $v0, 1
	move $a0, $t0
	syscall
	li $a0, 32 #to print space
	li $v0, 11  # syscall number for printing character
	syscall	
	j loop
	
	
halt:
	li $v0, 10
	syscall
