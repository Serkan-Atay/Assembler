#== NOTES
# 1.	-			// branch if win of p1 or p2
#					- check 3 columns, 3 rows, 2 diagonal 
#
# 2.	-			// fill_find in tow underprograms ?
	
	.data
wellcum:	.asciiz "type in your filed >"
again:	.asciiz "next round? (y/~y) > "
win:.asciiz "\n\nyea you've won!\n"
err_notex:.asciiz "\n\nthise filed dosent exist! \n"
p1:		.byte 'X'
p2:		.byte	'O'
line:		.asciiz "---------------\n"
f1:		.asciiz "\n 1  |  2  |  3  \n"			# could be done easyer by setting 1-9 in one string and print a | seperatly
f2:		.asciiz " 4  |  5  |  6  \n"			#	- save memory
f3:		.asciiz " 7  |  8  |  9  \n\n"
	
	.text
	
	ori $5,$5, 0x9		# set $5 to 1	// for-schleife in main	can only go throuh 9 times
	andi $7,$7,0x0		# clear $7
	
main:
	addi $6,$6,0x1
	jal print_field		# prin_filed()
	jal fill_find			# fill_find()	set move
	jal check_win		# check_win	
	beq $5,$6,end		# j if equal		

	j main
	
	# end programm
end:
	jal print_field		# print for the last time
	jal play_ag
	li $2,10	
	syscall	

# fill_field
#=============================================

	# fill_field()		// fill in the letter into the field
fill_find:	
	la $4,wellcum
	li $2, 4
	syscall
	
	li $2, 12
	syscall

	la $8, f1
loop_find_f1:				# find number in list
	lb $9, ($8)
	beq $9, $0, notf1		# breanch if not
	beq $9, $2, find		# breanch if found
	addi $8, $8, 1
	j loop_find_f1			# jump back
notf1:
	
	la $8, f2
loop_find_f2:				# sreach in col 2
	lb $9, ($8)
	beq $9, $0, notf2
	beq $9, $2, find
	addi $8, $8, 1
	j loop_find_f2
notf2:
	
	la $8, f3
loop_find_f3:
	lb $9, ($8)
	beq $9, $0, notf3
	beq $9, $2, find
	addi $8, $8, 1
	j loop_find_f3
notf3:

#	if not found
	sub $6, $6, 0x1	# the round dosent count 
	la $4, err_notex	# print error
	li $2, 4		
	syscall
	j main			# restart at main
	
	
find:
	li $10, 0x0		# reset skip value
	addi $7,$7,1		# get the current round
	#=====
	# %7 modulo 2
	# for identifier of p1 or p2
	li $11, 2			# used for modulo
	div $7, $11
	mfhi $11			# modulo return
	
	 beq $11, $0, turn_p1
	 j turn_p2 
	#=====
	# print player 1
turn_p1:
	lb $9, p1
	sb $9, ($8)	# store char on requested position
	j fill_end

	#print player 2
turn_p2:
	lb $9, p2
	sb $9, ($8)	# store char on requested position
	
fill_end:
	jr $31
	
	
# check_win
#=============================================
check_win:
	# get first column numbers		// can be also done by going throuh the string and cound the symbols
	la $8, f1
	addi $8, $8, 2
	lb $16, ($8)
	addi $8, $8, 6
	lb $17, ($8)
	addi $8, $8, 6
	lb $18, ($8)
	
	bne $16, $17, nowincol1
	bne $17, $18, nowincol1
	
	la $4, win
	li $2, 4
	syscall
	j end

nowincol1:
	# get second column numbers
	la $8, f2
	addi $8, $8, 1
	lb $16, ($8)
	addi $8, $8, 6
	lb $17, ($8)
	addi $8, $8, 6
	lb $18, ($8)
	
	bne $16, $17, nowincol2
	bne $17, $18, nowincol2
	
	la $4, win
	li $2, 4
	syscall
	j end

nowincol2:
	# get thired column numbers
	la $8, f3
	addi $8, $8, 1
	lb $16, ($8)
	addi $8, $8, 6
	lb $17, ($8)
	addi $8, $8, 6
	lb $18, ($8)
	
	bne $16, $17, nowincol3
	bne $17, $18, nowincol3
	
	la $4, win
	li $2, 4
	syscall
	j end
	
