# This program calculates the factorial of a number iteratively.
# It shows how to pass a parameter to a function and handle more complex logic.

.data
    inputPromptMessage: .asciiz "Enter a number to calculate its factorial: "
    resultFactorialMessage: .asciiz "The factorial of the number is: "

    number: .word 0    # Number input by the user
    factorial: .word 0 # Result of the factorial calculation

.text
    .globl main
main:
    # Print input prompt message
    li $v0, 4
    la $a0, inputPromptMessage
    syscall
    
    # Read integer input
    li $v0, 5
    syscall
    sw $v0, number
    
    # Load the number into $a0 and call the factorial function
    lw $a0, number
    jal factorialFunction
    sw $v0, factorial  # Store the result in the 'factorial' variable
    
    # Print result message
    li $v0, 4
    la $a0, resultFactorialMessage
    syscall
    
    # Print the factorial result
    li $v0, 1
    lw $a0, factorial
    syscall
    
    # Exit the program
    li $v0, 10
    syscall

.globl factorialFunction
factorialFunction:
    li $v0, 1         # Initialize $v0 to 1 (0! = 1)
    li $t0, 1         # Initialize loop counter to 1
    
factorialLoop:
    bgt $t0, $a0, factorialEnd  # If counter > number, end loop
    mul $v0, $v0, $t0           # Multiply $v0 by counter
    addi $t0, $t0, 1            # Increment counter
    j factorialLoop             # Repeat loop
    
factorialEnd:
    jr $ra                     # Return
