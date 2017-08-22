;MATHEUS FIGUEIREDO
RESET 	 EQU 00H
LTSERIAL EQU 23H ; local tratador
STATE 	 EQU 30H

		 ORG RESET ;PC=0 depois de reset
		 JMP INICIO
		 ORG LTSERIAL
		 CLR RI                  ; era TI, agora é RI pq é recepção
		 MOV STATE,#1H
		 RETI
INICIO:  MOV IE,#10010000B
		 MOV SCON,#01010000B
		 MOV TMOD,#00100000B   ; C/T = 0, MODE TIMER 1 = 2,
		 MOV TH1,#0FDH		   ; RELOAD FDH
		 MOV TL1,#0FDH
		 MOV PCON,#0H          ;SMOD = 0

		 SETB TR1				;INICIA A CONTAGEM do timer 1, igual qnd configura timer
		 MOV STATE,#0H
		 MOV R0,#STATE
		 MOV R1,#20H
		 MOV R2,#5H
		 
VOLTA: 	 CJNE @R0,#1,VOLTA
		 MOV STATE,#0H
		 
			
		 MOV @R1,SBUF
		 INC R1            
		 
		 DJNZ R2, VOLTA       
		 MOV R1,#20H
		 JMP VOLTA
		
		 JMP $


 END 