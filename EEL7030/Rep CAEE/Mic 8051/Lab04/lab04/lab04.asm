reset equ 00h
ltint0 equ 03h ; local tratador
state equ 20h
		 org reset ;PC=0 depois de reset
		 jmp inicio

		 org ltint0
		 jmp handler	;teve jump pra baixo pra entrar numa regiao de memoria onde nao se ilimita a 8 bytes
inicio:
		 mov ie,#10000001b ; habilita interrupção externa 0
		 setb it0 			;faz com que o mic entenda que a BORDA DE DESCIDA seja a solicitação de interrup.
		 mov state,#0h ;inicialização
		 mov r0,# state
		 mov dptr,#tabela
		 mov r1,#0
volta:
		cjne @r0,#1,volta    ;se for diferente, fica no loop, e vai ficar infinito
		mov state,#0h		;eu faço a interrupção para ele mudar de estado, pq ai o state recebe 1 e sai do loop
		 mov a,r1
		 movc a,@a+dptr
		 mov p1,a
		 inc r1
		cjne r1,#16,volta
		 jmp $
handler: mov state,#1h		;nunca alterar algum registrador na interrupção
		reti				;ah n ser que tenha q ter operação aritmetica, ai usa push e pop
tabela: db 'Microcontrolador'
		end
