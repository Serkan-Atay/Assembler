.text
start:
# Aufgabe 5.1

# Initialisierung
addi $4, $0, 30				# r4 <-- 30
addi $5, $0, 25				# r5 <-- 25
add $2, $5, 0				# r2 <-- r5
jal Euklidischer_Algorithmus		# Springe zum euklidischen Algorithmus (Subroutine)

addi $8, $2, 0				# Speichere das Ergebnis in einem neuen Register

# input Werte 2
addi $4, $0, 25				# r4 <-- 25
addi $5, $0, 35				# r5 <-- 35
add $2, $5, 0				# r2 <-- r5
jal Euklidischer_Algorithmus		# Springe zum euklidischen Algorithmus (Subroutine)

addi $9, $2, 0				# Speichere das Ergebnis in einem neuen Register

# input Werte 3
addi $4, $0, 210				# r4 <-- 210					
addi $5, $0, 28				# r5 <-- 28
add $2, $5, 0				# r2 <-- r5
jal Euklidischer_Algorithmus		# Springe zum euklidischen Algorithmus (Subroutine)

addi $10, $2, 0

# input Werte 4
addi $4, $0, 49				# r4 <-- 49
addi $5, $0, 42				# r5 <-- 42
add $2, $5, 0				# r2 <-- r5
jal Euklidischer_Algorithmus		# Springe zum euklidischen Algorithmus (Subroutine)

addi $11, $2, 0				# Speichere das Ergebnis in einem neuen Register

# input Werte 5
addi $4, $0, 17				# r4 <-- 17
addi $5, $0, 3				# r5 <-- 3
add $2, $5, 0				# r2 <-- r5
jal Euklidischer_Algorithmus		# Springe zum euklidischen Algorithmus (Subroutine)

addi $12, $2, 0				# Speichere das Ergebnis in einem neuen Register

# input Werte 6
addi $4, $0, 17				# r4 <-- 17
addi $5, $0, 51				# r5 <-- 51
add $2, $5, 0				# r2 <-- r5
jal Euklidischer_Algorithmus		# Springe zum euklidischen Algorithmus (Subroutine)

addi $13, $2, 0				# Speichere das Ergebnis in einem neuen Register
j Programmende

.text
Euklidischer_Algorithmus:		# Euklidischer Algorithmus als Subroutine
# Start des euklidischen Algorithmus
if_r4_null:
beq $4, $0, goto10			# if r4 == 0, goto10

if_r5_null:
beq $5, $0, goto9			# if r5 == 0, goto9

if_r4_groesser_r5:			
slt $7, $5, $4				# teste, ob r4 > r5
beq $7, $0, else			# Wenn $7 != 0, springe zu else
sub $4, $4, $5				# r4 = r4 - r5
j if_r5_null				# Springe zu if_r5_null

else:					# if r5 > r4
sub $5, $5, $4				# r5 = r5 - r4
j if_r5_null				# Springe zu if_r5_null

goto9:
add $2, $4, $0				# r2 <-- r4
j goto10				

goto10:
jr $ra

Programmende:
