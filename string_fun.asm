	.eqv char1 1
	.eqv char2 4

	.data
start:		.asciiz "Bitte geben sie einen String ein >\n"
error_string: 	.asciiz "Der eingegebene String ist zu kurz!\n"
error_chars:	.asciiz "Der eingegebene string hat an stelle 1 und 5 unterschiedliche buchsatben!\n"
str:			.space 548
	.text

main:
	#print eingabe
	la $a0, start
	li $v0, 4
	syscall
	
	# read string
	li $v0, 8
	la $a0, str
	li $a1, 548
	syscall
	
	li $t0, 0		# initialize counter
	li $a1, 0		# initilaize char
	li $a2, 0		# initialuize cahr 2
	la $a0, str
	#lb $a1, ($a0)
loop: 
	lb $a1, ($a0)
	beq $a1, 0 , end_loop
	addi $a0, $a0, 1
	addi $t0, $t0, 1
	j loop
	
end_loop:
	subi $t0, $t0, 1 # sub for the \n in str
	bge $t0, 7, anz_ok	# breanch if str > 6
	la $a0, error_string	# print error
	li $v0, 4
	syscall
	j end
	
anz_ok: 
	la $a0, str
	li $a1, 0
	li $a2, 0
	
	lb $a1, char1($a0)
	lb $a2, char2($a0)
	
	beq $a1, $a2, end
	la $a0, error_chars
	li $v0, 4
	syscall
	
end:
	j main
	
	
