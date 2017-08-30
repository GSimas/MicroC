;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Matrix.asm - Matrizes com enderecamento baseado indexado
;Prof. Roberto M. Ziller - 04.01.2000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
M       EQU 10
N       EQU 20

PILHA   SEGMENT STACK
        DW 80H DUP(?)
PILHA   ENDS

M1      SEGMENT
        DB M * N DUP (10H)
M1      ENDS
M2      SEGMENT
        DB M * N DUP (25H)
M2      ENDS

CODIGO  SEGMENT
        ASSUME CS:CODIGO, SS:PILHA, DS:M1, ES:M2
        PUBLIC ROW, COL
INICIO: MOV AX,M1
        MOV DS,AX
        MOV AX,M2
        MOV ES,AX
        MOV BX,0
ROW:    MOV SI,0
COL:    MOV AL,ES:[BX+SI]
        ADD [BX+SI],AL
        INC SI
        CMP SI,N
        JNZ COL
        ADD BX,N
        CMP BX,M*N
        JNZ ROW
        MOV AH,4CH
        INT 21H
CODIGO  ENDS
        END INICIO

