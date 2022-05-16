	.data
str_out:		.asciiz "Zeichenkette (max. 126 Zeichen)> "
str_return:	.asciiz "Geaenderte Zeichenkette 2: "
int_return:	.asciiz "Anzahl der Ersetzungen: "
str1: 		.space 128
str2:			.space 128
	
	.text
	
	la $a0, str_out		# print für die eingabe
	li $v0, 4
	syscall
	
	la $a0, str1		# laden des ersten eingabe str
	li $a1, 126		# max länge 126
	li $v0, 8			# laden des lese befehls str
	syscall
	
	
	la $a0, str_out		# print für die eingabe
	li $v0, 4
	syscall
	
	la $a0, str2		# laden des ersten eingabe str2
	li $a1, 126		# max länge 126
	li $v0, 8			# laden des lese befehls str
	syscall
	
	la $a0, str1		# übergabe von str1 in func
	la $a1, str2		# übergabe von str2 in func
	
	jal mark_prefix	# goto func

	move $t0, $v0		# save return in t0
	
	la $a0, str_return	# print return text
	li $v0, 4
	syscall
	la $a0, str2		# print verändertes str2
	syscall
#	li $a0, '\n'			# print new line
#	li $v0, 11
#	syscall
	la $a0, int_return	# print int return value
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	
	li $v0, 10			# beende programm
	syscall

#---------------------------------
#	a0: str1
#	a1: str2
mark_prefix:
	li $t2, '#'			# für einsetzten in str2
	li $v0, 0			#  initzialisieren von v0

loop_mark:
	lb $t0, ($a0)		# load char from pointer
	lb $t1, ($a1)		# load char from pointer
	bne $t0, $t1, end	# beenden wenn t0 != t1
	beq $t0, $zero, end	# beenden wenn str1 zuende
	beq $t1, $zero, end	# beenden wenn str2 zuende
	beq $t0, '\n', end	# beenden wenn str1 zuende
	beq $t1, '\n', end	# beenden wenn str2 zuende
	sb $t2, ($a1)		# ersetzten des chars in str2
	addi $a0, $a0, 1	# erhöhen des pointers von str1
	addi $a1, $a1, 1	# erhöhen des pointers von str1
	addi $v0, $v0, 1	# erhöhe counter für änderungen
	j loop_mark	
end:
	jr $ra
	
	
	