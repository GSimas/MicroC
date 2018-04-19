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
			MOV 	SCON,#11000000B		; programa comunicação serial no modo 11b = 3
			SETB	REN					; Enable recebimento de dados
			MOV 	TMOD,#00100000B		; Timer 1 modo 2
			MOV 	TH1,#0F4H			; 
			MOV 	TL1,#0F4H			; Valor de recarga para 2.4 kbauds
			MOV 	PCON,#0H			; SMOD=0 -> não ocorre a dobra do baudrate
			SETB 	TR1					; Enable contagem timer 1
			MOV 	STATE,#0H			; Inicializa STATE com 0
			MOV 	R0,#STATE			; R0 passa a apontar para o STATE
			MOV		DPTR,#20H			; DPTR passa a apontar para a posição de memória externa solicitada
RESTART:	MOV 	R1,#30H				; A recepção de dados vai ocorrer a partir da memória 30H

VOLTA: 		CJNE 	@R0,#1,VOLTA		; Trava o programa até que o buffer de transmissão esteja vazio
			MOV 	STATE,#0H			; Zera o STATE
			JB		RB8,BIT9ALTO		; Caso o nono bit recebido for 1, redireciona o programa para BIT9ALTO

			MOV		A, SBUF
			MOVX	@DPTR,A				; Caso o nono bit for nível lógico baixo, salva o dado na posição 20H da memória externa
			JMP		VOLTA
			
BIT9ALTO:	MOV		@R1,SBUF			; O endereço de memória para o qual R1 aponta recebe o valor em SBUF 
			INC 	R1					; R1 é incrementado passando a conter a localização da próxima posição de memória a ser preenchida
			CJNE 	R1,#40H,VOLTA		; Limita o recebimento entre as posições de memória 30H a 3FH
			JMP		RESTART				; Volta a salvar na posição de memória 30H
			JMP $
TABELA: 	DB 'Microcontrolador'
END