#Description: CASE SWITCHING OF STRING

.data
string1: .asciiz  "Enter the string\n"
sentence:  .space 80    # Space for 32 bits plus null terminator
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

# Read string from user input
li $v0, 8            # syscall code for reading a string
la $a0, sentence   # load address of buffer
li $a1, 80           # maximum number of characters to read (32 bits + null terminator)
syscall

li $t0 , 0

loop:
    lb $t1, sentence($t0)
    beq $t1, 0, exit
    blt $t1, 'a', uppercase
    sub $t1, $t1, 32
    sb $t1, sentence($t0)
    addi $t0, $t0, 1
    j loop

uppercase: 
    blt $t1, 'A' , special
    addi $t1, $t1, 32
    sb $t1, sentence($t0)
    addi $t0, $t0, 1
    j loop
    
special:
    addi $t0, $t0, 1
    j loop

exit:
    li $v0, 4       #printing the case switched string
    la $a0, sentence
    syscall

    li $v0, 10
    syscall
