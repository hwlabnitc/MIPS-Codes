#Q: To use Quicksort algorithm to sort an array.

#Main idea:Select a pivot element  and partition array into left and right halves 
#and recursively call quicksort on both the halves.
#To implement the recursive part, arguments/values corresponding to each recursive call #is stored in the stack.

.data 
array: .space 100
newline: .asciiz "\n"
msg: .asciiz "Enter the number of elements in array: "
msg1: .asciiz "Enter the element: " 
		

.text
.globl main

main:

li $v0, 4		# Ask user for the number of elements
la $a0, msg
syscall

# Read the number of elements

li $v0, 5
syscall
move $t0, $v0		#$t0 has value of n
addi $t9,$t0,0 		#$t9 also has value of n

# Read the elements and store them in the array

li $t1,0		#$t1 is the index
li $t2,0		#$t2 is the counter

loop:
beq $t0,$t2,ex		#Checks the loop break condition

li $v0,4
la $a0,msg1
syscall
li $v0,5
syscall
sw $v0,array($t1)
addi $t1,$t1,4
addi $t2,$t2,1
j loop

ex:

la $a0, array		#load the address of array into $a0
addi $a1, $zero, 0	#set $a1 to low
add $a2, $zero, $t9
addi $a2,$a2,-1 	# Set $a2 to (high = n-1, last index in array)
jal quicksort		#jump and link quicksort(function call)
	
#To print the sorted array

li $t1,0
li $t2,0

loop1:
beq $t9,$t2,ex1
li $v0,1
lw $a0,array($t1)
syscall
li $v0,4
la $a0,newline
syscall
addi $t1,$t1,4
addi $t2,$t2,1
j loop1
ex1:

#EXIT
li $v0, 10
syscall

swap:
addi $sp, $sp, -12		#Make stack for 3 elements
sw $a0, 0($sp)			#Store $a0
sw $a1, 4($sp)			#Store $a1
sw $a2, 8($sp)			#Store $a2
	
lw $t6, 0($a1)			#$t6=array[left]
lw $t7, 0($a2)			#$t7=array[right]
sw $t6, 0($a2)			#array[right]=$t6
sw $t7, 0($a1)			#array[left]=$t7
	
addi $sp,$sp,12			#restore stack
jr $ra				#return to $ra
	

partition:
addi $sp, $sp, -16
sw $a0, 0($sp)			#address of array
sw $a1, 4($sp)			#low
sw $a2, 8($sp)			#high
sw $ra, 12($sp)			#Return address
mul $t0, $a1, 4			#$t0 = 4*low
add $t1, $t0, $a0		#$t1 = address of array plus $t0
move $s0, $a1			#left = low
move $s1, $a2			#right = high
lw $s3, 0($t1)			#pivot =array[low]
lw $t3, 0($sp)			#$t3 = address of array


while:
bge $s0, $s1, end
while_1:
mul $t2, $s1, 4			#$t2= right *4
add $s6, $t2, $t3		#$s6= address of array + t2
lw $s4, 0($s6)			#$s4 = array[right]
ble $s4,$s3, end_1		#end while_1 if array[right]<= pivot
subi $s1,$s1,1			#right = right -1
j while_1
end_1:

while_2:
mul $t4, $s0, 4			#$t4 = left*4
add $s7, $t4, $t3		#$s7= $t4+array address
lw $s5, 0($s7)			#$s5=array[left]
bge $s0, $s1, end_2		#branch if left>=right to end_2
bgt $s5, $s3, end_2		#branch if aray[left]>pivot to end_2
addi $s0,$s0,1			#left = left+1
j while_2
end_2:
		
if:
bge $s0, $s1, end_if		#if left>=right branch to end_if
move $a0, $t3			#move $t3 to $a0
move $a1, $s7			#move updated left(s7) into $a1
move $a2, $s6			#move updated right(s6) into $a2
jal swap			#jump and link swap
			
end_if:
j while
		
end:	
	
lw $s5, 0($s7)				#set $s5 to array[left]
lw $s4, 0($s6)				#set $s4 to array[right]
sw $s4, 0($t1)				#array[low]=array[right]
sw $s3, 0($s6)				#array[right]=pivot
		
		
move $v0, $s1				#set $v0 to right
		
lw $ra 12($sp)				#restore $ra
addi $sp, $sp,16			#restore stack
jr $ra					#return to $ra
	
	
quicksort:				

addi $sp, $sp, -16		# Create stack for 4 elements

sw $a0, 0($sp)			#store address in stack
sw $a1, 4($sp)			#store low in stack	
sw $a2, 8($sp)			#store high in stack
sw $ra, 12($sp)			#store return address in stack




move $t0, $a2			#saving high in t0
	
checkCond:
slt $t1, $a1, $t0		# t1=1 if low < high, else 0
beq $t1, $zero, end_check	# if low >= high, endcheck

jal partition			# call partition 
move $s0, $v0			# pivot, $s0= v0
lw $a1, 4($sp)			#$a1 = low
addi $a2, $s0, -1		#$a2 = pi -1
jal quicksort			#call quicksort

addi $a1, $s0, 1		#$a1 = pi + 1
lw $a2, 8($sp)			#$a2 = high
jal quicksort			#call quicksort
		
end_check:
lw $a0, 0($sp)			#restore $a0
lw $a1, 4($sp)			#restore $a1
lw $a2, 8($sp)			#restore $a2
lw $ra 12($sp)			#load return adress into ra
addi $sp, $sp, 16		#restore stack
jr $ra				#return to $ra
