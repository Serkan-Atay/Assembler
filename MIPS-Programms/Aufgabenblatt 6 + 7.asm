.data

str:	.asciiz "Eingabe eines Strings: "
buffer:	.space 256

str1:	.asciiz "Eingabe eines char: "
str2:	.asciiz "\nString in Kleinbuchstaben: "
str3:	.asciiz "\Vorkommen des Buchstaben: "

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

# Aufforderung zur Eingabe eines char
la $4, str1
li $v0, 4
syscall

# Eingabe eines char
li $v0, 12
syscall

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

# Sprung zu ncstr
jal ncstr

la $4, str3
li $v0, 4
syscall

move $a0, $t2
li $v0, 1
syscall

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

.text

ncstr:

lb $a1, ($t0)
beqz $a1, return_
bne $a1, $t1, loop
addi $t2, $t2, 1

loop:

addi $t0, $t0, 1
j ncstr

return_:

jr $ra

