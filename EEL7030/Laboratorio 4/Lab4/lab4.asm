reset 		equ 00h
ltint0 		equ 03h ; local tratador 0
ltint1		equ 13h ; local tratador 1
state 		equ 20h

org reset ; PC=0 depois de reset
	jmp 	inicio

org ltint0
	mov 	state,#1h
	reti

org	ltint1
	cpl		ex0
	reti

inicio:
	mov 	ie,#10000101b ; habilita interrupção
	setb 	it0 ; borda
	setb 	it1 ; borda
	mov 	state,#0h ;inicialização
	mov 	r0,#state
	mov 	dptr,#tabela
	mov 	r1,#0
	
volta:
	cjne 	@r0,#1,volta
	mov 	state,#0h
	mov 	a,r1
	movc 	a,@a+dptr
	mov 	p1,a
	inc 	r1
	cjne 	r1,#16,volta
	jmp 	$
	
tabela: db 'Microcontrolador'
	
end