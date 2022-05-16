	.data
hm:	.asciiz "Hallo"		# saves Hello in the first datasegment

	
	.text
	addi $8, $8, 1
	la $16, hm
	
	jal kill
	
	li $2, 10
	syscall
	
	
kill:
	addi $29, $29, -4	# ,ove next stack-step
	sw $31, ($29)		# store address
	
	move $4, $8
	li $2, 1
	syscall
	
	jal kill2 

	lw $31, ($29)		# load address
	sw $0, ($29) 
	addi $29,$29, 4	# set stack back 
	jr $31


kill2:
	
	move $4, $16
	li $2, 4
	syscall
	
	jr $31
