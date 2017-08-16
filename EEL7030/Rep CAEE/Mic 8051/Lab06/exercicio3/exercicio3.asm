;MATHEUS FIGUEIREDO
reset	  equ 	0h
ltmr0     equ 	0bh ; local tratador,               MUDOU AQUI
state     equ 	20h
    
   	    org 	reset	;PC=0 depois de reset
    	jmp 	inicio 
	
    	org 	  ltmr0                         ; MUDOU AQUI
		INC 	  state
        reti	
inicio: 
    	mov 	ie,#10000010b     ; habilita         , MUDOU AQUI
    	mov    	tmod,#00000010b  ;modo 2           
    	mov      th0,#96 ;queremos colocar 640, mas no modo 2, vai ate 256, entao 640/2 da valor metade, 640/3 da valor com virgula, ai 640/4 é 160
		MOV      tl0,#96 ; mas para contar 160, a gnt coloca 96, (fundo de escala) -160 = 96, pq o fundo de escala agora é 2^8
   	    mov 	state,#0h ;inicialização
ciclica:mov 	r0,#state 
    	mov 	dptr,#tabela
    	mov 	r1,#0
   	    setb	tr0            ; serve pra fechar a chave e assim, o pulso de clock chega ao contador                    , MUDOU AQUI
								;e ele começa a funcionar, A CONTAGEM JA COMEÇA AQUI, 1 CICLO DE INSTRUÇÃO
volta:  cjne 	@r0,#4,volta  
        	
		mov 	 state,#0h                      ;exercio 4 alto na metade de 960 e baixo na outra
    	mov  	a,r1
    	movc 	a,@a+dptr 
    	mov  	p1,a
    	inc  	r1
		cjne 	r1,#16,volta
		clr     tr0
    	jmp  	ciclica

 
tabela: 		db 'Microcontrolador'
    	end