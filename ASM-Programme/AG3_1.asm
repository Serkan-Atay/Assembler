	.text
	# addi $8,$0, 0x7ff00000 #Addiere Register $0 auf Register $8 und addiere dazu Zahl 0x7ff00000 (2.146.435.072)
	lui $1, 32752	
	ori $1, $1, 0 
	add $8, $0, $1 
a:
	addi $8,$8,1
	j a
	
