# Altklausur 2017
# Aufgabe 3

	.data
str_out:		.asciiz "Zeichnekette (max. 126 Zeichen)> "
char_out:		.asciiz "Zeichen> "
str_return:	.asciiz "Anzahl der Ersetzungen: "
str_in:		.space 126
	.text
	
	li $v0, 4			# print eingabe str
	la $a0, str_out
	syscall
	
	li $v0, 8			# read eingabe
	la $a0, str_in		# in str_in
	li $a1, 126		# mit 126 zeichen max
	syscall
	
	li $v0, 4			# print eingabe char
	la $a0, char_out
	syscall
	
	li $v0, 12			# read cahr
	syscall
	
	li $a1, 0				# initzialisieren von reguister für char
	move $a1, $v0 		# char in register abspeiochern
	
	li $v0, 12			# print new_line
	li $a0, '\n'
	syscall
	
	la $a0, str_in			# str in $a0 für übergabe
	li $v0, 0				# inizialisieren von v0 für func
	
##################	
	jal chg_dupls			# jump in function
##################
	
	move $t0, $v0			# save return in $t0
	
	li $v0, 4				# print retuned str
	la $a0, str_in
	syscall
	
	li $v0, 4				# print " Anz ersetzung..." char
	la $a0, str_return
	syscall
	
	li $v0, 1				# print anz ersetzung int
	move $a0, $t0
	syscall
	
	li $v0, 10				# end of program
	syscall				#===========
	
	
	
	
chg_dupls:
	# str_in : 			$a0
	# char: 			$a1
	# char_from str:	$t0
	# char_from str2:	$t1
	# counter:		$v0
	lb $t0, ($a0)		# speichen von char in t0
	beq $t0, '\n', end	# beenden wenn string zuende
	bne $t0, $t1, no_chain	# ersezten der zeichen
	
	addi $v0, $v0, 1	# count cahin
	sb $a1, ($a0)		# change char in str to pre defined char
	
	
no_chain:
	move $t1, $t0		# store char1 für vergleich
	addi $a0, $a0, 1	# set address to next char
	j chg_dupls		# loop
end:
	jr $ra
	
	
	
	