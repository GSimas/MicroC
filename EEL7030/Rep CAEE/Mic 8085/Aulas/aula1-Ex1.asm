;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;INCREMENTO.asm - Incrementa uma posicao de memoria em hexadecimal
;Prof. Fernando M. de Azevedo - 15.03.2005
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ORG 2000H
	LDA 2015H	; CARREGA NO ACUMULADOR O CONTEUDO DE 2015
	INR A		; INCREMENTA O ACUMULADOR
	STA 2015H	; ARMAZENA NA POSICAO DE MEMORIA 2015
FIM:	JMP FIM		; UMA MANEIRA DE FINALIZAR. NA REALIDADE ELE
			; VAI FICAR EM LOOP PERPETUO	
	END
