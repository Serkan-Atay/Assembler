# Klausur 2017, Aufgabe 2 a)+b)
	.data 
char_buf:	.space 126
str_out:	.asciiz "Zeichenkette (max. 126 Zeichen)> "
sorted_str:	.asciiz "Aufsteigend sortiert"
not_sorted_str:	 .asciiz "Nicht aufsteigend sortiert ab Positioin "
	
	.text
	
	li $v0, 4			# print "Eingabe"
	la $a0, str_out
	syscall
	
	li $v0, 8			# read string
	la $a0, char_buf
	li $a1, 126
	syscall
	
	li $t0, 0		# charariable
	li $t2, 0 		# zähl variable
	
loop:
	lb $t1, ($a0)				
	addi $t2, $t2, 1				# erhöht die zählvariable bei jedem char um 1
	beq $t1, '\n', sorted			# abruch wenn ende
	beq $t1, 0, sorted			# abruch wenn ende
	blt $t1, $t0, not_sorted		# abruch wenn nächster buchstabe kleiner als der davor
	move $t0, $t1				# x wird auf y gesetzt
	addi $a0, $a0, 1			# string wird auf nächsten cahr gesetzt
	j loop
	
sorted:
	li $v0, 4			# print "erfolgreich"
	la $a0, sorted_str
	syscall
	j end

not_sorted:
	li $v0, 4			# print "error"
	la $a0, not_sorted_str
	syscall
	
	li $v0, 1			# print "Zählvariable"
	move $a0, $t2
	syscall

end:	
	li $v0, 10			# programm ende
	syscall
	