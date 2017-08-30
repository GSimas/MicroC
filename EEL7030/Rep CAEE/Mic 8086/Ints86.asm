;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Ints86.asm - Interrupcoes do 8085
;Prof. Roberto M. Ziller - 04.01.2000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PILHA   SEGMENT STACK
        DW 128 DUP (?)
PILHA   ENDS
DADOS   SEGMENT
CONT    DB 0      ; CONTAGEM
ATRASO  DB 0      ; ATRASO
DADOS   ENDS
CODIGO  SEGMENT
        ASSUME CS:CODIGO, DS:DADOS, SS:PILHA
INICIO: MOV AX,CS
        MOV DS,AX               ; DS = CS
        MOV AH,25H              ; FUNCAO SET INT VECTOR
        MOV AL,28H              ; VETOR A MODIFICAR
        MOV DX,OFFSET CONTA     ; OFFSET DO TRATADOR
        INT 21H                 ; SERVICO DO DOS
        MOV AL,3                ; RETURN CODE
        MOV DX,0FFH             ; PARAGRAPHS TO KEEP RESIDENT
        MOV AH,31H              ; TSR
        INT 21H                 ; SERVICO DO DOS
CONTA:  PUSH AX
        PUSH BX
        PUSH CX
        PUSH DS
        MOV AX,DADOS
        MOV DS,AX               ; DS -> DADOS
        INC ATRASO
        CMP ATRASO,00H
        JNE SAIDA
        MOV AL,CONT
        INC AL
        CMP AL,10
        JNE OK
        XOR AL,AL       ; ZERA CONTAGEM
OK:     MOV CONT,AL
        OR AL,30H       ; TRANSFORMA EM ASCII
        MOV AH,09       ; FUNCAO "WRITE CHAR" DA INT 10H
        MOV BH,0        ; PAGINA DE VIDEO
        MOV BL,7        ; ATRIBUTO
        MOV CX,0001H    ; NUMERO DE CARACTERES
        INT 10H         ; SERVICO DO BIOS
SAIDA:  POP DS
        POP CX
        POP BX
        POP AX
        IRET
CODIGO  ENDS
        END INICIO
