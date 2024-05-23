# This program multiplies two numbers and displays the result.
# It shows how to pass multiple parameters to a function.

.data
    promptMessageX: .asciiz "Enter the first number (x): "
    promptMessageY: .asciiz "Enter the second number (y): "
    resultMessage: .asciiz "The result of x * y is: "

    numberX: .word 0  # First number
    numberY: .word 0  # Second number
    product: .word 0  # Result of the multiplication

.text
    .globl main
main:
    # Print input prompt for number X
    li $v0, 4
    la $a0, promptMessageX
    syscall
    
    # Read integer input for number X
    li $v0, 5
    syscall
    sw $v0, numberX
    
    # Print input prompt for number Y
    li $v0, 4
    la $a0, promptMessageY
    syscall
    
    # Read integer input for number Y
    li $v0, 5
    syscall
    sw $v0, numberY
    
    # Load the numbers into $a0 and $a1
    lw $a0, numberX
    lw $a1, numberY
    jal multiplyFunction  # Call the multiply function
    
    # Store the result in the 'product' variable
    sw $v0, product
    
    # Print result message
    li $v0, 4
    la $a0, resultMessage
    syscall
    
    # Print the product
    li $v0, 1
    lw $a0, product
    syscall
    
    # Exit the program
    li $v0, 10
    syscall

.globl multiplyFunction
multiplyFunction:
    mul $v0, $a0, $a1  # $v0 = $a0 * $a1
    jr $ra             # Return
