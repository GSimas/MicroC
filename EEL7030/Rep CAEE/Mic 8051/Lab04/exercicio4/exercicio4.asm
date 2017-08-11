;MATHEUS FIGUEIREDO
org 0H
Jmp Inicio				; Pular para a label "Inicio"

		ltint0 equ 03h ; local tratador
		ltint1 equ 13h			; Endereço da interrupção 02
		flag1 equ 20H			; Endereço da flag 01
		flag2 equ 28H			; Endereço da flag 02

		org ltint0				; Configuração da ação referente à interrupção "int01"
		JMP handler0			; Label "handler01" referente às instruções decorrentes da interrupção "int01"

		org ltint1				; Configuração da ação referente à interrupção "int01"
		JMP handler1			; Label "handler01" referente às instruções decorrentes da interrupção "int01"

Inicio: 
		mov ie,#10000101b ; habilita interrupção externa 0
		setb it0 			;faz com que o mic entenda que a BORDA DE DESCIDA seja a solicitação de interrup.
		setb it1
		MOV A, #00000001B	; A recebe um valor para representar o Led acesso
		MOV P1, #0			; Reseta-se P1
		MOV R0, #flag2		; R0 recebe o endereço de flag2
		
TESTE: 	CJNE @R0, #0, TESTE			; Checa se R0(flag) ainda não foi modificado pela interrupção
		CJNE R3, #255, ROTADIR		; Checa se R3 ainda não foi modificado
		
ROTAESQ:
		RL A						; Rotaciona A para a esquerda
		MOV P1, A					; P1 recebe A
		JMP TESTE					; Volta para "Teste"
ROTADIR: 
		RR A						; Rotaciona A para a direita
		MOV P1, A					; P1 recebe A
		JMP TESTE					; Volta para "Teste"
		
handler0:
		PUSH Acc					; Salva A na pilha
		MOV A, R3					; A = R3
		CPL A						; Complementa-se A
		MOV R3, A					; R3 = A (complementado)
		POP Acc						; Valor anterior de A é recarregado
		RETI						; Retorna
		
handler1:
		PUSH Acc					; Salva A na pilha
		MOV A, flag2				; A recebe valor presente no endereço de flag
		CPL A						; Complementa-se o valor de A
		MOV flag2, A				; flag2 recebe o valor de A (complementado)
		POP Acc						; Valor anterior de A é recarregado
		RETI						; Retorna
		
END
		
		
	