RESET 		EQU 	00H
TRATT0		EQU		00BH				; Local do tratador do timer 0
LTSERIAL 	EQU 	23H 				; local tratador
STATE 		EQU 	20H
STATE1		EQU		21H
			ORG 	RESET 				; PC=0 depois de reset
			JMP 	INICIO
			
			ORG		TRATT0				; Tratador do timer 0
			MOV 	TH0,#0F8H			; 
			MOV 	TL0,#03AH			; Recarrega Timer
			MOV 	STATE,#1H			; Libera o JUMP VOLTAB
			RETI
			
			ORG 	LTSERIAL
			MOV 	STATE,#1H			; Libera o JUMP VOLTA
			JB		RI,RECEIVE			; Flag de buffer de recebimento cheio
TRANSMIT:	CLR 	TI					; Limpa o flag de buffer de tranmissão vazio
			RETI
			
RECEIVE:	MOV 	STATE1,#1H			; Libera o JUMP VOLTA1
			CLR 	RI					; Limpa o flag de buffer de recebimento cheio
			RETI						; Retorna da interrupção
			
INICIO: 	MOV 	IE,#10010010B		; Enable interrupção serial e timer 0
			MOV 	SCON,#01000000B		; programa comunicação serial no modo 01b = 1
			SETB	REN					; Enable recebimento de dados
			MOV 	TMOD,#00100001B		; Timer 1 modo 2, Timer 0 no modo 1
			
			;TIMER 0
			MOV 	TH0,#0F8H			; 
			MOV 	TL0,#03AH			; 10000H-1990=F83A
			
			;TIMER 1
			MOV 	TH1,#0E8H			; 
			MOV 	TL1,#0E8H			; Valor de recarga para 1.2 kbauds
			MOV		PCON,#00000000B		; SMOD=0 -> não ocorre a dobra do baudrate
			
			SETB 	TR1					; Enable contagem timer 1
			MOV 	STATE,#0H			; Inicializa STATE com 0
			MOV 	R0,#STATE			; R0 passa a apontar para o STATE
			MOV		R1,#STATE1			; R1 passa a apontar para o STATE1
			
			MOV 	DPTR,#TABELA		; Aponta para a tabela contendo o meu nome
			MOV 	SBUF,#'A'			; Primeiro caractere a ser enviado
			MOV		R2,#1				; R2 aponta para o caractere da tabela a ser enviado

VOLTA: 		CJNE 	@R0,#1,VOLTA		; Trava o programa até que a interrupção serial seja solicitada
			MOV 	STATE,#0H			; Zera o STATE
			CJNE	@R1,#0,RECEBE		; Caso STATE1 seja 1 desvia para a rotina de recebimento de dado
			
			MOV		A, R2
			MOVC	A,@A+DPTR			; A recebe o caractere a ser enviado
			MOV		SBUF,A				; SBUF recebe o caractere a ser enviado
			INC 	R2					; R2 é incrementado passando a conter a localização do próximo caractere a ser enviado
VOLTAA:		CJNE 	R2,#24,VOLTA		; Limita a transmissão aos caracteres da tabela
			CLR 	TR1
			SETB	TR0
			
			;Onda quadrada
VOLTAB:		CJNE 	@R0,#1,VOLTAB		; Trava o programa até que a interrupção de recebimento serial ou a do timer 0 sejam solicitadas
			MOV 	STATE,#0H			; Zera o STATE
			CJNE	@R1,#0,RECEBE		; Caso STATE1 seja 1 desvia para a rotina de recebimento de dado
			CPL		P1.6
			
RECEBE: 	MOV 	STATE1,#0H			; Zera o STATE1
			MOV		P2,SBUF				; P2 recebe o dado recebido
			JMP		VOLTAA				; Volta ao "Wait"
			JMP $
TABELA: 	DB 'Artur Nunes Pires Lopes'
END