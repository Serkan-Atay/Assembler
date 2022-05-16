		.data

strInput:	.asciiz "Eingabe eines Strings: "
buffer:		.space 256

strLower:	.asciiz "\nString in Kleinbuchstaben: "
strCount:	.asciiz "\nLänge des Strings: "
		
		

		.text
		.globl main
	
main:
		# Aufforderung zur Eingabe eines Strings
		la $4, strInput
		li $v0, 4
		syscall
		
		# Eingabe eines Strings
		la $a0, buffer
		la $a1, 256
		li $v0, 8
		syscall
		
		
		# Lengh of InputString?
		
		# Speichern des Strings in $t0
		move $t0, $a0
		
		
		
		# Sprung zu strtolower
		# String in $a1
		jal strtolower

		# Ausgabe des Strings in Kleinbuchstaben
		la $a0, strLower
		li $v0, 4
		syscall
		 
		
		la $a0, buffer
		li $v0, 4
		syscall
		
		#Aufruf von strtolower mit buffer in $a0
		jal strtolower
	
		# Beenden des Programms
		j exit
		
		
			
strtolower:	
		lb $a1, ($t0)		# Lese Zeichen an Stelle t0
		beqz $a1, return	# Wenn String zuende = return
		bge $a1, 'A', lessZ	# Wenn größer als A
		addi $t0, $t0, 1
		j strtolower
		
lessZ:		
		ble $a1, 'Z', changeToLower
		addi $t0, $t0, 1
		j strtolower

changeToLower:
		addi $a1, $a1, 32
		sb $a1, ($t0)
		j strtolower
				
return:
		jr $ra
		
	
exit:		# Beendigung des Programms
		li $v0, 10
		syscall
