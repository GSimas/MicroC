;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Leds_ex1.asm - Utilizacao de perifericos
;Rotacionar um led aceso
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Para fazer no lab
; 1 - iniciar o contador com um valor de 2 digitos lido do teclado
; 2 - fazer com que o atraso seja proporcional as chaves 6 e 7
; 3 - a chave 1 controla o sentido de deslocamento do led aceso
; 4 - a chave 2 seleciona entre deslocar um led aceso ou um apagado
; 5 - ......

COMMAND EQU 20H
LEDS    EQU 22H
DELAY   EQU 05F1H
        ORG 2000H
        LXI SP,20C0H    ; Inicializa pilha
        MVI A,02H       ; Porta A como entrada e B como saida 
        OUT COMMAND
	MVI A,01H
LOOP:   OUT LEDS        ; Acende o LED correspondente a A
        RLC             ; Rotaciona LED a acender
        PUSH PSW
        MVI D,02H       ; Atraso de 200ms
        CALL DELAY      ; Espera para ver LED aceso
        POP PSW
        JMP LOOP
        RET
        END 
