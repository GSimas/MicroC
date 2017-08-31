;DISCIPLINA: MICROPROCESSADORES    INT_EX2                                  
;PROFESSOR: HARI                                                     
;     Fazer um programa para rodar em loop e:
; 1)  ler um numero decimal de dois digitos no teclado 
;      e guardar o mesmo em uma posicao de memoria imediatamente
;      apos o programa.
; 2) A INT RST5.5 deve ligar os  4 LEDs da direita e a RST6.5 
;     liga os 4 led da esquerda permanecendo os demais em como estao
;     RST7.5 nao tem efeito algum e TRAP apaga todos os LEDS.
; 3) O programa deve ficar em loop lendo o valor das chaves
;     e colocar este valor nos dois bytes do campo de enderecos.

; acrescentar:  
; 4- Mostrar o valor lido do teclado na parte alta do campo de enderecos
; 5 - Fazer um contador, no campo de dados cujo incremento eh o valor lido nas chaves
; 6 - fazer a velocidade do contador proporcional ao valor lido nas chaves  


LETECLA EQU 02E7H
MOSTRAD EQU 0363H
COMMAND EQU 20H
CHAVES  EQU 21H
LEDS    EQU 22H
RST7.5  EQU 20CEH
TRAP    EQU 20D1H
RST5.5  EQU 20C8H
RST6.5  EQU 20CBH

        ORG 2000H
        LXI SP,20C2H
        CALL LETECLA
        RLC
        RLC
        RLC
        RLC
        MOV D,A
        CALL LETECLA
        ADD D
	LXI H,DADO
        MOV M,A         ;FIM QUESTAO 1

        MVI A,02H
        OUT COMMAND

        MVI A,18H
        SIM        




LOOP:   EI
        IN CHAVES     ; LE CHAVES
        MVI D,00H
        MOV E,A
        CALL MOSTRAD    ; FIM DA QUESTAO 3
        JMP LOOP

HNDL1:  PUSH PSW
        MVI A,00H
        ORI 0FH
        OUT LEDS
        POP PSW
        EI
        RET



HNDL2:  PUSH PSW
        MVI A,00H
        ORI 0F0H
        OUT LEDS
        POP PSW
        EI
        RET


HNDL3:  PUSH PSW
        MVI A,00H
        OUT LEDS
        POP PSW
        EI
        RET


DADO DB 00H
	
	ORG RST5.5   ; DESVIO DA 5.5
        JMP HNDL1
        ORG RST6.5   ; DESVIO DA 6.5
        JMP HNDL2
        ORG RST7.5   ; DESVIO DA 7.5
        EI
        RET

        ORG TRAP      ; DESVIO DA TTRAP
        JMP HNDL3 
        END

	