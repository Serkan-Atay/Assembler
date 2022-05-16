.data

str:	.asciiz "Eingabe eines Strings: "
buffer:	.space 256

str2:	.asciiz "\nString in Kleinbuchstaben: "

.text
# Aufforderung zur Eingabe eines Strings
la $4, str
li $v0, 4
syscall

# Eingabe eines Strings
la $a0, buffer
la $a1, 256
li $v0, 8
syscall

# Speichern des Strings in $t0
move $t0, $a0

# Speichern des char in $t1
move $t1, $v0

# Sprung zu strtolower
jal strtolower

# Ausgabe des Strings in Kleinbuchstaben
la $4, str2
li $v0, 4
syscall

la $4, buffer
li $v0, 4
syscall

move $t0, $a0

# Beendigung des Programms
li $v0, 10
syscall

.text
strtolower:

lb $a1, ($t0)
beqz $a1, return
bge $a1, 'A', probCap
addi $t0, $t0, 1
j strtolower

probCap:

ble $a1, 'Z', cap
addi $t0, $t0, 1
j strtolower

cap:

addi $a1, $a1, 32
sb $a1, ($t0)
j strtolower

return:

jr $ra