nowincol3:

	# get win in row 1
	la $16, f1					
	addi $16, $16, 2
	lb $17, ($16)
	
	la $18, f2
	addi $18,$18,1
	lb $19, ($18)

	la $20, f3
	addi $20,$20,1
	lb $21, ($20)
	
	bne $17, $19, nowinrow1
	bne $19, $21, nowinrow1
	
	la $4, win
	li $2, 4
	syscall
	j end
	
nowinrow1:
	
	# get win in row 2
	addi $16, $16, 6
	lb $17, ($16)
	
	addi $18,$18,6
	lb $19, ($18)
	
	addi $20,$20,6
	lb $21, ($20)
	
	bne $17, $19, nowinrow2
	bne $19, $21, nowinrow2
	
	la $4, win
	li $2, 4
	syscall
	j end

nowinrow2:

	# get win in row 3
	addi $16, $16, 6
	lb $17, ($16)
	
	addi $18,$18,6
	lb $19, ($18)
	
	addi $20,$20,6
	lb $21, ($20)
	
	bne $17, $19, nowinrow3
	bne $19, $21, nowinrow3
	
	la $4, win
	li $2, 4
	syscall
	j end

nowinrow3:

	#get win dia
	la $16, f1				# set the addresses of first diagonale
	addi $16, $16, 2
	la $18, f2
	addi $18, $18, 7
	la $20, f3
	addi $20, $20, 13
	
	lb $17, ($16)
	lb $19, ($18)
	lb $21, ($20)
	
	bne $17, $19, notdia1
	bne $21, $19, notdia1
	
	la $4, win
	li $2, 4
	syscall
	j end

notdia1:

	#get win dia
	la $16, f1				# set the addresses of first diagonale
	addi $16, $16, 12
	la $18, f2
	addi $18, $18, 7
	la $20, f3
	addi $20, $20, 1
	
	lb $17, ($16)
	lb $19, ($18)
	lb $21, ($20)
	
	bne $17, $19, notdia2
	bne $21, $19, notdia2
	
	la $4, win
	li $2, 4
	syscall
	j end

notdia2:
																					
	jr $31		# go back to main if no one wins

# print_field
# =============================================	
	
	# print_field()		// print the current field 
print_field:
	
	la $4, f1			# print ----...
	li $2, 4
	syscall
	
	la $4, line			# print ----...
	li $2, 4
	syscall
	
	la $4, f2			# print ----...
	li $2, 4
	syscall
	
	la $4, line			# print ----...
	li $2, 4
	syscall
	
	la $4, f3			# print ----...
	li $2, 4
	syscall
	
	jr $31
	
# play_ag
#===============================================
play_ag:
	and $7, $7, $0		# need for reset
	addi $7, $7, 0x30
	
	la $4, again
	li $2, 4
	syscall
	
	li $2, 12
	syscall
	
	beq $2, 'y', reset	# exit if eny key (~y) is pressed	
	jr $31
	
reset:
	addi $7, $7, 1
	la $8, f1
	addi $8, $8, 2
	sb $7, ($8)
	
	addi $7, $7, 1
	addi $8, $8, 6
	sb $7, ($8)
	
	addi $7, $7, 1
	addi $8, $8, 6
	sb $7, ($8)
	
	# seconed column
	addi $7, $7, 1
	la $8, f2
	addi $8, $8, 1
	sb $7, ($8)
	
	addi $7, $7, 1
	addi $8, $8, 6
	sb $7, ($8)
	
	addi $7, $7, 1
	addi $8, $8, 6
	sb $7, ($8)

	# thired column
	addi $7, $7, 1
	la $8, f3
	addi $8, $8, 1
	sb $7, ($8)
	
	addi $7, $7, 1
	addi $8, $8, 6
	sb $7, ($8)
	
	addi $7, $7, 1
	addi $8, $8, 6
	sb $7, ($8)
	
	# reset needed register 
	andi $7,$7,0x0
	andi $6,$6,0x0
	j main