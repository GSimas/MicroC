;Universidade Federal de Santa Catarina - UFSC
;Engenharia Eletrônica - EEL7030 Microprocessadores
;Gustavo Simas da Silva 2018.1

reset equ 0h
ltmr1 equ 1bh ; local do tratador
state equ 20h
	
	org reset ;PC=0 depois de reset
	jmp inicio
	
	org ltmr1
 	mov th1,#075h
	mov tl1,#75h
	mov state,#1h
	reti

inicio:
	mov ie,#10001000b ; habilita tmr0
	mov tmod,#00h ; modo 0
	mov state,#0h ;inicialização
	mov r0,#state
	mov dptr,#tabela
	mov r1,#0
	mov th1,#75h
	mov tl1,#52h
	setb tr1

volta: 
	cjne @r0,#1,volta
	mov state,#0h
	mov a,r1
	movc a,@a+dptr
	mov p1,a
	inc r1
	cjne r1,#16,volta
	clr tr0
	jmp $

tabela: db 'Microcontrolador'
 
end 