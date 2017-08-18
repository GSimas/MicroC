;MATHEUS FIGUEIREDO
reset	  equ 	0h
ltmr0     equ 	0bh ; local tratador,               MUDOU AQUI
ltint1	  equ   13h 
state     equ 	7Fh   ;TAVA 20H
    
   	    org 	reset	;PC=0 depois de reset
    	jmp 	inicio 

    	org 	  ltmr0                         ; MUDOU AQUI
		INC 	  state	
        reti

		org ltint1
		jmp handler
	
inicio: 
    	mov 	ie,#10000110b     ; habilita         , MUDOU AQUI
		mov 	TCON,#00000100B
    	mov    	tmod,#00000010b  ;modo 2           
    	mov      th0,#96 ;queremos colocar 640, mas no modo 2, vai ate 256, entao 640/2 da valor metade, 640/3 da valor com virgula, ai 640/4 é 160
		MOV      tl0,#96 ; mas para contar 160, a gnt coloca 96, (fundo de escala) -160 = 96, pq o fundo de escala agora é 2^8
ciclica:mov 	state,#0h ;inicialização
		mov 	r0,#state 
    	mov 	dptr,#tabela
    	mov 	r1,#0
		MOV 30H,#4H
   	    setb	tr0            ; serve pra fechar a chave e assim, o pulso de clock chega ao contador                    , MUDOU AQUI
								;e ele começa a funcionar, A CONTAGEM JA COMEÇA AQUI, 1 CICLO DE INSTRUÇÃO
volta:  MOV A,state
		cjne 	A,30H,volta  
        PUSH ACC	
		mov 	 state,#0h                      ;exercio 4 alto na metade de 960 e baixo na outra
    	mov  	a,r1
    	movc 	a,@a+dptr 
    	mov  	p1,a
		POP ACC
    	inc  	r1
		cjne 	r1,#16,volta
		clr     tr0
    	jmp  	ciclica

handler: PUSH ACC
		 PUSH B
		 clr tr0
		 clr tf0
		 MOV 30H,#2H
		 MOV 7Fh,#0H    ;state recebe valor
		 MOV A,#255     ; que é 2^8 -1 ´pq 2^8 tem 9 bits
		 MOV B,P2
		 CLR C
		 SUBB A,B
		 INC A
		 MOV TH0,A
		 MOV TL0,A		 
		 setb tr0
		 POP B
		 POP ACC
		 reti
 
tabela: 		db 'Microcontrolador'
    	end