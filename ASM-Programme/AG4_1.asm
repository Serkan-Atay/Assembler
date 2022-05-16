	.text
	addi $8, $0, 0
	# int i = 0
	
	addi $9, $0, 19
	# int j = 19
	
	addi $10, $0, 0x1000
	addi $11, $0, -1
	addi $12, $0, -0x8000
	
	#addi $13, $0, 0x8000 (32768)
	lui $1, 0
	ori $1, $1, 32768
	add $13, $0, $1
	
	
	#addi $14, $0, 0xffff0000
	lui $1, 0
	ori $1, $1, 32767
	add $14, $0, $1
	
	movf $20, $14
	
	
	#addi $15, $0, 0x7fffffff
	lui $1, 0
	ori $1, $1, 65535
	add $15, $0, $1
	
	addi $24, $0, 5322
	addi $25, $0, 75
	
	add $2, $10, $9
	sub $3, $10, $9
	
	#not $, $9
	nor $4, $9, $0 
	add $4, $4, $10
	addi $4, $0, 1
	
	sll $5, $13, 5
	sra $6, $13, 5
	sra $7, $12, 5
	srl $16, $12, 5
	
	div $24, $25
	
	
	
	
