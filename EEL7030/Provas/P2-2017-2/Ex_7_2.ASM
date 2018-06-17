RESET        	EQU     00H
LTSERIAL    	EQU    	23H ; local tratador
STATE         	EQU     20H


		ORG RESET  	;PC=0 depois de reset
		JMP INICIO 	

		ORG	   LTSERIAL
		CLR 	   TI
		MOV 	   STATE,#1H
		RETI

INICIO:  	MOV 	IE,#10010000B
		MOV       SCON,#11000000B	; MODO 3
		MOV 	 TMOD,#00100000B
		MOV       TH1,#0FFH
    		MOV       TL1,#0FFH
    		MOV       PCON,#80H	; SMOD=1
    		SETB	  TR1

		MOV 	STATE,#0H
    		MOV 	R0,# STATE

    		MOV 	A,#41H
		MOV	C,P ;paridade
		MOV     TB8,C
    		MOV      SBUF,A

VOLTA:  	CJNE 	@R0,#1,VOLTA
		MOV 	 STATE,#0H

    		INC	A
    		MOV	C,P
		MOV     TB8,C
    		MOV     SBUF,A

		CJNE 	A,#61h,VOLTA
		MOV 	A,#40H
    		JMP  	VOLTA


    	END