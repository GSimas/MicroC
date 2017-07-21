;MATHEUS FIGUEIREDO
		RESET EQU 0H
		VETOR EQU 60H
		ORG RESET ; PC = 0000H ao se resetar o 8051
		MOV DPTR,#NRO ; endereco nro parcelas a ser somado
		MOV A,#0
		MOVC A,@A+DPTR
		MOV R1,A
		MOV DPTR,#DADOS ; end. vetor de dados a ser somado
		MOV R2,#0 ; guarda resultado das somas realizadas
		MOV R0,#0 ; especifica parcela a ser lida do vetor de dados
		MOV R3,#0
VOLTA:	MOV A,R0
		MOVC A,@A+DPTR ; le parcela
		ADD A,R2
		MOV R2,A
				
		
		ADDC A,R3
		MOV DPH,A
		MOV A,DPH
		MOV DPTR,#0
		MOVX @DPTR,A
		MOV A,R2
		MOV DPTR,#DADOS
		INC R0
		DJNZ R1,VOLTA


		ORG VETOR
NRO: 	DB 15H
DADOS: 	DB 01H,03H,05H,06H,0AH,0E2H,01H,03H,05H,06H,0AH,0E2H,0E2H,0E2H,0E2H	
		END