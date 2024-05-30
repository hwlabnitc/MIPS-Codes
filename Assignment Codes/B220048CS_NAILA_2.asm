#DESCRIPTION - CALCULATE FACTORIAL OF A NUMBER
.data
string1: .asciiz  "Enter the number\n"
#------------------
# Main program body
#------------------
.text
main:
# Printing out the text
li $v0, 4
la $a0, string1
syscall

#Getting user input
li $v0, 5
syscall

li $s3, 1 #stores the number to be multiplied
li $s1, 1 #stores product

Loop:
   bgt $s3,$v0,halt
   mul $s1,$s3,$s1
   addi $s3,$s3,1
   j Loop


halt:
move $t0, $s1

# Printing out the number
li $v0, 1
move $a0, $t0
syscall
li $v0, 10
syscall