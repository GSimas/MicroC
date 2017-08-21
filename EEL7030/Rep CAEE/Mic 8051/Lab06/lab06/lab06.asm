reset	  equ 	0h
ltmr0     equ 	0bh ; local tratador
state     equ 	20h
    
   	    org 	reset	;PC=0 depois de reset
    	jmp 	inicio 
	
    	org 	  ltmr0
		mov       th0,#0ffh
		mov       tl0,#09ch		
    	mov 	 state,#1h
        reti	
inicio: 
    	mov 	ie,#10000010b     ; habilita
    	mov    	tmod,#01h            ; modo 1
    	mov      th0,#0ffh
    	mov      tl0,#09ch    ;(2^16 - 100)
   	    mov 	state,#0h ;inicialização
    	mov 	r0,#state 
    	mov 	dptr,#tabela
    	mov 	r1,#0
   	    setb	tr0            ; serve pra fechar a chave e assim,o pulso de clock chega ao contador e ele começa a funcionar,A CONTAGEM JA COMEÇA AQUI,CICLO DE INSTRUÇÃO

volta:  cjne 	@r0,#1,volta  ;vai ter que clicar 100 vezes 
        	
		mov 	 state,#0h
    	mov  	a,r1
    	movc 	a,@a+dptr 
    	mov  	p1,a
    	inc  	r1
		cjne 	r1,#16,volta
		clr         tr0
    	jmp  	$

 
tabela: 		db 'Microcontrolador'
    	end 