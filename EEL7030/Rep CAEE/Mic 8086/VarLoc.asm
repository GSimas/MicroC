;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;VarLoc.asm - Variaveis locais
;Prof. Roberto M. Ziller - 04.01.2000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PILHA   SEGMENT STACK
        DW 40H DUP(?)
PILHA   ENDS

DADOS   SEGMENT
MSG1    DB 'ESTE PROGRAMA JUNTA DUAS MENASGENS $'
MSG2    DB 'EM UMA UNICA.$'
MSG3    DB 0DH,0AH,'A LINHA ACIMA TEM $'
MSG4    DB ' CARACTERES.$'
N       DB 00H,00H,'$'
DADOS   ENDS

CODE    SEGMENT
        ASSUME CS:CODE, DS:DADOS, SS:PILHA
INICIO: MOV AX,DADOS
        MOV DS,AX
        MOV AX,OFFSET MSG1  ; ENDERECO DA MSG1
        PUSH AX
        MOV AX,OFFSET MSG2  ; ENDERECO DA MSG2
        PUSH AX
        CALL SHOW
        ADD SP,4            ; ELIMINA PARAMETROS DA PILHA
        MOV BL,10           ; 
        DIV BL              ; CONVERTE AX PARA DECIMAL
        OR AH,30H           ; ASCII
        MOV N+1,AH          ; UNIDADE
        OR AL,30H           ; ASCII
        MOV N,AL            ; DEZENA
        MOV AH,09H          ;
        LEA DX,MSG3         ;
        INT 21H             ; ESCREVE MSG3
        MOV AH,09H
        LEA DX,N
        INT 21H             ; ESCREVE VALOR DE N
        MOV AH,09H
        LEA DX,MSG4
        INT 21H             ; ESCREVE MSG4
        MOV AH,4CH          ; TERMINA PROGRAMA
        INT 21H 

SHOW    PROC NEAR
        PUSH BP
        MOV BP,SP
        SUB SP,2            ; VAR DE CONTAGEM TEMPORARIA
        MOV WORD PTR [BP-2],00H
        MOV BX,[BP+6]       ; PRIMEIRA STRING
LOOP1:  CMP BYTE PTR [BX],'$'
        JZ OK1
        INC WORD PTR [BP-2] ; CONTANDO CARACTERES DA MSG1
        INC BX
        JMP LOOP1
OK1:    MOV AH,09H
        MOV DX,[BP+6]
        INT 21H             ; ESCREVE MSG1
        MOV BX,[BP+4]       ; SEGUNDA STRING
LOOP2:  CMP BYTE PTR [BX],'$'
        JZ OK2
        INC WORD PTR [BP-2] ; CONTANDO CARACTERES DA MSG2
        INC BX
        JMP LOOP2
OK2:    MOV AH,09H
        MOV DX,[BP+4]
        INT 21H             ; ESCREVE MSG2
        MOV AX,[BP-2]       ; VALOR A RETORNAR
        ADD SP,2            ; DESTROI VARIAVEL LOCAL
        POP BP
        RET
SHOW    ENDP
CODE    ENDS
        END INICIO
