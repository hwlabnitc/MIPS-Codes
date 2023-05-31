# Program File: Tutorial1.asm
# Written by:   MoSaad
# Date Created: 10/05/2023
# Description:  Tutorial program to introduce MARS simulator  including: breakpoints, single-stepping, and register and memory windows.
#-----------------------------------------------------------
#-----------------------
# Declare some constants
#-----------------------
.data
string1: .asciiz "Welcome to Hardware Lab at NIT Calicut\n"
string2: .asciiz "Hello World \n"
string3: .asciiz "\nLoop #"
#------------------
# Main program body
#------------------
.text
main:
li $v0,4
la $a0,string1
syscall
la $a0,string2
syscall
li $t0, 1
loop:
li $v0, 4
la $a0,string3
syscall
li $v0,1
move $a0,$t0
syscall
addi $t0,$t0,1
bne  $t0,4,loop
#-----
# Halt 
#-----
li $v0, 10
syscall
