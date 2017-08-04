;MATHEUS FIGUEIREDO
ATRASO EQU 2H	
	
	
		ORG 0h
DENOVO:		
		MOV A,#0H
		CALL LEDON
		CALL LEDOFF
		JMP DENOVO
		
LEDON:	SETB C      ; C = 1, e A = 0, quando rotacionar A, ele vai receber o C, assim, A=00000001, 
		RLC A       ;sentando de novo o C, o A vai receber outro carry na rotação, A=00000011
		MOV P1,A
		MOV A,#ATRASO
		CALL DELAY
		MOV A,P1	
		CJNE A,#255,LEDON
		RET
		
LEDOFF:	RRC A      ; A vai sendo rotacionado com carry = 0, perdendo os bits =1
		MOV P1,A
		MOV A,#ATRASO
		CALL DELAY
		MOV A,P1	
		CJNE A,#0,LEDOFF
		RET		

DELAY: DJNZ Acc,DELAY ; subrotina DELAY
		RET
	
		END



