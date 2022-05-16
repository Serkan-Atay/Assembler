	.data
str_out:		.asciiz "Zeichenkette (max. 126 Zeichen)> "
retrun1:		.asciiz "Geaenderte Zeichenkette 2: " 
return2:		.asciiz "Anzahl der Ersetzungen: "
str1:			.space 126
str2:			.space 126

	.text
	
	la $a0, str_out		# printen des eingebens einses strings
	li $v0, 4
	syscall
	
	la $a0, str1		# einlesen in str1
	li $a1, 126		# mit max größe von 126 zeichen
	li $v0, 8			
	syscall

	la $a0, str_out		# printen des eingabe strings
	li $v0, 4
	syscall
	
	la $a0, str2		# einlesen in str2
	li $a1, 126		# max 126 zeichen
	li $v0, 8
	syscall	
	
	la $a0, str1		# übergabe der adresse str1 in func 
	la $a1, str2		# übergabe der adresse str2 in func
	li $v0, 0			# intitalizieren des leeren v0 registers für return
	
	jal mark_prefix
	
	move $t0, $v0		# save mark_return in t0
	
	la $a0, retrun1		# print return str text
	li $v0, 4
	syscall
	
	la $a0, str2		# print str2
	syscall
	
	la $a0, return2		# print return int text
	syscall
	
	move $a0, $t0		# print mark_returned int 
	li $v0, 1
	syscall 
	
	li $v0, 10			# beenden des programms
	syscall
	
#--------------------------------
# $a0: str1
# $a1: str2
mark_prefix:
	lb $t0, ($a0)	# load str1 char in t0
	lb $t1, ($a1)	# load str2 cahr in t1
	li $t2, '#'		# speichern von # in register 
	
	bne $t0, $t1, end_mark	# branch if prefix ende
	sb $t2, ($a1)			# ersetzen des zeichens in str2			
	addi $v0, $v0, 1		# erhöhen des ersetzungs counters
	addi $a0, $a0, 1		# nächstes zeichen in str1
	addi $a1, $a1, 1		# nächstes zeichen in str2
	j mark_prefix			# repet
end_mark:
	jr $ra		# jump in main
	
	