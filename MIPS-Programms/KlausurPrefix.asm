.data
str0: .space 32
str1: .space 32

prompt_a: .asciiz "String 1 >" 
prompt_b: .asciiz "String 2 >" 

.text
main:
	la $a0, prompt_a
	li $v0, 4
	syscall
	
	li $v0, 8
	la $a0, str0
	li $a1, 32
	syscall
	
	move $t0, $a0 	# Adresse von String 1 in t0
		
	la $a0, prompt_b
	li $v0, 4
	syscall
	
	li $v0, 8
	la $a0, str1
	li $a1, 32
	syscall
	
	move $t1, $a0 	# Adresse von String 2 in t1
	
	j prefix
	
prefix: 
	lb $t2, ($t0)
	lb $t3, ($t1)
	beqz $t2, prefixexit
	beqz $t3, prefixexit
	beq $t2, $t3, same
	same:
		add $t0, $t0, 1 # inc adresse 1
		add $t1, $t1, 1 # inc adresse 2
		add $t4, $t4, 1 # Counter Same Char
		
	j prefix
	prefixexit: 
	jr $ra

	

exit:
	li $v0, 10
	syscall
	