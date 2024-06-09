# This program adds two numbers and displays the result.
# It shows how to pass multiple parameters to a function.

.data
    promptMessageA: .asciiz "Enter the first number (a): "
    promptMessageB: .asciiz "Enter the second number (b): "
    resultMessage: .asciiz "The result of a + b is: "

    numberA: .word 0  # First number
    numberB: .word 0  # Second number
    sum: .word 0      # Result of the addition

.text
    .globl main
main:
    # Print input prompt for number A
    li $v0, 4
    la $a0, promptMessageA
    syscall
    
    # Read integer input for number A
    li $v0, 5
    syscall
    sw $v0, numberA
    
    # Print input prompt for number B
    li $v0, 4
    la $a0, promptMessageB
    syscall
    
    # Read integer input for number B
    li $v0, 5
    syscall
    sw $v0, numberB
    
    # Load the numbers into $a0 and $a1
    lw $a0, numberA
    lw $a1, numberB
    jal addFunction  # Call the add function
    
    # Store the result in the 'sum' variable
    sw $v0, sum
    
    # Print result message
    li $v0, 4
    la $a0, resultMessage
    syscall
    
    # Print the sum
    li $v0, 1
    lw $a0, sum
    syscall
    
    # Exit the program
    li $v0, 10
    syscall

.globl addFunction
addFunction:
    add $v0, $a0, $a1  # $v0 = $a0 + $a1
    jr $ra             # Return
