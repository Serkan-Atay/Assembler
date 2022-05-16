# Klausur_SS_18
# Augabe 2
# Fehler bei funktion!!, kann nicht erkennen ob der fehler am code oder der klausur liegt
	
	.data
str_b:	.asciiz "b> "
str_e:	.asciiz "e> "
str_m:	.asciiz "m> "
str_r:	.asciiz "r> "

error_b:	.asciiz "Fehler: m<0"
error_e:	.asciiz "Fehler: m<0"
error_m:	.asciiz "Fehler: m<0"

	.text
	
	li $v0, 4
	la $a0, str_b
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0		# $t0 = b
	
	li $v0, 4
	la $a0, str_e
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0		# $t1 = e
	
	li $v0, 4
	la $a0, str_m
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0		# $t2 = m
	
	bge $t0, $zero, j1	# branch if b >= 0
	li $v0, 4
	la $a0, error_b
	syscall
	j end	
j1:

	bge $t1, $zero, j2	# branch if e >= 0
	li $v0, 4
	la $a0, error_e
	syscall
	j end	
j2:

	bge $t2, $zero, j3	# branch if m >= 0
	li $v0, 4
	la $a0, error_m
	syscall
	j end	
j3:
	# übergabe an func 
	move $a0, $t0		# b: a0 
	move $a1, $t1		# e: a1
	move $a2, $t2		# m: a2
	
	jal powmod
	move $t0, $v0
	
	li $v0, 4
	la $a0, str_r
	syscall
	
	li $v0, 1
	move $a0, $t0	
	syscall
		
end:
	li $v0, 10
	syscall

# powmod(int b, int e, int m) int r
#--------------------------------------------------
powmod:
	beq $a2, 1, ret_0
	li $v0, 1
	beq $a1, 0, ret
loop:
	andi $t0, $a0, 1
	beq $t0, 0, skip
	mult  $v0, $a0
	mflo $v0
	beq $a2, 0, skip
	div $v0, $a2
	mfhi $v0
skip:
	srl $a1, $a1, 1
	beq $a1, $zero, ret
	mult $a0, $a0
	mflo $a0
	beq $a2, $zero, loop
	div $a0, $a2
	mfhi $a0
	j loop
ret_0:
	li $v0, 0
ret:
	jr $ra
	
	
	