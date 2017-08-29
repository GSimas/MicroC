RESET 	 EQU 00H
LTSERIAL EQU 23H ; local tratador
STATE 	 EQU 20H
		 ORG RESET ;PC=0 depois de reset
		 JMP INICIO
		 ORG LTSERIAL
		 CLR TI
		 MOV STATE,#1H
		 RETI
INICIO:  MOV IE,#10010000B
		 MOV SCON,#01000000B
		 MOV TMOD,#00100000B   ; C/T = 0, MODE TIMER 1 = 2,
		 MOV TH1,#0FDH		   ; RELOAD FDH
		 MOV TL1,#0FDH
		 MOV PCON,#0H          ;SMOD = 0
		 SETB TR1				;INICIA A CONTAGEM do timer 1, igual qnd configura timer
		 MOV STATE,#0H
		 MOV R0,# STATE
		 MOV DPTR,#TABELA
		 MOV R1,#1
		 MOV SBUF,#'M'
VOLTA: 	 CJNE @R0,#1,VOLTA
		 MOV STATE,#0H
		 MOV A,R1
		 MOVC A,@A+DPTR
		 MOV SBUF,A       ;primeiro coloca o dado no buffer , depois do doub rate que ele é exibido
		 INC R1
		 CJNE R1,#16,VOLTA
		 CLR TR1
		 JMP $

TABELA: DB 'Microcontrolador'
 END 