#DESCRIPTION - PRINTING THE Nth FIBONACCI NUMBER
#0th fibonacci number is 0
#1st fibonacci number is 1
.data
string1: .asciiz  "Enter the number\n"

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

li $t0 , 0
li $t1 , 1

beq $v0 , $t0 , print0
beq $v0 , $t1 , print1

li $t2,1

loop:
	beq $t2,$v0,print
	add $t5,$t1,$t0  #adding $t1 and $t0
	add $t0,$0,$t1 #moving the old t1 to t0 
	add $t1,$t5,$0  #t5 = adding t0 and t1, and storing in t1
	addi $t2,$t2,1  #incrementing counter
	j loop
	

print0:
	li $v0, 1
	move $a0, $t0
	syscall
	j exit

print1:
	li $v0, 1
	move $a0, $t1
	syscall
	j exit

print:
	li $v0, 1
	move $a0, $t5
	syscall
	j exit
	
exit:
	li $v0, 10
	syscall


