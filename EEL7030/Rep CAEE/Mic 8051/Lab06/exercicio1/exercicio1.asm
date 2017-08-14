;MATHEUS FIGUEIREDO
reset	  equ 	0h
ltmr0     equ 	0bh ; local tratador
state     equ 	20h
    
   	    org 	reset	;PC=0 depois de reset
    	jmp 	inicio 
	
    	org 	  ltmr0
		mov       th0,#0fdh
		mov       tl0,#80h
    	mov 	 state,#1h
        reti	
inicio: 
    	mov 	ie,#10000010b     ; habilita
    	mov    	tmod,#01h            ; modo 1
    	mov      th0,#0fDh
    	mov      tl0,#80h    ;(2^16 - 640)
   	    mov 	state,#0h ;inicializa��o
    	mov 	r0,#state 
    	mov 	dptr,#tabela
    	mov 	r1,#0
   	    setb	tr0            ; serve pra fechar a chave e assim, o pulso de clock chega ao contador e ele come�a a funcionar, A CONTAGEM JA COME�A AQUI, 1 CICLO DE INSTRU��O
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