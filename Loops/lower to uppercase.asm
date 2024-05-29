#Convert the letters of a given string to uppercase keeping other ascii characters same.

.data
    string:     .space 100
    prompt:     .asciiz "Enter string: "
    output:     .asciiz "ans:- "

.text
.globl main

main:
    li $v0, 4                      
    la $a0, prompt                 
    syscall

    li $v0, 8                     
    la $a0, string                 
    li $a1, 100                  
    syscall

    la $t0, string                 

convert_loop:
    lb $t1, 0($t0)                 
    beq $t1, $zero, end_convert    

    li $t2, 97                     # ASCII value for 'a'
    li $t3, 122                    # ASCII value for 'z'
    blt $t1, $t2, not_lowercase    # if character < 'a', not lowercase
    bgt $t1, $t3, not_lowercase    # if character > 'z', not lowercase

    li $t4, 32                     # ASCII difference b/w lowercase and uppercase
    sub $t1, $t1, $t4              
    sb $t1, 0($t0)                

not_lowercase:
    addi $t0, $t0, 1               # move to the next character, i++
    j convert_loop                 # repeat the loop

end_convert:
    li $v0, 4                      
    la $a0, output                 
    syscall

    li $v0, 4                     
    la $a0, string                
    syscall

    li $v0, 10                     
    syscall

#for (int i = 0; string[i] != '\0'; i++) {
#    if (string[i] >= 'a' && string[i] <= 'z') {
#        string[i] = string[i] - 32;
#    }
#}