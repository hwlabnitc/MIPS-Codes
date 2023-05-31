#Q:Enter two digit numbers to an array of length ‘n’,
#a) identify the number which is having highest occurrence
#b) identify the number which is having lowest occurrence

# Main idea: A frequency table is made to calculate the min and max frequency value, 
#then the input array is traversed to find which element has the min/max frequency.

.data
arr: .space 100
table: .space 804	#(0-100),(-1 to -100) Total 201 elements

msg: .asciiz "Enter the number of elements in arr: "
msg2: .asciiz "Enter the element: "
space: .asciiz " "
newline: .asciiz "\n"
msg_min: .asciiz " is having lowest freq"
msg_max: .asciiz " is having highest freq"

.text
.globl main

main:

li $v0, 4		# Ask user for the number of elements
la $a0, msg
syscall

li $v0, 5		# Read the number of elements
syscall
move $t0, $v0		#$t0 has value of n



# Read the elements and store them in the array

li $t1, 0		#$t1 is the index variable 
li $t2,0		#$t2 is counter

read_array:

beq $t0, $t2, exit1	#Checks for loop break condition

li $v0, 4
la $a0, msg2
syscall

li $v0, 5
syscall
sw $v0, arr($t1)	#Storing the input in the array
addi $t1, $t1, 4	#Incrementing the index variable
addi $t2,$t2,1		#Incrementing the counter variable
j read_array

exit1:

#Initialising table to frequency of 0

li $t1,0  		#index
li $t2,0  		#counter
li $t3,201
loop_t:

beq $t2,$t3,exit_loop	#Checks for loop break condition

sw $zero,table($t1)	#To store 0 in the table
addi $t1,$t1,4		#Incrementing the index variable
addi $t2,$t2,1		#Incrementing the counter variable
j loop_t

exit_loop:

#Traversing the array and updating the frequency table

li $t1,0		#index
li $t2,0		#counter
loop_arr:
beq $t0,$t2,exit_arr
lw $t3,arr($t1)

#Checks if the element is negative,if true then $t3=(-$t3)+100
#Frequncy of 0-100 is stored in index values 0-100 however for -1 to -100 ,their freq
#values are stored in index values 101-201

bge $zero,$t3,update

cont:
#Multiply $t3 with 4 and update freq table
#Multiple ways to do this-shift right-2 times,multiply and use move from.

addi $t4,$zero,4
mul $t3,$t3,$t4

#Updating the frequency table

lw $t5,table($t3)
addi $t5,$t5,1
sw $t5,table($t3)
addi $t2,$t2,1	
addi $t1,$t1,4
j loop_arr


#iterate through table to find max and min

exit_arr:
li $t1,0		#index
li $t2,0		#counter
li $t5,201
li $t3,10		#min freq value(arbitrary-10)
li $t4,0		#max freq value

loop_table:
beq $t2,$t5,ex_loop_table
lw $t7,table($t1)
bgt $t7,$t4,update_max	#Updates the max($t4) if $t7>$t4
cont_1:
bgt $t3,$t7,update_min	#Updates the min($t3) if $t7<$t3
cont_2:
addi $t2,$t2,1
addi $t1,$t1,4
j loop_table


#$t3-min,$t4-max

#Traverse the array to check which element has the min/max freq value

ex_loop_table:
li $t1,0
li $t2,0
lo:
beq $t2,$t0,ex_lo
lw $t5,arr($t1)
move $t7,$t5		#value to be printed is stored in $t7
bgt $zero,$t5,change	#If $t5<0 then $t5=(-$t5)+100

cont_3:
addi $t6,$zero,4
mul $t5,$t5,$t6		#$t5=$t5*4
lw $t8,table($t5)

#Checks if it has min freq value,if true the value is printed and search continues for #max freq element 

beq $t8,$t3,check_max

#Checks if it has max freq value,if true the value is printed and search continues for #min freq element 
 	
beq $t8,$t4,check_min

addi $t1,$t1,4
addi $t2,$t2,1
j lo

check_max:
li $v0,1		#$t7 has the element with min freq,it is printed
move $a0,$t7
syscall
li $v0,4
la $a0,msg_min
syscall

li $v0,4
la $a0,newline
syscall

#Search continues for element with max frequency

loop_maxi:
beq $t2,$t0,ex_lo
lw $t5,arr($t1)
move $t7,$t5  #print t7
bgt $zero,$t5,change1
cont_4:
addi $t6,$zero,4
mul $t5,$t5,$t6
lw $t8,table($t5)
beq $t8,$t4,pr_max
addi $t1,$t1,4
addi $t2,$t2,1
j loop_maxi


check_min:
li $v0,1		#$t7 has the element with max freq,it is printed
move $a0,$t7
syscall
li $v0,4
la $a0,msg_max
syscall
li $v0,4
la $a0,newline
syscall

#Search continues for element with min frequency

loop_mini:
beq $t2,$t0,ex_lo
lw $t5,arr($t1)
move $t7,$t5  #print t7
bgt $zero,$t5,change2
cont_5:
addi $t6,$zero,4
mul $t5,$t5,$t6
lw $t8,table($t5)
beq $t8,$t3,pr_min
addi $t1,$t1,4
addi $t2,$t2,1
j loop_mini

#To print the max freq element

pr_max:
li $v0,1
move $a0,$t7
syscall
li $v0,4
la $a0,msg_max
syscall
li $v0,4
la $a0,newline
syscall
j ex_lo

#To print the min freq element

pr_min:
li $v0,1
move $a0,$t7
syscall
li $v0,4
la $a0,msg_min
syscall
li $v0,4
la $a0,newline
syscall
j ex_lo

#$t5=(0-$t5)+100
change:
sub $t5,$zero,$t5
addi $t5,$t5,100
j cont_3

change1:
sub $t5,$zero,$t5
addi $t5,$t5,100
j cont_4

change2:
sub $t5,$zero,$t5
addi $t5,$t5,100
j cont_5

#exit syscall
ex_lo:
li $v0,10
syscall



update:
sub $t3,$zero,$t3 
#t3=0-t3
addi $t3,$t3,100
j cont

update_max:
move $t4,$t7
j cont_1

update_min:


beq $t7,$zero,cont_2
move $t3,$t7
j cont_2

