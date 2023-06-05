# Given a floating point number and an integer n, round off the floating point number to n digits.

# Method- Multiplty then given number with 10^n, and round off using round.w.d instruction. Divide the result by 10^n to obtain the final result

.data
    # Constants used for calculation
    const1: .double 0.0
    const2: .double 1.0
    const3: .double 10.0
    
    # User prompts
    msg1: .asciiz "Enter the number : "
    msg2: .asciiz "Enter number of digits to round off to: "
    msg3: .asciiz "The rounded off number is: "
    
.text
.globl main
main:
    
    li $v0, 4			        	# Print msg1
    la $a0, msg1
    syscall
    
    li $v0, 7			        	# Read number to round off
    syscall
    
    mov.d $f12, $f0					# $f12 = user input
    
    li $v0, 4			        	# Print msg2
    la $a0, msg2
    syscall
    
    li $v0, 7			       		# Read n
    syscall
    
    mov.d $f16, $f0			    	# $f16 = n
    l.d $f4, const1					# $f4 used as a loop varibale initialised to 0
    l.d $f6, const2			    	# $f6 used to store 10^n
    l.d $f8, const3			    	# $f8 used to store 10 for calculating power
    l.d $f10, const2		    	# $f10 used to store 1 for incrementing loop variable
    
    loop1:							# Loop to compute 10^n
    
        c.eq.d $f4, $f16	    	# Ternminaltion Condition
        bc1t end_loop1
    
        mul.d $f6, $f6, $f8	        # $f6 = $f6 * 10
        add.d $f4, $f4, $f10		# $f4 = $f4 + 1
    
        j loop1
    
    end_loop1:
    
    mul.d $f12, $f12, $f6			# $f12 = $f12 * (10^n)
    round.w.d $f12, $f12			# $f12 is rounded to nearest integer
    cvt.d.w $f12, $f12		    	# Output after rounding, which is a word, is converted back to double
    div.d $f12, $f12, $f6			# $f12 = $f12 / (10^n)

    li $v0, 4			        	# Print msg3
    la $a0, msg3
    syscall	

    li $v0, 3			       		# Print final answer
    syscall
    
    li $v0, 10			        	# Exit
    syscall
    
