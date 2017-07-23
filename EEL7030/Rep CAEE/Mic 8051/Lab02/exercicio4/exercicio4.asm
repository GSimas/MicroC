;MATHEUS FIGUEIREDO
RESET 	EQU 0H
VETOR 	EQU 60H
		
		ORG RESET 		; PC = 0000H ao se resetar o 8051
		MOV DPTR,#NRO 	; endereco nro parcelas a ser somado
		MOV A,#0
		MOVC A,@A+DPTR
		MOV R7,A 		; R1 = nro parcelas a ser somado
		MOV DPTR,#DADOS ; end. vetor de dados a ser somado
		MOV R0,#0
		MOV R3,#0
		MOV R4,#0
		MOV R6,#0 		; especifica parcela a ser lida do vetor de dados
VOLTA: 	MOV A,R6
		MOVC A,@A+DPTR 	; le parcela, Acc possui o numero a ser guardado
		MOV R3,A        ; R3 possui o nro a ser guardado		
		MOV A,R4
		ADD A,#50H
		MOV R0,A
		MOV A,R3
		MOV @R0,A       ;terminando de escrever na memoria interna
		
		MOV DPTR,#2200H ;escrevendo na memoria externa
		MOV A,DPL
		ADD A,R4
		MOV DPL,A
		MOV A,R3
		MOVX @DPTR,A    ;terminando de escrever na mem. externa
		MOV DPTR,#DADOS		
		INC R4
		INC R6
		DJNZ R7,VOLTA
FIM: 	JMP FIM
		
		ORG VETOR
NRO: 	DB 05H
DADOS: 	DB 01H,02H,03H,04H,05H
		END
