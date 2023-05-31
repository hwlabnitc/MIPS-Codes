#Q: To calculate the sum of two nXm matrices

# Main idea:To maintain a common index variable and compute the sum of 
# mat1[index]+mat2[index],where index varies from 0 to n*m(there are n*m elements in
# a  nXm matrix.

.data
newline:.asciiz "\n"
space:.asciiz "\t"
msg_n:.asciiz "Enter the value of n(rows)"
msg_m:.asciiz "Enter the value of m(columns)"
msg:.asciiz "Enter next element(in row major form)"
final:.asciiz "The sum of two matrices is:"
second:.asciiz "Input for second matrix:"
mat1:.space 100
mat2:.space 100

.text
.globl main

main:

li $v0, 4		# Ask user for the number of elements
la $a0, msg_n
syscall


li $v0, 5		# Read the number of elements
syscall
move $t0, $v0		#$t0 has value of n

li $v0, 4		# Ask user for the number of elements
la $a0, msg_m
syscall

li $v0, 5		# Read the number of elements
syscall
move $t1, $v0		#$t1 has value of m

mul  $t2,$t0,$t1	#$t2 has n*m(total number of elements)

li $t3,0		#$t3 maintains the counter variable
li $t4,0		#$t4 maintains the index variable

inp1:
beq $t3,$t2,ex_inp1    #Checks for loop break condition(loop needs to run for n*m times)

li $v0,4
la $a0,msg
syscall

li $v0,6		#$f0 stores the input value
syscall

swc1 $f0,mat1($t4)	#$f0(input value) is stored in respective memory adddress

addi $t4,$t4,4		# incrementing the index value
addi $t3,$t3,1		# incrementing the counter value
j inp1

ex_inp1:

li $v0,4
la $a0,second
syscall
li $v0,4
la $a0,newline
syscall

li $t3,0		#$t3 is the counter variable
li $t4,0		#$t4 is the index variable
inp2:
beq $t3,$t2,ex_inp2	#Checks for the loop break condition

li $v0,4
la $a0,msg
syscall

li $v0,6		#$f0 stores the input value
syscall

swc1 $f0,mat2($t4)

addi $t4,$t4,4
addi $t3,$t3,1
j inp2

ex_inp2:

li $t3,0		#index
li $t4,0		#counter
sum_loop:
beq $t4,$t2,ex_sum
lwc1 $f12,mat1($t3)
lwc1 $f11,mat2($t3)
add.s  $f12,$f12,$f11	#adding the elements and storing the sum in $f12

li $v0,2		#For float output,number is stored in $f12.
syscall

li $v0,4
la $a0,space
syscall

addi $t4,$t4,1
addi $t3,$t3,4

#Check if 'm' elements have been printed,if true then newline needs to be printed.

div $t4,$t1		
mfhi $t6		#Remainder of division is stored in hi register.
beq $t6,$zero,new	#Check if remainder is zero.
cont:
j sum_loop

ex_sum:
li $v0,10		# Exit system call
syscall

new:
li $v0,4
la $a0,newline
syscall
j cont
