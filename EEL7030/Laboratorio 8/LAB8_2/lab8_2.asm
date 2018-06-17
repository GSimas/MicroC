;Exercício 2017-2
;1) enviar frase completa pela interface serial					
;2) a cada 998800 ciclos de inst. - timer 0							
;3) transmissao com BR = 137,5 kbits/s e sem bit paridade		
;4) timer 0, temporizador, modo 1 - 16 bits						
;5) receber dados e mostrar na P1
;6) mostrar na P2 quant. vezes que a msg. foi transmitida		



RESET       EQU     00H
INTSERIAL   EQU    	23H ; local tratador
TIMER0		EQU		0BH

			ORG 	RESET  	;PC=0 depois de reset
			JMP 	INICIO 	

			ORG 	TIMER0
			INC 	R4
			MOV		TH0,#9CH ;156
			RETI		

;RECEP
			ORG	   	INTSERIAL			;TI ta setado apos ter transmitido
			JNB	   	RI,TRANS			;se flip flop de recepcao for RI=0, vai pra TRANS, vai setar F1 e vai TRANSMITIR, se nao seta F0 - pra RECEBER
			CLR	   	RI
			MOV		R2,#1H	; FLIP FLOP DE USO DE PROPOSITO GERAL DO PSW

TRANS: 		JNB	   	TI,VOLTAROT			;desvia se Ti estiver em zero - volta pra rotina
			CLR	   	TI

VOLTAROT:   RETI


INICIO: 	MOV 	IE,#10010010B

			MOV     SCON,#01010000B	; MODO 3; REN=1
			MOV     TH1,#01DH
			MOV     TL1,#01DH
			
			MOV 	TMOD,#00100001B	; C/T- 0 (TEMP)
			MOV		TL0,#00H     
			MOV		TH0,#9CH
			
			MOV     PCON,#0H
			SETB	TR0
			SETB	TR1

			MOV		R1, #0H		;para transmissao da tabela
			MOV		R2, #0H 	;usados para int. transf e recebe
			MOV		R4, #0H
			MOV		R6, #0H 	;quant. de vezes que msg inteira foi transmitida 
			MOV		DPTR,#NOME
			
			MOV     SBUF,'E'	;coloca dado trans. no sbuf
			    

RECEP1:  	CJNE	R2,#1H,TRANS1	;RECEPCAOO!!!!
			MOV		R2,#0H
			
			MOV  	R5,SBUF  ;coloca dado recebido no end. de r1
			MOV		P1,R5

			
TRANS1:  	CJNE	R4,#39,RECEP1		;TRANSMISSAO!! -se F1=0 volta a RECEBER, se F=1 - TRANSMITI!
			MOV		R4,#0H
			
TRANSNOME:	MOV  	A,R1
			MOVC 	A,@A+DPTR
			MOV  	SBUF,A
			INC  	R1

			CJNE 	R1,#28,RECEP1 ;compara se atingiu maximo de caracteres
			MOV 	R1,#0H
			INC		R6 ;quant. de vezes que msg inteira foi transmitida
			MOV		P2, R6  ; nao sei se pode incrementar porta! VER!
			JMP 	RECEP1
			
			
NOME:		DB 'Exercício para P2 - EEL7030_'	;28  CARACTERES		

END
				
				;pq tem que colocar um bit de paridade antes de tudo e depois outro em TSTTI?
				;pode usar r2 e r3 em interrupcao, sem chamar de state??
				;clr e jnb é so pra bit!!!!
				;CTRL H - replace!!