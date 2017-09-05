; EXEMPLO CONT_INT.ASM   Prof. Hari Bruno Mohr    

; Este programa realiza uma contagem decimal a partir de 0
; A contagem deve ser iniciada no valor dado em inicio
; toda vez que a tecla INT RST7.5 for pressionada 


; Com essa solucao adotada, o que acontece se a interupcao ocorrer
; nos instantes maracados com 1 e 2 ?????????????

; E se acontecer uma INT RST5.5 ou 6.5 ou TRAP ????
; Modifique o programa para evitar esses problemas!!!

MOSTRAA equ 036EH
DELAY   equ 05f1H

        ORG 2000h
	
	LXI SP,20C2H     
        MVI A,08H       ; HABILITAR INTERRUCOES
        SIM             ; SETAR MASCARA DE INTERRUPCOES
        EI              ; HABILITAR INTERRUPCOES
        LDA INICIO      ; 
LOOP:   CALL MOSTRAA    ; MOSTRAR NO DISPLAY

        LDA MEMORIA     ; RECUPERAR CONTAGEM
        ADI 1           ; INCREMENTAR CONTADOR
        ;1
        DAA             ; AJUSTE PARA DECIMAL
	;2
        STA MEMORIA     ; SALVAR A
        
	LDA ATRASO
	MOV D,A
        CALL DELAY      ; ATRASO PARA VISUALIZAR
        LDA MEMORIA     ; RECUPERAR CONTAGEM
	JMP LOOP

TINT:   EI              ; REABILITAR AS INTERRUPCOES
        LDA INICIO      ; TRATAMENTO DA INT RST 7.5
        STA MEMORIA     ; ZERAR CONTADOR   
        RET

MEMORIA  DB 0
ATRASO	 db 06H
INICIO	 DB 0

         ORG 20CEH       ; INTERRUPCAO
         JMP TINT
	 END


