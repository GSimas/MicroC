;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Teclado2.asm - Leitura do teclado, soma e mostra de resultados
;Prof. Fernando M. de Azevedo - 28.03.2005
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LETECLA	EQU 02E7H	; Enderecos das sub-rotinas
MOSTRAD EQU 0363H
MOSTRAA EQU 036eH

        ORG 2000H

	LXI SP, 20C0H	; Inicializa o SP (o apontador da pilha)
LOOP:   CALL LETECLA	; Le o digito mais significativo do primeiro numero
	RLC
	RLC
	RLC
	RLC		; desloca quatro posicoes p/ esquerda
	MOV D,A         ; carrega D com o conteudo de A
	CALL LETECLA	; le o digito menos significativo do primeiro numero
	ADD D		; Numero de dois digitos em A
	MOV D,A		; Carrega D com o novo valor de A, desta vez com dois digitos
        MVI E,00        ; zera o registro E 
        PUSH D          ; salva o conteudo de DE pois a rotina
			; MOSTRAD altera todos os registros e os
			; registros DE estao sendo usados
        CALL MOSTRAD    ; mostra o primeiro numero em enderecos
        POP D          	; restaura o par DE
 	CALL LETECLA	; Le o digito mais significativo do segundo numero
	RLC
	RLC
	RLC
	RLC		; desloca quatro posicoes p/ esquerda
	MOV E,A         ; carrega D com o conteudo de A
	CALL LETECLA	; le o digito menos significativo do segundo numero
	ADD E		; Numero de dois digitos em A
	MOV E,A		; Carrega D com o novo valor de A, desta vez com dois digitos
        PUSH PSW        
	PUSH D		; salva o conteudo de AF e DE pois a rotina
			; MOSTRAD altera todos os registros e os
			; registros AF e DE estao sendo usados
	CALL MOSTRAD	; motra o segundo numero em enderEcos
	POP D		; restaura DE
	POP PSW		; restaura o AF
	MOV A,D
	ADD E
	CALL MOSTRAA	; mostra o resultado da soma no campo de dados
	JMP LOOP
        END

