;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;INCREMENTO.asm - Incrementa uma posicao de memoria em hexadecimal
;Prof. Fernando M. de Azevedo - 15.03.2005
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ORG 2000H
	; LDA 2015H
	LDA CONT	; CARREGA NO ACUMULADOR O CONTEUDO 
			; DA POSICAO DE MEMORIA DEFINIDA POR CONT
	INR A		; INCREMENTA O ACUMULADOR
	; STA 2015H
	STA CONT	; ARMAZENA NA POSICAO DE MEMORIA DEFINIDA 
			; POR CONT O CONTEUDO DO ACUMULADOR
	JMP $		; UMA MANEIRA DE FINALIZAR. 
	ORG 2015H
CONT	DB 00H		; CRIA VARIAVEL COM VALOR INICIAL 00H	
	END
