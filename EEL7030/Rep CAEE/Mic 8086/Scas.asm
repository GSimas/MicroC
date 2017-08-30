;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Scas.asm - Varredura de strings
;Prof. Roberto M. Ziller - 04.01.2000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ENTER   EQU 0DH
PILHA   SEGMENT STACK
        DW 100 DUP (?)
PILHA   ENDS
DADOS   SEGMENT
MSGSTR  DB 'ENTRE COM A STRING: $'
MSGCHAR DB 'ENTRE COM O CARACTER A PROCURAR: $'
MSGFND  DB 'O CARACTER FOI ENCONTRADO NA POSICAO $'
MSGNOT  DB 'O CARACTER NAO FOI ENCONTRADO.'
CRLF    DB 0DH, 0AH, '$'
BUFFER  DB 101 DUP (?)
DADOS   ENDS
CODE    SEGMENT
        ASSUME CS:CODE,ES:DADOS,SS:PILHA
START:  MOV AX,DADOS
        MOV DS,AX
        MOV ES,AX
        LEA AX,MSGSTR
        PUSH AX
        CALL SHOW       ;SOLICITA STRING
        ADD SP,2
        LEA AX,BUFFER
        PUSH AX
        CALL GETSTR     ;STRING EM BUFFER E COMPRIMENTO EM CX
        ADD SP,2
        LEA AX,MSGCHAR
        PUSH AX
        CALL SHOW       ; SOLICITA CARACTER
        ADD SP,2
        CALL GETCHAR    ; CARACTER EM AL
        LEA DI,BUFFER
        CLD
REPNE   SCASB           ; VARRE STRING EM BUSCA DO CARACTER
        JNZ NO
        LEA AX,MSGFND
        PUSH AX
        CALL SHOW       ; CARACTER ENCONTRADO
        ADD SP,2
        SUB DI,OFFSET BUFFER
        DEC DI          ; DI = OFFSET DO CARACTER EM BUFFER
        MOV AX,DI
        MOV BL,10       
        DIV BL          ; DIVIDE OFFSET DO CARACTER POR 10; 
        MOV DX,AX       ; DEZENA EM DL E UNIDADE EM DH
        ADD DX,3030H    ; CONVERTE P/ ASCII
        MOV AH,02H
        INT 21H         ; APRESENTA DEZENA
        MOV DL,DH
        INT 21H         ; APRESENTA UNIDADE
        MOV DL,'.'
        INT 21H         ; PONTO FINAL DA FRASE
        JMP FIM
NO:     LEA AX,MSGNOT
        PUSH AX
        CALL SHOW       ; CARACTER NAO ENCONTRADO
        ADD SP,2
FIM:    MOV AH,4CH
        INT 21H
SHOW    PROC NEAR
        PUSH BP
        MOV BP,SP
        MOV AH,09H
        LEA DX,CRLF
        INT 21H
        MOV DX,[BP+4]
        INT 21H
        POP BP
        RET
SHOW    ENDP
GETSTR  PROC NEAR
        PUSH BP
        MOV BP,SP
        MOV BX,[BP+4]
        MOV CX,00H
LOOP:   MOV AH,01H
        INT 21H
        CMP AL,ENTER
        JZ OK
        MOV [BX],AL
        INC BX          ; OFFSET DO CARACTER EM BUFFER
        INC CX          ; NUMERO DE CARACTERES LIDOS
        CMP CX,100
        JB LOOP
OK:     MOV BYTE PTR [BX],'$'
        POP BP
        RET
GETSTR  ENDP
GETCHAR PROC NEAR
        MOV AH,01H
        INT 21H
        RET
GETCHAR ENDP
CODE    ENDS        
        END START
