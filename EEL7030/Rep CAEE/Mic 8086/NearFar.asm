;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;NearFar.asm - Um estudo sobre sub-rotinas near e far
;Prof. Roberto M. Ziller - 04.01.2000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PILHA   SEGMENT STACK
        DB 128 DUP(?)
PILHA   ENDS
DADOS   SEGMENT
MSG1    DB 'FOI CHAMADA UMA SUB-ROTINA NEAR$'
MSG2    DB 'FOI CHAMADA UMA SUB-ROTINA FAR$'
DADOS   ENDS
CODIGO  SEGMENT
        ASSUME CS:CODIGO, DS:DADOS, SS:PILHA
        PUBLIC SHOW1, INICIO, SHOW2, ENTER
SHOW1   PROC NEAR       ; APRESENTA MSG EM DS:DX COM CRLF
        MOV AH,09H      ; WRITE STRING
        INT 21H
        CALL FAR PTR ENTER        
        RET
SHOW1   ENDP
INICIO: MOV AX,DADOS
        MOV DS,AX
        MOV DX,OFFSET MSG1
        CALL SHOW1
        MOV DX,OFFSET MSG2
        CALL FAR PTR SHOW2
        MOV AH,4CH      ; TERMINATE
        INT 21H
CODIGO  ENDS
ROTINAS SEGMENT        
        ASSUME CS:ROTINAS
SHOW2   PROC FAR        ; APRESENTA MSG EM DS:DX COM CRLF
        MOV AH,09H      ; WRITE STRING
        INT 21H
        CALL FAR PTR ENTER
        RET
SHOW2   ENDP
ENTER   PROC FAR
        MOV AH,02H
        MOV DL,0DH      ; CARRIAGE RETURN (CR)
        INT 21H
        MOV AH,02H
        MOV DL,0AH      ; LINE FEED (LF)
        INT 21H
        RET
ENTER   ENDP
ROTINAS ENDS
        END INICIO
