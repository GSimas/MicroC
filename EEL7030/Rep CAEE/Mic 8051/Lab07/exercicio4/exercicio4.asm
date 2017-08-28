;MATHEUS FIGUEIREDO
RESET 	 EQU 00H
LTSERIAL EQU 23H ; local tratador
STATE 	 EQU 20H
flagTI   EQU 2FH.1     ; AQUI SAO aqueles flipflops da IRAM que pode manipular individualmente
flagRI	 EQU 2FH.0
	
		 ORG RESET ;PC=0 depois de reset
		 JMP INICIO
		 
		 ORG LTSERIAL
		 JNB TI, RECEP    ;ao setar TI, o mic informa a UC para saltar pro tratador
		 CLR TI
		 SETB flagTI      ;informa que o buff está vazio
		 JNB RI, SAI

RECEP:	 CLR RI
		 SETB flagRI
SAI: 	 RETI

INICIO:  MOV IE,#10010000B
		 MOV SCON,#01010000B
		 MOV TMOD,#00100000B   ; C/T = 0, MODE TIMER 1 = 2,
		 MOV TH1,#0FDH		   ; RELOAD FFH
		 MOV TL1,#0FDH
		 MOV PCON,#80H          ;SMOD = 1
		 SETB TR1				;INICIA A CONTAGEM do timer 1, igual qnd configura timer
		 MOV STATE,#0H
		 MOV R0,# STATE
		
		MOV P2,#00H			;como vou usar MOVX @Ri,A ao invez de DPTR no lugar do Ri, eu tenho que especificar o valor ADDR_MSB na P2
		MOV A,#41H
		MOV SBUF,A


VOLT:	MOV R0,#00H

VOLTA: 	JNB flagTI, testaRI
		
		CLR flagTI                  ;Aqui transmite para a "tela"
		INC A
		MOV SBUF,A
		
		CJNE A,#61H,testaRI
		MOV A,#40H
		
testaRI:JNB flagRI, VOLTA
		CLR flagRI					;aqui recebe do buff receptor
		
		PUSH ACC
		MOV A,SBUF
		MOVX @R0,A
		POP ACC
		
		INC R0
		
		CJNE R0,#09H,VOLTA
		JMP VOLT

END 