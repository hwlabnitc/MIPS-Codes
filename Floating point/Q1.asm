#   Given a temperature in Fahrenheit, convert it into Celsius
#
#   Temperature in degrees Celsius = (Temperature in degrees Fahrenheit - 32) * 5/9.

.data
    # Constants used for calculation
    const1: .double 32.0
    const2: .double 5.0
    const3: .double 9.0
    
    # User prompts
    msg1: .asciiz "Enter the temperature in Fahrenheit: "
    msg2: .asciiz "The temperature in Celsius is: "

.text
.globl main
main:

    li $v0, 4			            # Printing msg1
    la $a0, msg1
    syscall
    
    li $v0, 7			            # Reading user input
    syscall
    
    mov.d $f12, $f0			        # $f12 = User Input
    
    l.d $f14, const1		        # $f12 = $f12-32
    sub.d $f12, $f12, $f14
    
    l.d $f14, const2		        # $f12 = $f12*5
    mul.d $f12, $f12, $f14
    
    l.d $f14, const3				# $f12 = $f12/9
    div.d $f12, $f12, $f14
    
    li $v0, 4						# Printing msg2
    la $a0, msg2
    syscall
    
    li $v0, 3						# Printing final answer
    syscall
    
    li $v0, 10						# Exit
    syscall
