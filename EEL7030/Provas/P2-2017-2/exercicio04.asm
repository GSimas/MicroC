

;EXERCICIO 4 LAB07 

RESET      	EQU     00H
LTSERIAL  	EQU    	23H ; local tratador
F1	    	EQU    	PSW.1 			; FLIP FLOP DE USO DE PROPOSITO GERAL DO PSW  -- F1 N�O � ACEITO NO KEIL



		ORG RESET  	;PC=0 depois de reset
		JMP INICIO 	

		ORG	LTSERIAL
		JNB RI,SETTI
		CLR	RI
    		SETB F0			; FLIP FLOP DE USO DE PROPOSITO GERAL DO PSW
SETTI:  
		JNB	TI,RTN
		CLR	TI
    		SETB F1			; FLIP FLOP DE USO DE PROPOSITO GERAL DO PSW
RTN:   		RETI

INICIO:  
		MOV IE,#10010000B
		MOV SCON,#11010000B	; MODO 3; REN=1
		MOV TMOD,#00100000B	; TIMER 1 NO MODO 2 - 19.2 kbits/s
		MOV TH1,#0FDH
    		MOV TL1,#0FDH
    		MOV PCON,#80H
    		SETB TR1
       		MOV	A,#41H
		MOV SBUF,A
		MOV DPTR,#0H
    
RSTRI:  	JNB	F0,TSTTI
		CLR	F0
		MOV A,SBUF
		MOVX @DPTR,A
		INC DPL
		MOV	R1,DPL
		CJNE R1,#09H,TSTTI
		MOV	DPL,#0H
TSTTI:  	JNB	F1,RSTRI
	   	 CLR	F1
		INC	A
		MOV SBUF,A		
		CJNE A,#61H,RSTRI
		MOV	A,#40H
		JMP	RSTRI

		END
