# Given an array of floating numbers of size n, print the maximum and minimum element

.data
    # Array
    .align 3
    arr: .space 1000
    
    # Characters
    newline: .asciiz "\n"

    # User Prompts
    msg1: .asciiz "Enter n: "
    msg2: .asciiz "Enter no. "
    msg3: .asciiz ": "
    msg4: .asciiz "The maximum no. is: "
    msg5: .asciiz "The minimum no. is: "

.text
.globl main
main:
    
    li $v0, 4			                # Print msg1
    la $a0, msg1
    syscall
    
    li $v0, 5			                # Read n
    syscall
    move $t0, $v0
    
    li $t1, 0			                # $t1 will be the loop variable going from 0,1,2..
    li $t2, 0			                # $t2 will be the element indices going from 0,8,16..
        
    loop1:				                # Loop to read n elements and store them in arr
    
        beq $t0, $t1, end_loop1	        # Termination condition
        
        li $v0, 4		                # Print msg2
        la $a0, msg2
        syscall
        
        li $v0, 1		                # Print position of number to be inputted
        move $a0, $t1
        addi $a0, $a0, 1
        syscall
        
        li $v0, 4		                # Print msg3
        la $a0, msg3
        syscall
        
        li $v0, 7						# Read input and store in arr
        syscall
        s.d $f0, arr($t2)
        
        addi $t1, $t1, 1				# Increamenting #t1 and $t2
        addi $t2, $t2, 8
        j loop1
    
    end_loop1:
    
    li $t1, 0							# Resetting $t1 and $t2
    li $t2, 0
    l.d $f4, arr($zero)					# $f4 will store the max value
    l.d $f6, arr($zero)					# $f6 will store the min value
    
    loop2:								# Loop to compute max and min
    
        beq $t0, $t1, end_loop2			# Termination Condition
        
        l.d $f8, arr($t2)				# Load a number from arr
        
        c.lt.d $f4, $f8					# Compare if the number is greater than current max
        bc1f not_max	
            mov.d $f4, $f8				# If yes then update new max
        not_max:
        
        c.lt.d $f8, $f6					# Compare if the number is less than current min
        bc1f not_min
            mov.d $f6, $f8				# If yes then update new min
        not_min:
        
        addi $t1, $t1, 1				# Incrementing $t1 and $t2
        addi $t2, $t2, 8
        j loop2
    
    end_loop2:
    
    li $v0, 4							# Print msg4
    la $a0, msg4
    syscall
    
    li $v0, 3							# Print max number
    mov.d $f12, $f4
    syscall
    
    li $v0, 4							# Print newline
    la $a0, newline
    syscall
    
    li $v0, 4							# Print msg5
    la $a0, msg5
    syscall
    
    li $v0, 3							# Print min number
    mov.d $f12, $f6
    syscall
    
    li $v0, 10							# Exit
    syscall