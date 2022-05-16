# soft enterance
.data
test:	.asciiz "Test!"

.text
	la $a0, test
	li $v0, 4
	syscall
