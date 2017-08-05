;MATHEUS FIGUEIREDO
		ORG 0h
		MOV P1,#00000010B

ABERTA:	
		JNB P2.7,FECHADA ;0
		JB P2.7,ABERTA   ;1


FECHADA:
		MOV R7,P2
		MOV A,R7
		CPL A
		MOV R7,A
		ANL 07H,#00001111B     ;passei para r7 o valor das chaves de p2, fiz um AND para limpar o byte MSD e deixar apenas o LSD em R7 de p2
		
		JNB P2.6,DIREITA
		 JB P2.6,ESQUERDA
		 
DIREITA: MOV A,P1
		 RR A
		 MOV P1,A
		 DEC R7
		 CJNE R7,#0,DIREITA
		 JMP FIM

ESQUERDA: MOV A,P1
		  RL A
		  MOV P1,A
		  DEC R7
		  CJNE R7,#0,ESQUERDA
		  JMP FIM


FIM:
END

