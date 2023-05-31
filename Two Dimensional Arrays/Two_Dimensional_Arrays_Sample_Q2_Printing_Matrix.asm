.data
newline:.asciiz "\n"
space:.asciiz "\t"
msg_n:.asciiz "Enter the value of n(rows)"
msg_m:.asciiz "Enter the value of m(columns)"
msg:.asciiz "Enter next element(in row major form)"
mat1:.space 100
li $t3,0		#$t3 is used to access the index
li $t4,0 		#$t4 is used as the counter variable

print_loop:

# Checks the condition to exit the loop

beq $t4,$t2,ex_print

# value to be printed should be stored in $f12.

lwc1 $f12,mat1($t3)

#To print a floating point number.
li $v0,2
syscall

li $v0,4
la $a0,space
syscall

addi $t4,$t4,1	 #Incrementing the counter value by 1
addi $t3,$t3,4	 #Incrementing the index value by 4

	#To check if ‘m’ elements are printed,if true then 
	#print a newline
	
div $t4,$t1	 #Counter value/m 
mfhi $t6		 #Remainder is stored in hi register

#Check if remainder is 0
beq $t6,$zero,new

cont:
j print_loop

ex_print:
li $v0,10		 #Exit syscall
syscall

new:
li $v0,4		 #To print a newline
la $a0,newline
syscall
j cont
