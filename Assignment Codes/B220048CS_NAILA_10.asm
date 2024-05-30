#DESCRIPTION - TO FIND THE SUM OF A AND B; B IS THE 2's COMPLEMENT OF A
.data
string1: .asciiz  "Enter the number A\n"
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

add $t0,$v0,$0

not $t1,$t0

addi $t3,$t1,1

add $t0,$t0,$t3

# Printing out the number
li $v0, 1
move $a0, $t0
syscall
li $v0, 10
syscall