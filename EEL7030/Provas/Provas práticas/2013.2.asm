RESET 		EQU 	00H
LTSERIAL 	EQU 	23H 				; local tratador
STATE 		EQU 	20H
			ORG 	RESET 				; PC=0 depois de reset
			JMP 	INICIO
			
			ORG 	LTSERIAL			
			CLR 	TI					; Limpa o flag de buffer de tranmissão vazio
			MOV 	STATE,#1H			; Libera o JUMP VOLTA
			RETI						; Retorna da interrupção
			
INICIO: 	MOV 	IE,#10010000B		; Enable interrupção serial
			MOV 	SCON,#01000000B		; programa comunicação serial no modo 01b = 1
			MOV 	TMOD,#00100000B		; Timer 1 modo 2
			MOV 	TH1,#0F4H			; 
			MOV 	TL1,#0F4H			; Valor de recarga para 2.4 kbauds
			MOV 	PCON,#0H			; SMOD=0 -> não ocorre a dobra do baudrate
			SETB 	TR1					; Enable contagem timer 1
			MOV 	STATE,#0H			; Inicializa STATE com 0
			MOV 	R0,#STATE			; R0 passa a apontar para o STATE
			MOV		R2,#0				; Utilizado para contar o número de vezes a MSG1 é transmitida
			MOV		R3,#0				; Utilizado para contar o número de vezes as duas MSGs são transmitida


RESTART:	JB		P0.0,MSG2			; Lê porta P0.0, Caso P0.0 = 1 redireciona o programa para a mensagem 2

			MOV 	DPTR,#TABELA0		; DPTR passa a apontar para a tabela
			MOV 	R1,#1				; A transmissão da tabela ocorrerá a partir da posição 1
			MOV 	SBUF,#'2'			; Primeiro caractere a ser enviado
			INC		R2					; Uma mensagem 1 a mais
			JMP		VOLTA

MSG2:		MOV 	DPTR,#TABELA1		; DPTR passa a apontar para a tabela
			MOV 	R1,#1				; A transmissão da tabela ocorrerá a partir da posição 1
			MOV 	SBUF,#'Q'			; Primeiro caractere a ser enviado


VOLTA: 		CJNE 	@R0,#1,VOLTA		; Trava o programa até que o buffer de transmissão esteja vazio
			MOV 	STATE,#0H			; Zera o STATE
			MOV 	A,R1				; A recebe a posição do caractere a ser enviado
			MOVC	A,@A+DPTR			; A recebe o caractere a ser enviado
			MOV 	SBUF,A				; SBUF recebe o caractere a ser enviado
			INC 	R1					; R1 é incrementado passando a conter a localização do próximo caractere a ser enviado
			CJNE 	R1,#14,VOLTA		; Limita a transmissão aos 16 caracteres contidos na TABELA

			INC		R3					; Uma mensagem a mais
			MOV		P1,R2				; Número de mensagens 1 é mandado à porta P1
			MOV		P2,R3				; Número de mensagens   é mandado à porta P2
			JMP		RESTART
			JMP $

TABELA0: 	DB '2013, fuiiii!'
TABELA1:	DB 'Qvenha 2014!!'
END