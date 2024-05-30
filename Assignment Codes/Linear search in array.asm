.data
    array:.space 40    
    string1:.asciiz "Enter the 10 Elements \n"
    string2:.asciiz "Enter the number you would like to search for \n"
    string3:.asciiz "Element found at index \n"
    string4:.asciiz "element is not found \n "
    

.text    
li $v0,4
la $a0,string1
syscall
    
jal build #building the array
    
la $a1, array               # Load array into $a0
li $a2, 9              # Load length into $a2
    
# Printing out the text
li $v0, 4
la $a0, string2
syscall
#Getting user input
li $v0, 5
syscall

add $a3,$v0,$0 #load the number to search for

li $t3,0


linearSearch:
  bgt $t3, $a2, notfound  # If $t0 > $a2, we are outside the array
  #bgt $t3, $a2, exit
  lw   $t1, 0($a1)              # Load the element into t1
  beq $t1, $a3, found   # Found the element
  addi $a1, $a1, 4            # Add 4 (1 word index) to the array
  addi $t3, $t3, 1            # Add one to the index
  j linearSearch
  
print:
	li $v0, 1
	move $a0, $t1
	syscall
	j linearSearch
    
found:
	li $v0, 4
	la $a0, string3
	syscall
	li $v0, 1
	move $a0, $t3
	syscall
	j exit
	
notfound:
	li $v0, 4
	la $a0, string4
	syscall
	j exit
	
build:        
    li $v0,5
    syscall
    beq $t0,36,halt
    sw $v0,array($t0)
    add $t0,$t0,4
    j build

halt:
    jr $ra
exit:
    li $v0,10
    syscall
