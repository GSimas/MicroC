RESET		EQU 	0H
LTMR0		EQU 	0BH 			; LOCAL DO TRATADOR
STATE		EQU 	20H				; STATE se localiza na posição de memória 20H
			ORG 	RESET 			; PC=0 DEPOIS DE RESET
			JMP 	INICIO
			
			ORG 	LTMR0			; Tratador de interrupção externa de timer
			INC		STATE			; STATE é incrementado
			RETI

INICIO:
			MOV 	IE,#10000010B 	; HABILITA TMR0
			MOV 	TMOD,#10b 		; MODO 2 - Contador de 8 bits com reload
			MOV 	TH0,#0			; Reload com 00H (100H - 256decimal = 0)
			MOV 	TL0,#0			; Gera tratador a cada 256 ciclos de instrução
			MOV 	STATE,#0H 		; INICIALIZAÇÃO
			MOV 	R0,#STATE		; R0 passa a apontar para o STATE
			MOV 	DPTR,#1140H		; DPTR recebe o endereço onde os dados serão salvos
			MOV 	R1,#0
			SETB 	TR0				; Enable contagem

VOLTA:		CJNE 	@R0,#5,VOLTA	; só libera a sequência do programa se a posição de momória para a qual o R0 aponta (STATE)
									; tiver conteúdo igual a 5 indicando 5 contagens de 256 ciclos de programa (5*256=1280)
			MOV 	STATE,#0H		; Zera o STATE
			MOV		A, P1			; A lê os dados da porta P1
			MOVX	@DPTR,A			; os dados da porta P1 são enviados para a posição de memória externa para a qual o DPTR aponta
			INC 	R1				; 
			INC		DPTR			; O DPTR é incrementado para apontar para a nova memória a ser ocupada
			CJNE 	R1,#10H,VOLTA	; Volta ao VOLTA a não ser que já tenham sido ocupados os espaços de memória de 1140H a 114FH
			MOV		R1, #0			;
			MOV 	DPTR,#1140H		; Volta à unidade de memória 1140H
			JMP		VOLTA
			JMP $
			END 
