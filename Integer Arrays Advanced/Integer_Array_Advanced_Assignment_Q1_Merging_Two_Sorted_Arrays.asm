#Q:Given two sorted two-digit integer arrays of sizes n and m, write a program to
#merge them into a new sorted array of size n+m.

#Main idea:Two pointers are maintained, one for each array and at each step comparision #is done to find which element is smaller and the process continues.

.data
array1: .space 64
array2: .space 64

msg: .asciiz "Enter the number of elements in array1: "
msg1: .asciiz "Enter the number of elements in array2: "
msg2: .asciiz "Enter the element: "
space: .asciiz " "
newline: .asciiz "\n"

.text
.globl main

main:

#t0-n,t3-m
li $v0, 4		# Ask user for the number of elements
la $a0, msg
syscall

li $v0, 5		# Read the number of elements
syscall
move $t0, $v0		#t0 has value of n

# Read the elements and store them in the array

li $t1, 0		#$t1 is the index variable
li $t2,0		#$t2 is the counter variable

read_array1:

beq $t0, $t2, exit1	#Checks for loop break condition

li $v0, 4		# Ask user for the elements
la $a0, msg2
syscall

li $v0, 5
syscall
sw $v0, array1($t1)
addi $t1, $t1, 4	#Incrementing the index variable
addi $t2,$t2,1		#Incrementing the counter variable
j read_array1

exit1:

li $v0, 4		# Ask user for the number of elements
la $a0, msg1
syscall

li $v0, 5		# Read the number of elements
syscall
move $t3, $v0		#$t3 has value of m


li $t1, 0 
li $t2,0

read_array2:
beq $t3, $t2, exit2	#Checks for loop break condition

li $v0, 4		# Ask user for the elements
la $a0, msg2
syscall

li $v0, 5
syscall
sw $v0, array2($t1)
addi $t1, $t1, 4
addi $t2,$t2,1
j read_array2

exit2:

#Maintain two counters each for array1 and array2

#$t1-index1,$t2-index2
#$t0-n,$t3-m
#$t4-count1,$t5-count2

li $t1,0
li $t2,0
li $t4,0
li $t5,0

loop1:
beq $t4,$t0,exit	#Checkes if array1 is fully traversed
beq $t5,$t3,exit	#Checkes if array2 is fully traversed
lw $t6,array1($t1)
lw $t7,array2($t2)

#Comparision betweeen the elements(checks if array1[$t1]>=array2[$t2]

bge $t6,$t7,label2	
j label1
cont:
j loop1

#exit is enetered when either of the array is completely traversed.
#The remaining array needs to be printed as it is.

exit:

beq $t4,$t0,exit_2	#Check which array is left and exit
loop_a1:
beq $t4,$t0,exit_final
li $v0, 1
lw $a0,array1($t1)
syscall

li $v0, 4
la $a0, newline
syscall

addi $t1,$t1,4
addi $t4,$t4,1
j loop_a1

exit_2:
loop_a2:
beq $t5,$t3,exit_final
li $v0, 1
lw $a0,array2($t2)
syscall
li $v0, 4
la $a0, newline
syscall
addi $t2,$t2,4
addi $t5,$t5,1
j loop_a2

exit_final:
li $v0, 10
syscall


#to print elements of array2
label2:

li $v0, 1
lw $a0,array2($t2)
syscall
li $v0, 4
la $a0, newline
syscall
addi $t2,$t2,4
addi $t5,$t5,1
j cont

#to print elements of array1
label1:
li $v0, 1
lw $a0,array1($t1)
syscall
li $v0, 4
la $a0, newline
syscall
addi $t1,$t1,4
addi $t4,$t4,1
j cont

