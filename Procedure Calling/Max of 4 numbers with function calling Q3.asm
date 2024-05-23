# This program finds the maximum of four numbers and displays the result.
# It shows how to pass multiple parameters to a function.

.data
    promptMessageA: .asciiz "Enter the first number (a): "
    promptMessageB: .asciiz "Enter the second number (b): "
    promptMessageC: .asciiz "Enter the third number (c): "
    promptMessageD: .asciiz "Enter the fourth number (d): "
    resultMessage: .asciiz "The maximum of the four numbers is: "

    numberA: .word 0  # First number
    numberB: .word 0  # Second number
    numberC: .word 0  # Third number
    numberD: .word 0  # Fourth number
    maximum: .word 0  # Result of finding the maximum

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
    
    # Print input prompt for number C
    li $v0, 4
    la $a0, promptMessageC
    syscall
    
    # Read integer input for number C
    li $v0, 5
    syscall
    sw $v0, numberC
    
    # Print input prompt for number D
    li $v0, 4
    la $a0, promptMessageD
    syscall
    
    # Read integer input for number D
    li $v0, 5
    syscall
    sw $v0, numberD
    
    # Load the numbers into $a0, $a1, $a2, and $a3
    lw $a0, numberA
    lw $a1, numberB
    lw $a2, numberC
    lw $a3, numberD
    jal maxFunction  # Call the max function
    
    # Store the result in the 'maximum' variable
    sw $v0, maximum
    
    # Print result message
    li $v0, 4
    la $a0, resultMessage
    syscall
    
    # Print the maximum
    li $v0, 1
    lw $a0, maximum
    syscall
    
    # Exit the program
    li $v0, 10
    syscall

.globl maxFunction
maxFunction:
    # Find the maximum of the first two numbers
    bgt $a0, $a1, isA0Greater
    move $t0, $a1
    j checkThird
isA0Greater:
    move $t0, $a0

checkThird:
    # Compare the current max with the third number
    bgt $t0, $a2, isT0Greater
    move $t0, $a2
    j checkFourth
isT0Greater:
    move $t0, $t0

checkFourth:
    # Compare the current max with the fourth number
    bgt $t0, $a3, isT0GreaterAgain
    move $v0, $a3
    jr $ra
isT0GreaterAgain:
    move $v0, $t0
    jr $ra
