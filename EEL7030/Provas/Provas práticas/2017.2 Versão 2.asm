;Artur Nunes Pires Lopes
RESET 		EQU 	00H
LTSERIAL 	EQU 	23H 				; local tratador
STATE 		EQU 	20H
CONTAGEM	EQU		30H
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
			MOV 	TH1,#0FDH			; 
			MOV 	TL1,#0FDH			; Valor de recarga para 9.6 ou 19.2 kbauds
			MOV 	PCON,#10000000B		; SMOD=1 -> ocorre a dobra do baudrate
			SETB 	TR1					; Enable contagem timer 1
			MOV 	STATE,#0H			; Inicializa STATE com 0
			MOV 	R0,#STATE			; R0 passa a apontar para o STATE

VOLTA: 		CJNE 	@R0,#1,VOLTA		; Trava o programa até que o buffer de transmissão esteja vazio
			MOV 	STATE,#0H			; Zera o STATE
			MOV		A,SBUF				; A recebe o dado, o que causa o P receber o bit de paridade esperado
			
			JB		P,IMPAR				; A=SBUF é ímpar
			JNB		P,PAR				; A=SBUF é par

PAR:		JB		RB8,CORROMPIDA		; P=0, porém RB8=1
			JNB		RB8,CORRETA			; P=RB8=0

IMPAR:		JB		RB8,CORRETO			; P=RB8=1
			JNB		RB8,CORROMPIDO		; P=1, porém RB8=0

;Estado 
;do dado
CORRETO:	MOV		P1,SBUF				; Caso a paridade esteja correta, P1 recebe SBUF 
			JMP		VOLTA				; Volta ao "WAIT"
CORROMPIDO:	INC		CONTAGEM			; Caso a paridade esteja errada, incrementa a posição de memória 30H
			JMP		VOLTA
			JMP $
END