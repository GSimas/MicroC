;MATHEUS FIGUEIREDO
CS 		  EQU P0.7
END0 	  EQU P3.3;
END1 	  EQU P3.4;
		  ORG 0h
		  CLR END0
		  CLR END1
		  SETB CS	
		  
		  MOV R4,#0H
		  MOV R5,#0AH
		  
VOLTA:	  MOV A,P2   ;P2 são as chaves, switches
		  
		  CPL A      ;complementa P2 para quando apertar as chaves, aparecer 1 e nao 0		
		  MOV R3,A
		  CALL FLAG
		  MOV A,R4
		  MOV P1,A
		  JMP FIM      ;nao tinha o volta, era infinito, agora deu certo

 
FLAG:     DEC R5
		
		  
		  MOV A,R5
		  JZ CONTINUA     ;se A=0, desvia o fluxo
		  MOV A,R3
		  JC SOMA
		  JNC ROT	
SOMA:	  INC R4
          RLC A
		  MOV R3,A
		  JMP FLAG	
ROT:	  RLC A
	      MOV R3,A
		  JMP FLAG
CONTINUA: RET
		  
		  FIM:		 		  
		 END
