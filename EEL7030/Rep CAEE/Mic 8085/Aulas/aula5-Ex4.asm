;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Interrupcoes4.asm - Utilização de subrotinas
;          	     para o processamento pela chamada  
;           	     da interrupcao
;Prof. Fernando M. de Azevedo - 07.04.2005
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RST7.5	 EQU 20CEH	; endereco do tratador da interrupcao 7.5
DELAY	 EQU 05f1H	; endereco da rotina de atrazo
MOSTRAA  EQU 036EH	; endereco da rotina mostra dados
MOSTRAD	 EQU 0363H	; endereco da rotina de mostra enderecos

        ORG 2000H

	LXI SP, 20E0H	; Inicializa o SP (o apontador da pilha)
	LXI D, 0000H	; Inicializa o par DE com 00h
	MVI A, 11H	; Mascara de interrupcoes
	SIM		; p/ habilitar as interrupcoes 5.5, 6.5, 7.5
	MVI A, 00H
	STA STATE	; Flag de reset da contagem
	STA COUNT	; Inicializa a contagem
	STA INTCALL	; inicializa a contagem de quantas vezes a int foi chamada
	EI		; Habilita a resposta a solicitacao de interrupcoes

LOOP:	LDA COUNT
	ADI 01H		; inr a nao serve, nao atualiza CY
	DAA
	STA COUNT

	PUSH PSW
	PUSH D
	CALL MOSTRAA
	MVI D,02H	; atrazo para a rotina de atrazo
	CALL DELAY
	POP D
	POP PSW

	LDA STATE	; Testa o criterio de 
	CPI 00H		; reinicializacao
	JZ LOOP

	MVI A, 00H	; Caso contrario
	STA COUNT	; zera a contagem e
	STA STATE	; reinicializa flag
	JMP LOOP

HAND:	PUSH PSW
	LDA INTCALL
	PUSH PSW
	ADI 01H		; inr a nao serve, nao atualiza CY
	DAA
	MOV E,A
	STA INTCALL
	CALL MOSTRAD
	POP PSW	
	MVI A, 01H
	STA STATE
	POP PSW
	EI
	RET

STATE	DB 00H 		; Flag global alterado pelo tratador
COUNT	DB 00H		; Contagem
INTCALL DB 00H		; Contador de chamadas de interrupcao

	ORG RST7.5	; Desvio da RST7.5
	JMP HAND
	END

