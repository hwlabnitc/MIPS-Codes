# This program prompts the user to enter an integer, calculates the factorial of the entered integer using a recursive function, and then displays the result. 
# It reads the input, calls the recursive factorial function, stores the result, and prints it. 
# The recursive function handles base and recursive cases, using the stack to store return addresses and local variables.

.data
     inputPromptMessageForInt: .asciiz "Enter a number to find its factorial: "
     resultFactorialMessage: 	.asciiz "The factorial of the input number is: "
     
     int: 			.word 0 #Number store from the user input | we will initials it to 0
     answer: 			.word 0 #return the factorial function
     
.text 
     .globl main 			
     main:

     #Print out the input message
     li $v0, 4
     la $a0, inputPromptMessageForInt
     syscall
     
     #read the int and store it in $v0
     li $v0, 5
     syscall
     
     #Put the sotre int in $v0 to global variable (int from .data)
     sw $v0, int 
     
     #Call the Factorial Function
     lw $a0, int   			#Our int value
     jal  factorialFunction 		#Jump and load to the factorial function to find the factorial of the int
     sw $v0, answer			#Return the variabel from factorial section to the $v0 and 
     					#store it into the global variel answer (in .data)
     
  
     #Display the factorial result 
     li $v0, 4
     la $a0, resultFactorialMessage
     syscall
     
     #display the result
     li $v0, 1
     lw $a0, answer
     syscall
     
     #Execute the program | End of the program
     li $v0, 10
     syscall
     
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Factorial Function ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
.globl factorialFunction 
factorialFunction: 

#It will be recursive function and will store the local variable and the return address to the stack
     subu $sp, $sp, 8 			#making space for two values to be stored.
     sw $ra, ($sp) 			#Store the value of the return address to the stack 
     					#which will be at location 0 of the stack.
     sw $s0, 4($sp) 			#Store the local variable to the second postion of the stack. 
     					#It will be store in the location 4 of the stack 
     					#since from first stack and second stack it is 4 bite apart.
     
     			#~~~~~~~~~~~~~~~~~~~~~~~~ Start the Recursion ~~~~~~~~~~~~~~~~~~~~~~~~~~~#
     #Base Case 
     #If the argument is equal to 0 we will return 1; 
     li $v0, 1				#After we go to finishFactorial we will return 1.
     beq $a0, 0, finishFactorial 	#If the argument is 0 we will go to finishFactorial.
     
     #If the argument != 0;
     move $s0, $a0 
     sub $a0, $a0, 1 			#Subtract one from the argument |  factorialFunction(int -1).
     jal factorialFunction 		#Call the factorial Function.
     					#Find the factorial which is resurcion.
     
     mul $v0, $s0, $v0 		#Whenever recursion is rewinding(when the function is returning), 
     					#this code will be executed. 
     					#We will get final answer from this line
     
     finishFactorial:
     	lw $ra, ($sp) 			#Restore the value of return address from the stack.
     					#Return address will be loaded from stack from random access memory.
     	lw $s0, 4($sp) 			#Loading the value of the local variable back to the register from the stack.
     					#Since the function is done, we are getting the value back from the stack.
     	addu $sp, $sp, 8 		#Restore the stack as well.
     					#Since in factorial function we substrack the stack becouse it was going 
     					#downword, here we are adding to put how it was before.
     	
     	jr $ra 				#Return from the function.
     	
