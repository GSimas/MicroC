;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Leds3.asm - Utiliza��o da porta de saida p/ Leds junto com
;           a rotina de mostra no campo de dados para implementar
;           um contador em binario
;Prof. Fernando M. de Azevedo - 28.03.2005
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
COMMAND	 EQU 20H	; Enderecos da PALAVRA DE COMANDO DA PORTA
LEDS	 EQU 22H	; Endereco da porta A
DELAY	 EQU 05f1H	; endereco da rotina de atrazo
MOSTRAA  EQU 036EH	; endereco da rotina mostra dados

        ORG 2000H

	LXI SP, 20C0H	; Inicializa o SP (o apontador da pilha)
	MVI A, 02H	; Programa a PPI com a porta B como saida
	OUT COMMAND
	MVI E,00
LOOP:	MOV A,E
	OUT LEDS	; joga o valor do contador p/ para os leds
	PUSH PSW
	PUSH D
	CALL MOSTRAA
	POP D
	POP PSW
	PUSH PSW	; Zerar o campo de dados
	PUSH D
	MVI D,03H	; atrazo para a rotina de atrazo
	CALL DELAY
	POP D
	POP PSW
	INR E		; incrementa o contador
	JMP LOOP
	END
