;MATHEUS FIGUEIREDO
CS 		  EQU P0.7
END0 	  EQU P3.3;
END1 	  EQU P3.4;
		  ORG 0h
		  CLR END0
		  CLR END1
		  SETB CS	
		  
VOLTA:	  MOV A,P2   ;P2 são as chaves, switches
		  CPL A      ;complementa P2 para quando apertar as chaves, aparecer 1 e nao 0		  
		  CALL CONVERTE
		  MOV P1,A
		  JMP VOLTA      ;nao tinha o volta, era infinito, agora deu certo
			  
CONVERTE: INC A
		  MOVC A,@A+PC
		  RET
TABELA:   DB 40H, 79H, 24H, 30H, 19H, 12H, 02H, 78H, 00H, 10H, 08H, 03H, 46H,21H, 06H, 0EH
		  END
