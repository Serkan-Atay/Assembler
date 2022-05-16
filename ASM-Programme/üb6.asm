	.data
	
str1:	.asciiz "Lager"
str2: 	.asciiz "Regal"
str3:	.space 11
	.byte 0xff
	.byte 0xff	
	
	.text
main:
	la $a0, str1 # Load Adress of str1  into $a0
	jal strtolower # Groﬂbuchstaben in Klein
	la $a0, str2 # Load Adress of str2 into $a0
	jal strtolower # Groﬂbuchstaben in Klein
	
	la $a0, str1 # Load Adress of str1 into $a0
	jal strturnaround # str1 umdrehen
	la $a0, str2 # Load Adress of str2  into $a0
	jal strturnaround # str2 umdrehen
	
	la $a0, str1 # Load Adress of str1 into $a0
	la $a1, str2 # Load Adress of str2 into $a1
	la $a2, str3 # Load Adress of str3 into $a2
	jal strcat # Connect 2 Strings
	
	la $a0, str3 # Load Adress of str3 into $a0
	jal strispalindrom # Check if Palindrom
	j exit
	
#NR a)
strtolower:
	lb $t0, 0($a0) #Load first Byte
	beqz $t0, back # Check if byte is \0 and return if so
	blt $t0, 91, lower # Check if byte is lower than 91
	add $a0, $a0, 1 # Increase Adress in $a0
	j strtolower # Check next Byte
lower:
	addi $t0, $t0, 0x20 # Convert it to Capitalletter
	sb $t0, 0($a0) #Store it back
	j strtolower # Check next Byte
back:
	jr $ra # Jump Back
	
#NR b)
strturnaround:
	add  $a3, $zero, $a0 # Prepare Count Method
	la $t9, count #Load Adress of count 
	jalr $t1, $t9 #Jump to Count
loop:
	blt $a3, $a0, back #Check if last Adress is smaller then first Adress
	lb $t0, 0($a0)# Load first Byte
	lb $t1, 0($a3)# Load last Byte
	sb $t1, 0($a0)# Store first Byte
	sb $t0, 0($a3)# Store last Byte
	add $a0, $a0, 1
	sub $a3, $a3, 1
	j loop
#NR c)
strispalindrom:
	#Get last Char Adress of str3
	add  $a3, $zero, $a0 # Prepare Count Method
	la $t9, count #Load Adress of count 
	jalr $t1, $t9 #Jump to Count
	#------------------------------------------------------
loop4:	
	#Check if Byte are equal if not return 0.
	blt $a3, $a0, palindrom 
	lb $t2, 0($a0)
	lb $t3, 0($a3)
	add $a0, $a0, 1
	sub $a3, $a3, 1
	bne $t2, $t3, nopalindrom # IF Bytes are not equal return nopalindrom
	j loop4
palindrom:
	#All Bytes are equal return 1.
	add $v0, $zero, 1
	jr $ra
nopalindrom:
	add $v0, $zero, 0
	jr $ra
#NR d)
strcat:
	#Get last Char Adress of str1
	add  $a3, $zero, $a0 # Prepare Count Method
	la $t9, count #Load Adress of count 
	jalr $t1, $t9 #Jump to Count
	#------------------------------------
	move $t2, $a3 # Save Return of Count to $t2
	
	#Get last Char Adress of str2
	add  $a3, $zero, $a1 # Prepare Count Method
	la $t9, count #Load Adress of count 
	jalr $t1, $t9 #Jump to Count
	#------------------------------------
	move $t3, $a3 # Save Return of Count to $t3
	
loop2:	
	#Load str1 and Save it to str3
	lb $t4, 0($a0)
	sb $t4, 0($a2)
	add $a0, $a0, 1
	add $a2, $a2, 1
	ble $a0, $t2, loop2
loop3:
	#Load str2 and Save it to str3
	lb $t4, 0($a1)
	sb $t4, 0($a2)
	add $a1, $a1, 1
	add $a2, $a2, 1
	ble $a1, $t3, loop3
	jr $ra
	
#COUNT METHOD	
count:
	lb $t0, 0($a3) # Load first Byte
	beqz $t0, return # Return if byte is \0
	add $a3, $a3, 1 # Increase Adress
	j count #Repeat
return:
	sub $a3, $a3, 1
	jr $t1 # Return to last Method

exit:
	
