.data
	name: .space 20
	message1:.asciiz "enter name:"
	message2:.asciiz "enter marks of subject:"
	message3:.asciiz "\ncongratulations "
	message4: .asciiz "your average is:"

.text
.globl main
main:

	li $v0,4
	la $a0,message1
	syscall
	
	li $v0,8
	la $a0,name
	li $a1,20
	syscall
	
	li $t0,0
	li $t1,5
	li $t2,0
loop:
	beq $t0,$t1,endloop
	
	li $v0,4
	la $a0,message2
	syscall
	
	li $v0,5
	syscall
	
	add $t2,$t2,$v0
	addi $t0,$t0,1
	
	j loop
	
endloop:
	div $t2,$t1
	mflo $t3
	
	li $v0,4
	la $a0,message3
	syscall
	
	li $v0,4
	la $a0,name
	syscall
	
	li $v0,4
	la $a0,message4
	syscall
	
	li $v0,1
	move $a0,$t3
	syscall

exit:
	li $v0,10
	syscall
	
