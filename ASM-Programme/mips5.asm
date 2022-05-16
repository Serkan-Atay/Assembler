.text
#beq -> equal
#bne -> not equal
#slt -> less than
main:
addi $1,$0,1
addi $4,$0,30
addi $5,$0,25
jal start
addi $4,$0,25
addi $5,$0,35
jal start
addi $4,$0,210
addi $5,$0,28
jal start
addi $4,$0,49
addi $5,$0,42
jal start
addi $4,$0,17
addi $5,$0,3
jal start
addi $4,$0,17
addi $5,$0,51
jal start



start:
   addi $2,$5,0
    beq $4,$0,endlessloop
loop5:
   beq $5,$0,loop9
   slt $6,$5,$4
   beq $6,$1,loop61
   beq $6,$0,loop62
   
loop61:
   sub $4,$4,$5
   j loop5
  
loop62:
   sub $5,$5,$4
   j loop5

loop9:
   addi $2,$4,0
   jr $31
   
endlessloop:
     j endlessloop