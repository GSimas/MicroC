;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Leds.asm - Utilização da porta de saida p/ Leds
;Prof. Fernando M. de Azevedo - 28.03.2005
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
COMMAND	 EQU 20H	; Enderecos da PALAVRA DE COMANDO DA PORTA
LEDS	 EQU 22H	; Endereco da porta A
DELAY	 EQU 05F1H	; endereco da rotina de atrazo

        ORG 2000H

	LXI SP, 20C0H	; Inicializa o SP (o apontador da pilha)
	MVI A, 02H	; Programa a PPI com a porta B como saida
	OUT COMMAND
	MVI A, 01H	; joga 01 para os leds
LOOP:   OUT LEDS
	RLC
	PUSH PSW	; Zerar o campo de dados
	MVI D,03H	; atrazo para a rotina de atrazo
	CALL DELAY
	POP PSW
	JMP LOOP
	RET
	END
