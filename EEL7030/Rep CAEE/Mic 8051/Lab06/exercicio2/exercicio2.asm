;MATHEUS FIGUEIREDO
reset	  equ 	0h
ltmr1     equ 	1bh ; local tratador,               MUDOU AQUI
state     equ 	20h
    
   	    org 	reset	;PC=0 depois de reset
    	jmp 	inicio 
	
    	org 	  ltmr1                         ; MUDOU AQUI
		mov       th1,#0ECh                       ;th e tl são registrados do timer			
		mov       tl1,#00h                     ; coloca duas vezes pq é ciclico
    	mov 	 state,#1h
        reti	
inicio: 
    	mov 	ie,#10001000b     ; habilita         , MUDOU AQUI
    	mov    	tmod,#00000000b            ; modo 0
    	mov      th1,#0ECH  ; OU #236 QUE É EC EM HEXADECIMAL, coloca os 5 bits lsb em TL1 que é 0h, e os msb 8 bits em th1 que é 11101100b = ECh
		MOV      TL1,#00H
   	    mov 	state,#0h ;inicialização
    	mov 	r0,#state 
    	mov 	dptr,#tabela
    	mov 	r1,#0
   	    setb	tr1            ; serve pra fechar a chave e assim, o pulso de clock chega ao contador                    , MUDOU AQUI
								;e ele começa a funcionar, A CONTAGEM JA COMEÇA AQUI, 1 CICLO DE INSTRUÇÃO
volta:  cjne 	@r0,#1,volta  ;vai ter que clicar 100 vezes 
        	
		mov 	 state,#0h
    	mov  	a,r1
    	movc 	a,@a+dptr 
    	mov  	p1,a
    	inc  	r1
		cjne 	r1,#16,volta
		clr     tr1
    	jmp  	$

 
tabela: 		db 'Microcontrolador'
    	end 