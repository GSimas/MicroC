;MATHEUS FIGUEIREDO
reset	  equ 	0h
ltmr1     equ 	1bh ; local tratador,               MUDOU AQUI
state     equ 	20h
    
   	    org 	reset	;PC=0 depois de reset
    	jmp 	inicio 
	
    	org 	  ltmr1                         ; MUDOU AQUI
		mov       th1,#0ECh                       ;th e tl s�o registrados do timer			
		mov       tl1,#00h                     ; coloca duas vezes pq � ciclico
    	mov 	 state,#1h
        reti	
inicio: 
    	mov 	ie,#10001000b     ; habilita         , MUDOU AQUI
    	mov    	tmod,#00000000b            ; modo 0
    	mov      th1,#0ECH  ; OU #236 QUE � EC EM HEXADECIMAL, coloca os 5 bits lsb em TL1 que � 0h, e os msb 8 bits em th1 que � 11101100b = ECh
		MOV      TL1,#00H
   	    mov 	state,#0h ;inicializa��o
    	mov 	r0,#state 
    	mov 	dptr,#tabela
    	mov 	r1,#0
   	    setb	tr1            ; serve pra fechar a chave e assim, o pulso de clock chega ao contador                    , MUDOU AQUI
								;e ele come�a a funcionar, A CONTAGEM JA COME�A AQUI, 1 CICLO DE INSTRU��O
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