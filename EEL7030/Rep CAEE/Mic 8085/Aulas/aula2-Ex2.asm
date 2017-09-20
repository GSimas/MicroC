;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Soma.asm - soma de numeros em hexadecimal
;Prof. Fernando M. de Azevedo - 28.03.2005
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ORG 2000H
        LDA N           ; Carrega A com o valor de N
        MOV C,A         ; armazena este valor em C
        LXI H,DADOS     ; aponta par HL p/ inicio da tabela
        MVI B,00H       ; inicializa soma
LOOP:   MOV A,M         ; carrega A com dado apontado por HL
        ADD B           ; soma acumulada em A
        MOV B,A         ; e guardada em B
        INX H           ; par HL aponta para o dado seguinte
        DCR C           ; decrementa o C
        JNZ LOOP        ; repete ate que C = 0
        LXI H,RESULT    ; aponta HL p/ inicio do resultado
        MOV M,B         ; guarda B na memoria
        JMP $           ; loop infinito, fica parado aqui
        ORG 2020H
RESULT  DB 00H,00H
N       DB 03H
DADOS   DB 01H,02H,03H,04H,65H,76H,87H,98H,0A9H
        END

