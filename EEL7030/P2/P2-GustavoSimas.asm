;Gustavo Simas da Silva (matr. 16101076)
;Universidade Federal de Santa Catarina - UFSC
;Engenharia Eletrônica - EEL7030 Microprocessadores

;P2 - Lab
;Programa que recebe palavras de 8bits pela interface serial à taxa de 4,8kbits/s utilizando interrupcao serial
;Os dados recebidos sao armazenados na memoria externa de dados em enderecos consecutivos de 2000H até 2020H
;O numero total de dados recebidos é mostrado na porta P2
;Clock do cristal em 11,059MHz



RESET       EQU     00H			;local inicio programa
INTSERIAL   EQU    	23H 		;local tratador interrupcao serial

			ORG 	RESET  			;PC=0 depois de reset
			JMP 	INICIO 			;pula para o inicio
	

;RECEP
			ORG	   	INTSERIAL		;Interrupcao Serial
			CLR	   	RI
			MOV		R2,#1H 			;move #1h para o registrador r2 para executar recebimento no cod principal
			INC		R6 				;incrementa r6 indicando que recebeu mais um dado
			RETI


INICIO: 	MOV 	IE,#10010000B 	;EA = 1 ES = 1

			MOV     SCON,#01010000B	; MODO 1 10bits (8bits dados + 1 start bit + 1 stop bit); REN=1
			MOV 	TMOD,#00100001B	; TIMER 1 Modo 2 - C/T- 0  (TEMP) Gate - 0
			MOV     TH1,#0FAH 		;valor tabela
			MOV     TL1,#0FAH 		;valor tabela
			
			MOV     PCON,#0H 		;garantir que SMOD = 0
			SETB	TR1 			;dispara timer1

			MOV		R2, #0H 		;usados para int. recebimento
			MOV		A, #0H			;move #0h para o acumulador
			MOV		R6, #0H 		;quant. de vezes que msg inteira foi transmitida 	
VOLTA:		MOV		DPTR, #2000H 	;endereco externo inicial
			MOV		R4,#0H			;registrador auxiliar para verificar DPL

RECEP1:  	CJNE	R2,#1H,RECEP1 	;espera acontecer interrupcao para r2 ser = 1 e avancar
			MOV		R2,#0H			;move #0h para r2
			MOV		P1, R6			;coloca em p1 num. total de dados recebidos (quantidade de vezes que dados foram receb)
			MOV		A, SBUF			;coloca conteudo recebido no acumulador
			MOVX  	@DPTR, A		;copia conteudo do acumulador para o endereco externo indicado por dptr
			INC		DPL				;incrementa DPL para indicar prox endereco
			MOV		R4, DPL			;copia conteudo de dpl para registrador r4 para fazer verificacao a seguir
			CJNE	R4,#20,RECEP1 	;verifica se já recebeu 20bytes
			JMP		VOLTA			;retorna para colocar dptr 2000h
			
END