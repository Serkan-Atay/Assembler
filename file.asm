	.data
file1:		.asciiz "Mips_Fun/Text.txt"
str1:		.asciiz "Hallo, das ist ein test!"
str1_end: 	
str2:		.asciiz ""
	.text
#	t1: length of str
#	t0: file description

#open file for writing
#-----------------------------------------------
	li $v0, 13			# open file
	la $a0, file1		# set file name
	li $a1, 1			# open for writing
	li $a2, 0
	syscall
	
	move $t0, $v0		# move file description
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall

# write to file
#----------------------------------------
	li $v0, 15
	move $a0, $t0			# Write to File
	la $a1, str1			# load string to write in file
	la $a2, str1_end		# set address of string_end +1
	subu $a2, $a2, $a1		# calculate the length of string
	syscall
	
	move $a0, $v0			# print v0 for error 
	li $v0, 1
	syscall
	
	
	li $a0, '\n'
	li $v0, 11
	syscall
	
# close file
#-----------------------------------------
	li $v0, 16
	move $a0, $t0
	syscall

#==================================================
	
#open file for writing
#-----------------------------------------------
	li $v0, 13			# open file
	la $a0, file1		# set file name
	li $a1, 0			# open for reading
	li $a2, 0
	syscall
	
	move $t0, $v0		# move file description
	
	move $a0, $v0		# error 
	li $v0, 1
	syscall
	
	li $a0, '\n'
	li $v0, 11
	syscall
	
# read from file
#--------------------------------------
	li $v0, 14			# Read from File
	move $a0, $t0		# set file description
	la $a1, str2		# load address to write in
	li $a2, 128		# set byte boundery
	syscall
	
	move $a0, $v0		# error
	li $v0, 1
	syscall

	li $a0, '\n'
	li $v0, 11
	syscall
	
# close file
#-----------------------------------------
	li $v0, 16
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, str2
	syscall
		
	li $v0, 10
	syscall
