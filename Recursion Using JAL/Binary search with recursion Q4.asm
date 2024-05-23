# This program reads a specified number of integers from the user, stores them on the stack, and sorts them. 
# It then prompts the user to enter an integer to search for within the stack and displays whether the integer exists in the sorted stack. 
# The program uses a recursive binary search function for efficient searching and handles invalid input sizes gracefully.

.data
numberOfInts:	.asciiz		"Number of Integers to Store: "
promptElement:	.asciiz		"\nEnter the integer to be found: "
promptInt:	.asciiz		"Enter Integer: "
printSort:	.asciiz		"Your Sorted Integers: "
invalidSize:	.asciiz		"\nYour Must Be Greater Than Zero.\n\n"
elementExists:	.asciiz		" exists in the stack.\n"
doesNotExist:	.asciiz		" does not exist in the stack.\n"
addspace:	.asciiz		" "
newLine:	.asciiz		"\n"
posInfinity:	.word		0x7FFFFFFF	

.text
.globl main

main:					# Program entry point

	li	$t0, 0			# Initialize counter i = 0

initializeNumInts:			# Start initializing number of integers
	li	$v0, 4
	la	$a0, numberOfInts
	syscall				# Print "Number of Integers to Store: "
	li	$v0, 5
	syscall				# Read number of integers
	
	ble	$v0, $0, reinitialize	# If number of integers <= 0, reinitialize
	
	move	$s0, $v0		# Store number of integers in $s0
	addi	$sp, $sp, -4		# Allocate space on the stack
	sw	$s0, 0($sp)		# Store array size at the bottom of the stack
	la	$a1, 0($sp)		# Store address of the bottom of the stack in $a1

insertToStack:			# Insert integers into the stack
	bge	$t0, $s0, findElement	# If counter >= number of integers, proceed to findElement
	
	li	$v0, 4			
	la	$a0, promptInt
	syscall				# Print "Enter Integer: "
	li	$v0, 5
	syscall				# Read integer

	jal	preSortStack		# Call preSortStack to sort and insert integer
	
	addi	$t0, $t0, 1		# Increment counter
	
	j	insertToStack		# Loop back to insertToStack

findElement:			# Find element in the stack
	li	$v0, 4			
	la	$a0, promptElement
	syscall				# Print "Enter the integer to be found: "
	li	$v0, 5
	syscall				# Read integer to be found
	
	move	$v1, $v0		# Store element to be found in $v1
	addi  	$a1, $a1, -4		# Set $a1 to the highest address (largest integer)
	la	$a2, 0($sp)		# Set $a2 to the lowest address (smallest integer)
	jal	search			# Call search function

	beq	$v0, $zero, elementDNE	# If $v0 == 0, element does not exist
	
	li	$v0, 1
	move	$a0, $v1
	syscall				# Print the element
	li	$v0, 4
	la	$a0, elementExists
	syscall				# Print " exists in the stack."
	j	terminate		# End the program

elementDNE:			# Element does not exist in the stack
	li	$v0, 1
	move	$a0, $v1
	syscall				# Print the element
	li	$v0, 4
	la	$a0, doesNotExist
	syscall				# Print " does not exist in the stack."
	
terminate:			# Terminate the program
	li 	$v0, 10
	syscall

reinitialize:			# Handle invalid size input
	li	$v0, 4
	la	$a0, invalidSize
	syscall				# Print "Your input must be greater than zero."
	j	initializeNumInts	# Restart initialization

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Sort Stack Procedure ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Adds elements into the stack from the stack pointer and then sorts them from least to greatest with the smallest element at the top of the stack.
# $a1 -- Address of the bottom of the stack.
# $a2 -- Value of the element to be pushed onto the stack.
preSortStack:
	move	$a2, $v0		# Place integer into argument $a2
	addi	$sp, $sp, -4		# Allocate space for incoming integer
	la	$s5, 0($sp)		# Track addresses in the stack
	sw	$a2, 0($sp)		# Push incoming integer onto the stack (first input)

sortStack:			# Sort the stack
	move	$s7, $s5		# $s7 tracks previous $s5 address
	addi	$s5, $s5, 4		# Move to address above $s5

	beq	$a1, $s5, exitSort	# If address above tracker is bottom of stack, exit sort
	
	lw	$s6, 0($s5)		# Get value at tracker
	bgt	$a2, $s6, swap		# If incoming integer > value below it, swap values
	
	sw	$a2, 0($sp)		# Push incoming integer onto stack if value above >= incoming integer
	
exitSort:
	jr	$ra			# Return from subroutine
	
swap:	
	move	$t1, $s6		# $t1 holds value at tracker
	sw	$a2, 0($s5)		# Store incoming integer at tracker
	sw	$t1, 0($s7)		# Store $t1 at top of stack
	move	$a2, $t1		# Set $a2 to $t1 for next iteration
	
	j	sortStack		# Go back to sorting the stack

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Does Stack Contain Procedure ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Traverses the stack to find an element.
# $a1 -- Address of the HIGH index of the stack.
# $a2 -- Address of the LOW index of the stack.
# $v1 -- The value of the element to be found.

search:				# Binary search for element in the stack
	ble	$a2, $a1, checkCases	# Check if low <= high
	li	$v0, 0			# If not, no portion of the stack exists
	jr	$ra			# Return 0

checkCases:			# Check mid element and decide next step
	addu	$t0, $a2, $a1	
	srl	$t0, $t0, 1		# mid = (low + high) / 2
	
	subu	$t1, $a1, $a2	
	sra	$t1, $t1, 2		# Number of elements = (high - low) / 4
	addi	$t1, $t1, 1		# Align to account for index 0
	
	andi	$t2, $t1, 1		# Check if number of elements is even
	beq	$t2, $zero, even	# If even, align by 2 bits
	j	saveValues
	
even:
	addiu	$t0, $t0, -2		# Align on word boundary, mid address -2

saveValues:
	lw	$t1, 0($t0)		# s[mid]
	
	addi	$sp, $sp, -12
	sw 	$ra, 8($sp)		# Save return address
	sw 	$a1, 4($sp)		# Save high index
	sw	$a2, 0($sp)		# Save low index
	
	beq	$t1, $v1, found		# If s[mid] == val, found element
	blt	$t1, $v1, lowerStack	# If s[mid] < val, search lower half
	j	upperStack		# Otherwise, search upper half

lowerStack:
	addi	$a2, $t0, 4		# Low = mid + 1
	jal	search			# Recursive search call
	j	checkIfFound		# Check if element was found
	
upperStack:
	addi	$a1, $t0, -4		# High = mid - 1
	jal	search			# Recursive search call
	
checkIfFound:			# Restore registers and return result
	lw	$a2, 0($sp)		# Restore low index
	lw	$a1, 4($sp)		# Restore high index
	lw 	$ra, 8($sp)		# Restore return address
	addi	$sp, $sp, 12		# Adjust stack pointer
	
	jr	$ra			# Return from subroutine

found:				# Element found in the stack
	li	$v0, 1			# Set return value to 1
	jr	$ra			# Return from subroutine
