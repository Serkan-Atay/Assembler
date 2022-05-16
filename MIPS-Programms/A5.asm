	.data
strInsertA: .asciiz "\nInsert A: "
strInsertB: .asciiz "Insert B: "
strDivider: .asciiz "Divider (A, B): "

	
	.text	
	.globl main
main: 	#li $a0, 17		# a0 = 30
	#li $a1, 51		# a1 = 25
	la $a0, strInsertA	# strInsertA in a0
	li $v0, 4		# Syscall print_str
	syscall
	  
	li $v0, 5		# Syscall read_int in v0
	syscall
	move $t0, $v0
	
	
	la $a0, strInsertB	# strInsertA in a0
	li $v0, 4		# Syscall print_str
	syscall
	
	li $v0, 5		# Syscall read_int in v0
	syscall
	move $t1, $v0
	
	move $a0, $t0
	move $a1, $t1	
	jal divider
	move $t2, $v0
	
	la $a0, strDivider	# strInsertA in a0
	li $v0, 4		# Syscall print_str
	syscall

	move $a0, $t2
	li, $v0, 1
	syscall
	
	j exit
	
divider:	
	move $v0, $a1		# a1 -> v0
	
	beq $a0, $0, exit	# if a0 = 0 goto exit
loop:
	beq $a1, $0, write	# if a1 = 0 goto write
	slt $t0, $a1, $a0 	# if a1 < a0 -> t0 = 1
				# if a1 >= a0 -> t0 0
	bne $t0, $0, if		# if t1 != 0 goto if
	sub $a1, $a1, $a0	# a1 = a1 - a0
	j loop
if: 	sub $a0, $a0, $a1	# a0 = a0 - a1
	j loop	
	
write: 	move $v0, $a0
	jr $ra
	
exit:	j exit