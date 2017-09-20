;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Interrupcoes1.asm - Utilização de subrotinas
;          	     para o processamento pela chamada  
;           	     da interrupcao
;Prof. Fernando M. de Azevedo - 07.04.2005
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RST7.5	 EQU 20CEH	; endereco do tratador da interrupcao 7.5
DELAY	 EQU 05f1H	; endereco da rotina de atrazo
MOSTRAA  EQU 036EH	; endereco da rotina mostra dados

        ORG 2000H

	LXI SP, 20C0H	; Inicializa o SP (o apontador da pilha)
	MVI A, 18H	; Mascara de interrupcoes
	SIM		; p/ habilitar as interrupcoes 5.5, 6.5, 7.5
	MVI A, 00H
	EI		; Habilita a resposta a solicitacao de interrupcoes
LOOP:	ADI 01H		; inr a nao serve, nao atualiza CY
	DAA
	PUSH PSW
	CALL MOSTRAA
	MVI D,03H	; atrazo para a rotina de atrazo
	CALL DELAY
	POP PSW
	JMP LOOP

	ORG RST7.5	; Desvio da RST7.5
	HLT
	RET

	END
