RESET 		EQU 	00H
LTSERIAL 	EQU 	23H 				; local tratador
STATE 		EQU 	20H
			ORG 	RESET 				; PC=0 depois de reset
			JMP 	INICIO
			
			ORG 	LTSERIAL			
			CLR 	RI					; Limpa o flag de buffer de recepção cheio
			MOV 	STATE,#1H			; Libera o JUMP VOLTA
			RETI						; Retorna da interrupção
			
INICIO: 	MOV 	IE,#10010000B		; Enable interrupção serial
			MOV 	SCON,#01000000B		; programa comunicação serial no modo 01b = 1
			SETB	REN					; Enable recebimento de dados
			MOV 	TMOD,#00100000B		; Timer 1 modo 2
			MOV 	TH1,#0E8H			; 
			MOV 	TL1,#0E8H			; Valor de recarga para 1.2 kbauds
			MOV 	PCON,#0H			; SMOD=0 -> não ocorre a dobra do baudrate
			SETB 	TR1					; Enable contagem timer 1
			MOV 	STATE,#0H			; Inicializa STATE com 0
			MOV 	R0,#STATE			; R0 passa a apontar para o STATE
RESTART:	MOV 	DPTR,#2000H			; Os dados serão mantidos a partir da posição de memória externa 2000H
			MOV		R1,#0

VOLTA: 		CJNE 	@R0,#1,VOLTA		; Trava o programa até que o buffer de transmissão esteja vazio
			MOV 	STATE,#0H			; Zera o STATE
			MOVX	@DPTR,SBUF			; O endereço de memória para o qual R1 aponta recebe o valor em SBUF 
			INC 	R1					; 
			INC		DPTR				; DPTR é incrementado passando a conter a localização da próxima posição de memória a ser preenchida
			CJNE 	R1,#2020H,VOLTA		; Limita a transmissão aos 16 caracteres contidos na TABELA
			JMP		RESTART				; Volta a salvar na posição de memória 30H
			JMP $
END