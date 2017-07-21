		RESET EQU 0H
		VETOR EQU 60H
		ORG RESET
		MOV R0,#0
		MOV DPTR,#NRO ; endereco nro parcelas a ser somado
		MOV A,#0
		MOVC A,@A+DPTR
		JZ FIM
		MOV R1,A ; R1 = nro parcelas a ser somado
		MOV DPTR,#DADOS ; dados a serem somados
		MOV R2,#0 ; guarda resultado
		MOV R3,#0
VOLTA: 	MOV A,R0
		MOVC A,@A+DPTR ; le parcela
		ADD A,R2
		MOV R2,A
		MOV A,#0
		ADDC A,R3
		MOV R3,A
		INC R0
		DJNZ R1,VOLTA
		MOV DPTR,#0000H
		MOVX @DPTR,A
		MOV A,R2
		INC DPL
		MOVX @DPTR,A

FIM: 	JMP FIM
		

		ORG VETOR
NRO: 	DB 06H
DADOS: 	DB 01H,03H,05H,0FFH,0FFH,0F2H
		END