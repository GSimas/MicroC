;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;JULIANA.asm - Conversor de datas
;          	     
;Prof. Fernando M. de Azevedo - 07.04.2005
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LETECLA  EQU 02E7H	; endereco da rotina le teclas
MOSTRAD	 EQU 0363H	; endereco da rotina de mostra enderecos

        ORG 2000H

	LXI SP, 20E0H	; Inicializa o SP (o apontador da pilha)

LE1:	CALL LETECLA	; digito 1 do dia
	CPI 0AH
	JP LE1
	RLC
	RLC
	RLC
	RLC
	MOV E,A

LE2:	CALL LETECLA	; digito 2 do dia
	CPI 0AH
	JP LE2
	ORA E
	MOV E,A
	MVI D,00H 	; E contem dia em BCD e D = 0

LE3:	CALL LETECLA	; digito 1 do mes
	CPI 0AH
	JP LE3
	MVI C,00H
	CPI 00
	JZ LE4
	MVI D,10H

LE4:	CALL LETECLA	; digito 2 do mes	
	CPI 0AH
	JP LE4
	ADD C
	SUI 01H
	MOV C,A		; c = mes-1 = numero de meses a somar
	CPI 00H
	JZ MOSTRA	; se mes = janeiro, esta pronto
	LXI H,DIAS
	MOV A,E		; A inicia com o dia

SOMA:	ADD M		; .... e recebe todos os dias do mes
	DAA
	JNC CONT
	INR D		; vai um

CONT:	INX H
	DCR C
	JNZ SOMA
	MOV E,A

MOSTRA:	CALL MOSTRAD	; resultado no campo de enderecos
	JMP LE1

DIAS	DB 31H,28H,31H,30H,31H,30H
	DB 31H,31H,30H,31H,30H,31H

	END

