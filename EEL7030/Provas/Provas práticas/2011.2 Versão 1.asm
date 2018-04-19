RESET 		EQU 	00H
LTSERIAL 	EQU 	23H 				; local tratador
STATE 		EQU 	20H
			ORG 	RESET 				; PC=0 depois de reset
			JMP 	INICIO
			
			ORG 	LTSERIAL			
			CLR 	RI					; Limpa o flag de buffer de recep��o cheio
			MOV 	STATE,#1H			; Libera o JUMP VOLTA
			RETI						; Retorna da interrup��o
			
INICIO: 	MOV 	IE,#10010000B		; Enable interrup��o serial
			MOV 	SCON,#01000000B		; programa comunica��o serial no modo 01b = 1
			SETB	REN					; Enable recebimento de dados
			MOV 	TMOD,#00100000B		; Timer 1 modo 2
			MOV 	TH1,#0E8H			; 
			MOV 	TL1,#0E8H			; Valor de recarga para 1.2 kbauds
			MOV 	PCON,#0H			; SMOD=0 -> n�o ocorre a dobra do baudrate
			SETB 	TR1					; Enable contagem timer 1
			MOV 	STATE,#0H			; Inicializa STATE com 0
			MOV 	R0,#STATE			; R0 passa a apontar para o STATE
RESTART:	MOV 	DPTR,#2000H			; Os dados ser�o mantidos a partir da posi��o de mem�ria externa 2000H
			MOV		R1,#0

VOLTA: 		CJNE 	@R0,#1,VOLTA		; Trava o programa at� que o buffer de transmiss�o esteja vazio
			MOV 	STATE,#0H			; Zera o STATE
			MOVX	@DPTR,SBUF			; O endere�o de mem�ria para o qual R1 aponta recebe o valor em SBUF 
			INC 	R1					; 
			INC		DPTR				; DPTR � incrementado passando a conter a localiza��o da pr�xima posi��o de mem�ria a ser preenchida
			CJNE 	R1,#2020H,VOLTA		; Limita a transmiss�o aos 16 caracteres contidos na TABELA
			JMP		RESTART				; Volta a salvar na posi��o de mem�ria 30H
			JMP $
END