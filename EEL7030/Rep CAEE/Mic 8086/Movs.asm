;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Movs.asm - Copia de strings
;Prof. Roberto M. Ziller - 04.01.2000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WCOUNT  EQU 10H
PILHA   SEGMENT STACK
        DW 80H DUP (?)
PILHA   ENDS

DADOS   SEGMENT
BUFFER  DW WCOUNT DUP(?)
DADOS   ENDS

CODE    SEGMENT
        ASSUME CS:CODE,SS:PILHA,ES:DADOS
        PUBLIC SUJAR, START
START:  MOV AX,DADOS
        MOV ES,AX
        LEA DI,BUFFER
        MOV CX,WCOUNT
        MOV AX,1111H    ; VALOR INICIAL DOS WORDS DE BUFFER
        CLD             ; STRINGS MOVIDAS COM AUTO-INCREMENTO
REP     STOSW

        MOV CX,WCOUNT
SUJAR:  PUSH CX         ; COLOCA WCOUNT WORDS NA PILHA
LOOPNE  SUJAR
        MOV AX,SS
        MOV DS,AX       ; DS = SS
        MOV SI,SP       ; SI = TOP OF STACK
        MOV CX,WCOUNT
        LEA DI,BUFFER
REP     MOVSW           ; WCOUNT WORDS DO STACK P/ BUFFER

        ADD SP,2*WCOUNT ; LIMPA A PILHA
        MOV AH,4CH
        INT 21H         ; FIM
CODE    ENDS
        END START
