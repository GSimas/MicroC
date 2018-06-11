RESET        	EQU     00H
LTSERIAL    	EQU    	23H ; local tratador



    ORG RESET  	;PC=0 depois de reset
    JMP INICIO 	

    ORG	   LTSERIAL
    CLR 	   RI
    SETB 	   F0		; FLIP FLOP DE USO DE PROPOSITO GERAL DO PSW -- Evitar sobreposicao com STATE em 20H (ou mudar posicao de STATE)
    RETI

INICIO: MOV 	 IE,#10010000B
   	MOV      SCON,#01010000B  ; modo 1; REN=1
   	MOV 	 TMOD,#00100000B
	MOV       TH1,#0FDH
    	MOV       TL1,#0FDH
    	MOV       PCON,#0H
    	SETB	  TR1

VOLT:   MOV 	R1,#30H


VOLTA:  JNB 	F0,VOLTA
	CLR	F0
    	MOV  	@R1,SBUF
    	INC  	R1
	CJNE 	R1,#36H,VOLTA
    	JMP  	VOLT


    	END