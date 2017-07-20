		RESET EQU 0H
		VETOR EQU 60H
		ORG RESET
		MOV R3,#0
		MOV DPTR,#NRO ; endereco nro parcelas a ser somado
		MOV A,#0
		MOVC A,@A+DPTR
		JZ FIM
		MOV R1,A ; R1 = nro parcelas a ser somado
		MOV DPTR,#DADOS ; dados a serem somados
		MOV R2,#0 ; guarda resultado
VOLTA: 	MOV A,R3
		MOVC A,@A+DPTR ; le parcela
		ADD A,R2
		MOV R2,A
		INC R3
		DJNZ R1,VOLTA
		MOV DPTR,#0001H
		MOVX @DPTR,A
FIM: 	JMP FIM
		

		ORG VETOR
NRO: 	DB 06H
DADOS: 	DB 01H,03H,05H,06H,0AH,0F2H
		END