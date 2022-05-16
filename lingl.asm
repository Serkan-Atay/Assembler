# MIPS-Programm zur Loesung eines linearen Gleichungssystems
# mit zwei Gleichungen und zwei Variablen in single precision (float)

# Einlesen der 6 float-Koeffizienten der Gleichung
#    ax+by=c
#    dx+ey=f

.text
main:
	la	$a0, prompt_a
	li	$v0, 4
	syscall		# show prompt

	li	$v0, 6
	syscall		# read float
	mov.s	$f2, $f0	# Koeff a

	la	$a0, prompt_b
	li	$v0, 4
	syscall		# show prompt

	li	$v0, 6
	syscall		# read float
	mov.s	$f3, $f0	# Koeff b

	la	$a0, prompt_c
	li	$v0, 4
	syscall		# show prompt

	li	$v0, 6
	syscall		# read float
	mov.s	$f4, $f0	# Koeff c

	la	$a0, prompt_d
	li	$v0, 4
	syscall		# show prompt

	li	$v0, 6
	syscall		# read float
	mov.s	$f5, $f0	# Koeff d

	la	$a0, prompt_e
	li	$v0, 4
	syscall		# show prompt

	li	$v0, 6
	syscall		# read float
	mov.s	$f6, $f0	# Koeff e

	la	$a0, prompt_f
	li	$v0, 4
	syscall		# show prompt

	li	$v0, 6
	syscall		# read float
	mov.s	$f7, $f0	# Koeff f

# Nun sind die Koeffizienten a,b,c,d,e,f in den float-registern
# $f2 - $f7 

# Die folgenden beiden Zeilen muessen ersetzt werden durch die
# Loesung des linearen Gleichungssystems
# Algorithmus: vgl. Aufgabenblatt
# Loesung soll in $f8 (x) und $f9 (y) abgelegt werden
	
	mov.s	$f8, $f2
	mov.s	$f9, $f3

# Ausgabe des Resultates
	la	$a0, outstring_1
	li	$v0, 4
	syscall			# Ausgabestring

	mov.s	$f12, $f8	# x zum Ausgeben
	li	$v0, 2		# print float
	syscall

	la	$a0, outstring_2
	li	$v0, 4
	syscall			# Ausgabestring

	mov.s	$f12, $f9	# y zum Ausgeben
	li	$v0, 2		# print float
	syscall

#	quit
	li	$v0, 10
	syscall

.data
prompt_a:	.asciiz	"Eingabe a (float)>"
prompt_b:	.asciiz	"Eingabe b (float)>"
prompt_c:	.asciiz	"Eingabe c (float)>"
prompt_d:	.asciiz	"Eingabe d (float)>"
prompt_e:	.asciiz	"Eingabe e (float)>"
prompt_f:	.asciiz	"Eingabe f (float)>"
outstring_1:	.asciiz	"Loesung: x="
outstring_2:	.asciiz	" y="
