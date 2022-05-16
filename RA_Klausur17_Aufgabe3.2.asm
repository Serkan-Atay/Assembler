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
	jal s_and_c		# jump in function
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
	
	
#------------------------------------------------------
s_and_c:
	# str_in : 			$a0
	# char: 			$a1
	addi $sp, $sp, -12
	sw $a0, 0($sp)
	sw $a1, 4($sp)	# 4sp:	char
	sw $ra, 8($sp)		# 8sp:	$ra

	jal sort
	move $a0, $v0		# return aus sort in next_func übergeben
	lw $a0, 0($sp)
	lw $a1, 4($sp)		# wiederherstellen  von char ($a1)

	li $t0, 0			# bereitstellung für next_func
	li $t1, 0			# bereitstellung für next_func
	jal chg_dupls

	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra

#-------------------------------------------------------
chg_dupls:
	# str_in : 			$a0
	# char: 			$a1
	# char_from str:	$t0
	# char_from str2:	$t1
	# counter:		$v0
	lb $t0, ($a0)		# speichen von char in t0
	beq $t0, '\n', end_chg	# beenden wenn string zuende
	bne $t0, $t1, no_chain	# ersezten der zeichen
	
	addi $v0, $v0, 1	# count cahin
	sb $a1, ($a0)		# change char in str to pre defined char
	
	
no_chain:
	move $t1, $t0		# store char1 für vergleich
	addi $a0, $a0, 1	# set address to next char
	j chg_dupls		# loop
end_chg:
	jr $ra
	
#--------------------------------------------------------
sort:
	# $a0, str
	# $t0:	cahr_2	
	# $t1:	char_1
	lb $t0, ($a0)			#$cahr 1
	addi $a0, $a0, 1		# goto address char2 
	lb $t1, ($a0)			#$char2
	
	beq $t1, '\n', end_sort	# beenden wenn str zuende
	ble $t0, $t1, end_if 	# if(char_2 > char_1): end_if
	
	sb $t0, ($a0)		# store char1 and posi cahr2
	addi $a0, $a0, -1	# go to posi char1
	sb $t1, ($a0)		# store char2 in posi char1
	
	lw $a0, 0($sp)
	
end_if:
#	move $t1, $t0		# save 
#	addi $a0, $a0, 1
	j sort
	
end_sort:
	jr $ra
	
	