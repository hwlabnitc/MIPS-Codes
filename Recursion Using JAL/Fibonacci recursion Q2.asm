main:
    addi $a0, $zero, 10       # let the parameter n be 10
    jal fib                   # jump to fib label, i.e. calling F(10)
    j exit

fib:
    addi $sp, $sp, -8         # allocate 8 bytes to this stack
    sw $ra, 0($sp)            # save the address of the instruction that calls fib label (instruction address)
    sw $a0, 4($sp)            # save the value of n

    slti $t0, $a0, 2          # $t0 is used for conditions. If n < 2 then $t0 = 1, else $t0 = 0
    beq $t0, $zero, L1        # if $t0 == 0 then jump to branch L1
    add $v0, $v0, $a0         # let $v0 add n
    addi $sp, $sp, 8          # let $sp point to upper stack
    jr $ra                    # jump to the next line of the line calling fib

L1:
    addi $a0, $a0, -1         # n = n - 1
    jal fib                   # jump to fib label again, like as calling F(n - 1)
    addi $a0, $a0, -1         # n = n - 1
    jal fib                   # jump to fib label again, like as calling F(n - 2)
    lw $a0, 4($sp)            # recover the value of n
    lw $ra, 0($sp)            # recover instruction address
    addi, $sp, $sp, 8         # let $sp point to upper stack
    jr $ra                    # jump to the next line of the line calling L1
exit: