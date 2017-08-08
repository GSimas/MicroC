;MATHEUS FIGUEIREDO
itint0	  EQU 03H
state 	  EQU 20H	
CS 		  EQU P0.7
END0 	  EQU P3.3;
END1 	  EQU P3.4;
ATRASO 	  EQU 02H

		  ORG 0h 
		  JMP INICIO
		  ORG itint0
		  JMP HANDLER			  
		  CLR END0
		  CLR END1
		  SETB CS	


INICIO: MOV IE,#10000001B
		SETB IT0
		MOV state,#0H
		MOV R0,#state
		
		MOV R7,#0
VOLTA:	MOV P1,R7
		MOV A,#ATRASO
		CALL DELAY
		INC R7
		MOV A,R7
		CJNE A,#0FFH,VOLTA
		MOV P1,R7
		MOV A,#ATRASO
		CALL DELAY
LOOPINF:CJNE @R0,#1,LOOPINF
		JMP INICIO


DELAY:	DJNZ Acc,DELAY 
	 	RET	  

HANDLER: MOV state,#1h
		 CJNE R7,#0FFH,INTERROMPER
		 MOV R7,#0H
		 RETI

INTERROMPER: JMP $ 


		 END
