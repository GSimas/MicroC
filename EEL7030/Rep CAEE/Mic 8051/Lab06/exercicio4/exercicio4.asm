;MATHEUS FIGUEIREDO
reset	  equ 	0h
ltmr1     equ 	1bh ; local tratador,               MUDOU AQUI
state     equ 	20h
    
   	    org 	reset	;PC=0 depois de reset
    	jmp 	inicio 
	
    	org 	  ltmr1
    	mov      th1,#0F1H ; queremos 2x 480 que é 960, 2^13 - 480 = F100H , nao ta tanto realmente o valor de 960 
		MOV      tl1,#0H ;			; MUDOU AQUI
		PUSH ACC
		MOV A,20H
		JZ ZERO
		SETB P2.3
		POP ACC		
retorna:INC  state
        reti	
inicio: 
    	mov 	ie,#10001000b     ; habilita         , MUDOU AQUI
    	mov    	tmod,#00000000b            
    	mov      th1,#0F1H ; queremos 2x 480 que é 960, 2^13 - 480 = F100H
		MOV      tl1,#0H ; 
ciclico:mov 	state,#0h ;inicialização
    	mov 	r0,#state 
    	mov 	dptr,#tabela
    	mov 	r1,#0
   	    setb	tr1            ; serve pra fechar a chave e assim, o pulso de clock chega ao contador                    , MUDOU AQUI
								;e ele começa a funcionar, A CONTAGEM JA COMEÇA AQUI, 1 CICLO DE INSTRUÇÃO
volta:  cjne 	@r0,#2,volta          	
		mov 	 state,#0h                      ;exercio 4 alto na metade de 960 e baixo na outra
    	mov  	a,r1
    	movc 	a,@a+dptr 
    	mov  	p1,a
    	inc  	r1
		cjne 	r1,#16,volta
		clr         tr1
    	jmp  	ciclico

ZERO:	CLR P2.3
		POP ACC
		JMP retorna

tabela: 		db 'Microcontrolador'
    	end