#DESCRIPTION - CHECKING IF A NUMBER IS PALINDROME OR NOT
.data
string1: .asciiz  "Enter the number\n"
string2: .asciiz  "IT IS A PALINDROME\n"
string3: .asciiz  "IT IS NOT A PALINDROME\n"
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
li $t3, 0 #stores the new number; basically the sum
li $t4 , 10


Loop:
  div $t0,$t4
  mfhi $t1  #remainder
  mflo $t0
  mul $t3,$t3,$t4
  add $t3,$t3,$t1
  ble $t0,$0,check
  j Loop


check:
  beq $t3,$v0,equal
  li $v0, 4
  la $a0,string3
  syscall
  j  halt
  
equal:
  li $v0, 4
  la $a0,string2
  syscall
  j  halt
  
halt:
  li $v0, 10
  syscall
