# This program calculates x^y using recursion. It prompts the user for a base (x) and an exponent (y), computes the power, and displays the result. 
# The recursive function handles base cases for y=0 and y=1, and recursively multiplies x for other cases.

.data
    inputPromptMessageX: .asciiz "Enter the base number (x): "
    inputPromptMessageY: .asciiz "Enter the exponent (y): "
    resultPowerMessage: .asciiz "The result of x^y is: "
    
    base: .word 0        # Base number x input by the user
    exponent: .word 0    # Exponent y input by the user
    power: .word 0       # Result of x^y

.text
    .globl main
main:
    # Print input prompt for base x
    li $v0, 4              # System call code for print string
    la $a0, inputPromptMessageX  # Load address of input prompt message for x
    syscall                # Make the system call to print the prompt
    
    # Read integer input for base x
    li $v0, 5              # System call code for read integer
    syscall                # Make the system call to read integer
    sw $v0, base           # Store the input integer in 'base'
    
    # Print input prompt for exponent y
    li $v0, 4              # System call code for print string
    la $a0, inputPromptMessageY  # Load address of input prompt message for y
    syscall                # Make the system call to print the prompt
    
    # Read integer input for exponent y
    li $v0, 5              # System call code for read integer
    syscall                # Make the system call to read integer
    sw $v0, exponent       # Store the input integer in 'exponent'
    
    # Load base and exponent into $a0 and $a1
    lw $a0, base           # Load base (x) into $a0
    lw $a1, exponent       # Load exponent (y) into $a1
    jal powerFunction      # Call the power function to calculate x^y
    
    # Store the result in the 'power' variable
    sw $v0, power          # Store the result from $v0 into 'power'
    
    # Print result message
    li $v0, 4              # System call code for print string
    la $a0, resultPowerMessage  # Load address of the result message
    syscall                # Make the system call to print the result message
    
    # Print the power result
    li $v0, 1              # System call code for print integer
    lw $a0, power          # Load the result from 'power' into $a0
    syscall                # Make the system call to print the integer result
    
    # Exit the program
    li $v0, 10             # System call code for exit
    syscall                # Make the system call to terminate the program

.globl powerFunction
powerFunction:
    subu $sp, $sp, 8       # Make space on the stack for $ra and $s0
    sw $ra, 0($sp)         # Save return address on the stack
    sw $s0, 4($sp)         # Save $s0 on the stack
    
    # Base case: if y == 0, return 1
    li $t0, 0              # Load immediate 0 into $t0
    beq $a1, $t0, powerBaseCase  # If exponent (y) is 0, branch to powerBaseCase
    
    # Base case: if y == 1, return x
    li $t0, 1              # Load immediate 1 into $t0
    beq $a1, $t0, powerBaseX  # If exponent (y) is 1, branch to powerBaseX
    
    # Recursive case: power(x, y) = x * power(x, y-1)
    move $s0, $a1          # Save the exponent (y) in $s0
    sub $a1, $a1, 1        # Decrement the exponent by 1
    jal powerFunction      # Recursive call to powerFunction with (x, y-1)
    mul $v0, $v0, $a0      # Multiply x (in $a0) with the result of power(x, y-1)
    j powerEnd             # Jump to the end of the function
    
powerBaseCase:
    li $v0, 1              # If y == 0, return 1 in $v0
    j powerEnd             # Jump to the end of the function
    
powerBaseX:
    move $v0, $a0          # If y == 1, return x in $v0
    j powerEnd             # Jump to the end of the function
    
powerEnd:
    lw $ra, 0($sp)         # Restore return address from the stack
    lw $s0, 4($sp)         # Restore $s0 from the stack
    addu $sp, $sp, 8       # Restore stack pointer
    jr $ra                 # Return to the caller
