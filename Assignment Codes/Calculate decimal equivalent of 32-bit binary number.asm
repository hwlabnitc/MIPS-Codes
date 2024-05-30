#Description: CALCULATING DECIMAL EQUIVALENT OF 32-BIT BINARY NUMBER

.data
string1: .asciiz  "Enter the number\n"
binary_number:  .space 33    # Space for 32 bits plus null terminator
space: .asciiz "\n"
#------------------
# Main program body
#------------------
.text
main:
# Printing out the text
li $v0, 4
la $a0, string1
syscall

# Read binary number from user input
li $v0, 8            # syscall code for reading a string
la $a0, binary_number   # load address of buffer
li $a1, 33           # maximum number of characters to read (32 bits + null terminator)
syscall

# Convert binary string to integer
    li $t0, 0            # initialize result
    li $t1, 0            # initialize counter for bit position
convert_loop_input:
    lb $t2, binary_number($t1)   # load byte from binary string
    beqz $t2, exit_convert_loop_input  # if null terminator, exit loop
    subi $t2, $t2, 48   # convert ASCII '0' or '1' to integer 0 or 1
    andi $t2, $t2, 1    # ensure the value is either 0 or 1
    sll $t0, $t0, 1     # shift result left by one bit
    or $t0, $t0, $t2    # combine current bit with result
    addi $t1, $t1, 1    # move to next character
    j convert_loop_input

exit_convert_loop_input:
# Print newline
    li $v0, 4            # syscall code for printing a string
    la $a0, space         # load address of newline character
    syscall

# Print the decimal number
li $v0, 1            # syscall code for printing a string
move $a0,$t0
syscall

li $v0, 10
syscall

