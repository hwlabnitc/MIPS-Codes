# To input 2 strings and concatenate the second one to the first

.globl main
main:

li $v0,4
la $a0,msg1
syscall

li $v0,8
la $a0,str1
la $a1,100
syscall

li $v0,4
la $a0,msg2
syscall

li $v0,8
la $a0,str2
la $a1,100
syscall

li $s1,0
loop1:
lb $t1,str1($s1)
beq $t1,10,loop1_exit
addi $s1,$s1,1
j loop1

loop1_exit:
li $s2,0

loop2:
lb $t1,str2($s2)
beqz $t1,end
sb $t1,str1($s1)
addi $s1,$s1,1
addi $s2,$s2,1
j loop2

end:

li $v0,4
la $a0,msg3
syscall
li $v0,4
la $a0,str1
syscall

li $v0,10
syscall



.data:

str1: .space 100
str2: .space 100
msg1: .asciiz "Enter string1:"
msg2: .asciiz "Enter string2: "
msg3: .asciiz "Final string1: "
