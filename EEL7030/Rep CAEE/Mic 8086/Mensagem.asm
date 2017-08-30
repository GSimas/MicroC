;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Mensagem.asm - Escrevendo uma mensagem na tela
;Prof. Roberto M. Ziller - 04.01.2000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PILHA   SEGMENT STACK
        DB 128 DUP(?)
PILHA   ENDS

DADOS   SEGMENT
MSG1    DB 'AGORA SEI ESCREVER MENSAGENS NA TELA DO COMPUTADOR: $'
MSG2    DB 'MICROPROCESSADORES'
DADOS   ENDS

CODIGO  SEGMENT
        ASSUME CS:CODIGO, DS:DADOS, SS:PILHA
INICIO: MOV AX,DADOS
        MOV DS,AX           ; INICIALIZACAO DE DS
        MOV AH,09H          ; SERVICO DO DOS
        MOV DX,OFFSET MSG1  ; APONTA PARA O TEXTO 
        INT 21H             ; EXECUTA FUNCAO DO DOS P/ MSG1
        MOV DX,OFFSET MSG2
        INT 21H             ; IDEM, MSG2
        MOV AH,4CH          ; TERMINA E RETORNA AO DOS
        INT 21H             ; SERVICO DO DOS
CODIGO  ENDS
        END INICIO
