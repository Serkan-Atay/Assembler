	.data
str1:	.asciiz  "Lager"
str2: .asciiz  "Regal"
str3:	.space 10
	.byte 0xff
	.byte 0xff
	
	.text			
	jal tausch_L
	jal tausch_R
	jal Drehe_lager
	jal Drehe_regal
	jal Auf_Adresse_von_str3_speichern
	jal Paldindromtest
	

# Aufgabenteil a)		
					# L in l wandeln 4C -> 6C
tausch_L: 			# L in l wandeln 4C -> 6C
	lui $1,0x1001		# Register mit der geuchten Position ind er Data Section befüllen
	ori $1, $1, 0x0000	# Register mit der geuchten Position ind er Data Section befüllen
	lb $2, 0($1)		# L laden aus der Data Section und auf Register 2 speichern
	addi $2, $2, 0x20	# L in l wandeln durch Byteänderung
	sb $2, 0($1)		# l wieder an die Stelle des L speichern
	jr $31
	
	
tausch_R: 			# R in r wandeln 52 -> 72
	lb $2, 6($1)		# R laden aus der Data Section und auf Register 2 speichern
	addi $2, $2, 0x20	# R in l wandeln durch Byteänderung
	sb $2, 6($1)		# R wieder an die Stelle des r speichern
	jr $31
	

# Aufgabenteil b)		
Drehe_lager:			# Laden der einzelnen Buchstaben
	lb $2, 0($1)		# Laden von l und speichern auf Register 2
	lb $3, 1($1)		# Laden von a und speichern auf Register 3
	lb $4, 2($1)		# ...
	lb $5, 3($1)
	lb $6, 4($1)
	
					# Speichern der Buchstaben
	sb $2, 4($1)		# Speichern von l an der 5ten Bytestelle
	sb $3, 3($1)		# Speichern von a an der 4ten Bytestelle
	sb $4, 2($1)		# ...
	sb $5, 1($1)
	sb $6, 0($1)
	jr $31
	
Drehe_regal:			# Laden der einzelnen Buchstaben
	lb $2, 6($1)		# Laden von r und speichern auf Register 2
	lb $3, 7($1)		# Laden von e und speichern auf Register 3
	lb $4, 8($1)		# ...
	lb $5, 9($1)
	lb $6, 10($1)
	
					# Speichern der Buchstaben
	sb $2, 10($1)		# Speichern von l an der 5ten Bytestelle
	sb $3, 9($1)		# Speichern von a an der 4ten Bytestelle
	sb $4, 8($1)		# ...
	sb $5, 7($1)
	sb $6, 6($1)
	jr $31

	
# Aufgabenteil c)			
Paldindromtest:

Test_erster_Buchstabe:		
	lb $2, 0($1)			# Der je erste Buchstabe der zwei Wörter wird geladen...
	lb $3, 10($1)
	beq $2, $3, Test_zweiter_Buchstabe	# und dann verglichen, wenn gleich wird der nächste Buchstabe vergleichen...
	bne  $2, $3, False					# wenn nicht wird die 0 ausgegeben
	
	
Test_zweiter_Buchstabe:	# Überprüfe so jeden weiteren Buchstaben der Wörter
	lb $2, 1($1)
	lb $3, 9($1)
	beq $2, $3, Test_dritter_Buchstabe
	bne  $2, $3, False
	
Test_dritter_Buchstabe:
	lb $2, 2($1)
	lb $3, 8($1)
	beq $2, $3, Test_vierter_Buchstabe
	bne  $2, $3, False

Test_vierter_Buchstabe:		
	lb $2, 3($1)
	lb $3, 7($1)
	beq $2, $3, Test_fünfter_Buchstabe
	bne  $2, $3, False

Test_fünfter_Buchstabe:	
	lb $2, 4($1)
	lb $3, 6($1)
	beq $2, $3, True
	bne  $2, $3, False
	
True:				#Gib bei Palindom 1 aus
	addi $2, $0, 1
loopt:
	j loopt

False:			#Gib bei nicht Palindom 0 aus
	addi $2, $0, 0
loopf:
	j loopf
	
	
# Aufgabenteil d)

Auf_Adresse_von_str3_speichern:
	lb $2, 0($1)		# Laden von l und speichern auf Register 2
	lb $3, 1($1)		# Laden von a und speichern auf Register 3
	lb $4, 2($1)		# ...
	lb $5, 3($1)
	lb $6, 4($1)
	
	lb $7, 6($1)		# Laden von r und speichern auf Register 7
	lb $8, 7($1)		# Laden von e und speichern auf Register 8
	lb $9, 8($1)		# ...
	lb $10, 9($1)
	lb $11, 10($1)
	
	lui $12,0x1001# adresse von ffff
	ori $12, $1, 0x0016
	
	sb $2, 0($12)	# Speichern der einzelen Buchstaben an der adresse von 0xffff
	sb $3, 1($12)
	sb $4, 2($12)
	sb $5, 3($12)
	sb $6, 4($12)
	sb $7, 5($12)
	sb $8, 6($12)
	sb $9, 7($12)
	sb $10, 8($12)
	sb $11, 9($12)

	jr $31
