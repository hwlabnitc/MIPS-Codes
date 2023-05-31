.data
newline:.asciiz "\n"
space:.asciiz "\t"
msg_n:.asciiz "Enter the value of n(rows)"
msg_m:.asciiz "Enter the value of m(columns)"
msg:.asciiz "Enter next element(in row major form)"
mat1:.space 100
li $v0, 4		 #Ask user for the number of elements
la $a0, msg_n
syscall

li $v0, 5		 #Read the number of elements
syscall
move $t0, $v0	 #$t0 has value of n

li $v0, 4		 #Ask user for the number of elements
la $a0, msg_m
syscall

li $v0, 5		 #Read the number of elements
syscall
move $t1, $v0	 #$t1 has value of m

mul  $t2,$t0,$t1 #$t2 has n*m

li $t3,0 		 #$t3 is used as counter varible
li $t4,0 		 #$t4 is used to access the index value
inp1:

#Checks the condition to exit the loop

beq $t3,$t2,ex_inp1

li $v0,4
la $a0,msg
syscall

li $v0,6		 #Input for floating point number
syscall		 #$f0 has the val

#Store word call for floating point numbers

swc1 $f0,mat1($t4)

addi $t4,$t4,4	 #Incrementing the index value by 4
addi $t3,$t3,1	 #Incrementing the counter value by 1
j inp1

ex_inp1:
