# This program calculates the sum of the first n natural numbers. It prompts the user for a number n,
# computes the sum using recursion, and displays the result.

.data
    inputPromptMessage: .asciiz "Enter a number to find the sum of the first n natural numbers: "
    resultSumMessage: .asciiz "The sum of the first n natural numbers is: "
    
    number: .word 0 # Number input by the user
    sum: .word 0    # Result of the sum

.text
    .globl main
main:
    # Print input prompt message
    li $v0, 4              # System call code for print string
    la $a0, inputPromptMessage  # Load address of input prompt message
    syscall                # Make the system call to print the prompt
    
    # Read integer input
    li $v0, 5              # System call code for read integer
    syscall                # Make the system call to read integer
    sw $v0, number         # Store the input integer in 'number'
    
    # Call the sum function
    lw $a0, number         # Load the input number into $a0
    jal sumFunction        # Call the sum function to calculate the sum
    sw $v0, sum            # Store the result in the 'sum' variable
    
    # Print result message
    li $v0, 4              # System call code for print string
    la $a0, resultSumMessage  # Load address of the result message
    syscall                # Make the system call to print the result message
    
    # Print the sum
    li $v0, 1              # System call code for print integer
    lw $a0, sum            # Load the result from 'sum' into $a0
    syscall                # Make the system call to print the integer result
    
    # Exit the program
    li $v0, 10             # System call code for exit
    syscall                # Make the system call to terminate the program

.globl sumFunction
sumFunction:
    subu $sp, $sp, 8       # Make space on the stack for $ra and $s0
    sw $ra, 0($sp)         # Save return address on the stack
    sw $s0, 4($sp)         # Save $s0 on the stack
    
    # Base case: if n == 0, return 0
    beq $a0, $zero, sumBaseCase  # If input number (n) is 0, branch to sumBaseCase
    
    # Recursive case: sum(n) = n + sum(n-1)
    move $s0, $a0          # Save the input number (n) in $s0
    sub $a0, $a0, 1        # Decrement the input number (n) by 1
    jal sumFunction        # Recursive call to sumFunction with (n-1)
    add $v0, $v0, $s0      # Add n to the result of sum(n-1)
    
sumBaseCase:
    lw $ra, 0($sp)         # Restore return address from the stack
    lw $s0, 4($sp)         # Restore $s0 from the stack
    addu $sp, $sp, 8       # Restore stack pointer
    jr $ra                 # Return to the caller
