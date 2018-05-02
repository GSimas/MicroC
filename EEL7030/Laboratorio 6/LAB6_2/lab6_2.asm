;Universidade Federal de Santa Catarina - UFSC
;Engenharia Eletrônica - EEL7030 Microprocessadores
;Gustavo Simas da Silva - 2018.1

reset	equ   0h 
ltmr1	equ   1bh ;local do tratador
ltmr0	equ   0bh ;local do tratador
state	equ   20h 

		org reset ;PC=0 depois de reset
		jmp inicio
		
		org ltmr0
		inc state
		reti

		org ltmr1
		cpl P2.3
		mov	th1,#0F1h
		mov tl1,#00h
		reti

inicio: mov	ie,#10001010b ; habilita tmr0 
		mov	tmod,#00h	; modo 0
		mov	th1,#0F1h
		mov tl1,#00h
		mov th0,#0ECh
		mov tl0,#00h
		mov	state,#0h ;inicialização
		mov	r0,# state
		mov	dptr,#tabela
		mov	r1,#0h
		setb tr1
		setb tr0

volta:  cjne @r0,#4,volta
		mov state,#0h
		mov th0,#0ECh
		mov tl0,#00h
		mov	a,r1
		movc a,@a+dptr
		mov p1,a
		inc r1
		cjne r1,#16h,volta
		mov r1, #0
		jmp	volta

tabela: db 'Microcontrolador'

end