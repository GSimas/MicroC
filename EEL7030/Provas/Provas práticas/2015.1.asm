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
			MOV 	SCON,#11000000B		; programa comunica��o serial no modo 11b = 3
			SETB	REN					; Enable recebimento de dados
			MOV 	TMOD,#00100000B		; Timer 1 modo 2
			MOV 	TH1,#0F4H			; 
			MOV 	TL1,#0F4H			; Valor de recarga para 2.4 kbauds
			MOV 	PCON,#0H			; SMOD=0 -> n�o ocorre a dobra do baudrate
			SETB 	TR1					; Enable contagem timer 1
			MOV 	STATE,#0H			; Inicializa STATE com 0
			MOV 	R0,#STATE			; R0 passa a apontar para o STATE
			MOV		DPTR,#20H			; DPTR passa a apontar para a posi��o de mem�ria externa solicitada
RESTART:	MOV 	R1,#30H				; A recep��o de dados vai ocorrer a partir da mem�ria 30H

VOLTA: 		CJNE 	@R0,#1,VOLTA		; Trava o programa at� que o buffer de transmiss�o esteja vazio
			MOV 	STATE,#0H			; Zera o STATE
			JB		RB8,BIT9ALTO		; Caso o nono bit recebido for 1, redireciona o programa para BIT9ALTO

			MOV		A, SBUF
			MOVX	@DPTR,A				; Caso o nono bit for n�vel l�gico baixo, salva o dado na posi��o 20H da mem�ria externa
			JMP		VOLTA
			
BIT9ALTO:	MOV		@R1,SBUF			; O endere�o de mem�ria para o qual R1 aponta recebe o valor em SBUF 
			INC 	R1					; R1 � incrementado passando a conter a localiza��o da pr�xima posi��o de mem�ria a ser preenchida
			CJNE 	R1,#40H,VOLTA		; Limita o recebimento entre as posi��es de mem�ria 30H a 3FH
			JMP		RESTART				; Volta a salvar na posi��o de mem�ria 30H
			JMP $
TABELA: 	DB 'Microcontrolador'
END