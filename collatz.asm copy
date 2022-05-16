# MIPS-Programm zum Collatz-Problem
# Eingabe: positive ganze Zahl
# Ausgabe: "Anzahl der Schritte bis zur Terminierung: " Anzahl

.text
main:

# Einlesen der Zahl
	la	$a0, prompt
	li	$v0, 4		# print_string
	syscall

	li	$v0, 5		# read_int
	syscall
	move	$s0, $v0	# Input in $s0
	li	$s1, 0		# initialize $s1

#	Hier muss das eigentliche Programm stehen 
#	Schleife
#	Teste, ob aktuelle Zahl gerade ist
#	naechste Iteration (Verzweigung)

#	Ende der Schleife

	la	$a0, outstring
	li	$v0, 4
	syscall

	move	$a0, $s1
	li	$v0, 1		# print_int
	syscall

# ende
	li	$v0, 10
	syscall



.data
prompt:	.asciiz	"Eingabe einer positiven ganzen Zahl>"
outstring:	.asciiz	"Anzahl der Schritte bis zur Terminierung: "
