#Description: Check if a positive number is odd or even

.data
string1: .asciiz  "Enter the number\n"
string2: .asciiz "Number is even \n"
string3: .asciiz "Number is odd \n"
string4: .asciiz "Number is negative \n"
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

blt $v0,0,negative #check is number is positive

li $s3, 2

div $v0,$s3
mfhi $s2

bne $s2,0,odd #if remainder not equal to 0

li $v0, 4
la $a0,string2
syscall
j  halt #if remainder equal to 0

odd:
li $v0, 4
la $a0,string3
syscall
j  halt

negative:
li $v0, 4
la $a0,string4
syscall
j  halt

halt:
li $v0, 10
syscall