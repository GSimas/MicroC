;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Teclado.asm - Leitura do teclado, soma e mostra de resultados
;Prof. Fernando M. de Azevedo - 28.03.2005
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LETECLA	EQU 02E7H	; Enderecos das sub-rotinas
MOSTRAD EQU 0363H
MOSTRAA EQU 036eH

        ORG 2000H

	LXI SP, 20C0H	; Inicializa o SP (o apontador da pilha)
LOOP:   CALL LETECLA	; Le o primeiro numero
	MOV D,A         ; carrega D com o conteudo de A
        MVI E,00        ; zera o registro E 
        PUSH D          ; salva o conteudo de DE pois a rotina
			; MOSTRAD altera todos os registros e os
			; registros DE estao sendo usados
        CALL MOSTRAD    ; mostra o primeiro numero em enderecos
        POP D          	; restaura o par DE
        CALL LETECLA    ; le o segundo numero
        MOV E,A		; move para E
        ADD D        	; "soma" o primeiro numero com o segundo
        PUSH PSW        ; salva o conteudo de AF pois a rotina
			; MOSTRAD altera todos os registros e os
			; registros AF estao sendo usados
	CALL MOSTRAD	; motra o segundo numero em endercos
	POP PSW		; restaura o AF
	CALL MOSTRAA	; mostra o resultado da soma no campo de dados
	JMP LOOP
        END

