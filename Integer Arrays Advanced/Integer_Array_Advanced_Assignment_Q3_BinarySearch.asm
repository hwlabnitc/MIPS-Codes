#Q:A given sorted array, we need to search for a given element

#Main idea:We check if the middle element is the required element,if not then based on #whether array[mid] is greater or less than required we can search in left half or right 
#half respectively

.data
array:	.space 100
newline: .asciiz "\n"
msg: .asciiz "Enter the number of elements in array: "
msg1: .asciiz "Enter the element: " 
msg2: .asciiz "Enter the element to be searched for:"
absentmsg: .asciiz " was not found."
presentmsg: .asciiz " was found."

.text
.globl	main

main:

li $v0, 4		# Ask user for the number of elements
la $a0, msg
syscall

li $v0, 5		# Read the number of elements
syscall
move $t0, $v0		#$t0 has value of n
move $s6,$t0		#n is stored in $s6 also as it is a save register

# Read the elements and store them in the array
li $t1,0		#$t1 is index
li $t2,0		#$t2 is counter


loop:
beq $t0,$t2,ex
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

#Take input for element to be searched for

li $v0,4
la $a0,msg2
syscall
li $v0,5
syscall
move $s7,$v0		#$s7 has the element to be searched for

#a0 and a1 are arguments for binsearch

la $a0,array		# Load address of array
move $a1, $s7		# Load target value
		
jal binsearch		#function call	
		
#$s1 has the answer from binsearh,0 if element not found and 1 if element was found

addi $a2, $s1, 0	#$s1 is passed as argument through $a2 to print final message
jal message		
		
#EXIT

li $v0, 10
syscall	
		
binsearch:
addi $t1, $zero, 0	# Store 0 in register for start value
addi $t2, $s6,-1	# Store len-1 in $t2
#$s6 also has value of n
		
loop1:		
				
bgt $t1, $t2, endloop	# if start>end
		
add $t4, $t2, $t1	# (end + start)
div $t5, $t4, 2		# (end + start) / 2
	
mul $t7, $t5, 4		# Multiply mid by word length to use as offset
						
add $t6, $a0, $t7	# array[mid] 
lw  $t6, 0($t6)		# Load value from array[mid]
		
bgt $a1, $t6, start	# if (target > array[mid]) jump to start
beq $a1, $t6, found	# if (target = array[mid]) jump to found
		
#target<arr[mid]
addi $t2, $t5,-1	# end = mid-1
j  loop1
		
start:
add $t1,$t5,1		# start = mid+1
j loop1
		
endloop:	

addi $s1, $zero, 0 	# Store 0 in register $s1, indicating absence of target value
j finish
		
found:
addi $s1, $zero, 1 	# Store 1 in register $s1, indicating presence of target value
j finish

finish:	
jr $ra			#Returns to function call

message:	
li $v0, 1
add $a0, $a1, 0	 	# Print target number
syscall
				
bne $a2,$zero,present  #Check register $a2 for presence of 0 
		
absent:		
li $v0, 4
la $a0, absentmsg	# Output message indicating absence of number
syscall		
j end

present:
li $v0, 4
la $a0, presentmsg	# Output message indicating presence of number
syscall
			
end:
jr $ra			#Returns to the function call
