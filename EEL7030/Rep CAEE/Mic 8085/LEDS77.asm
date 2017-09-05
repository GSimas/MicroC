;Corrigir o programa para que realize as 
;funçoes descritas a seguir !!
; envie o programa corrigido, marcando as alteraçoes
; com *******************************
; para hari@inep.ufsc.br


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Leds7.asm - Utilizacao de perifericos
;Prof. Hari Bruno Mohr
;Mostrar sequencia de acendimento dos leds
;com intervalos proporcionais as chaves 1 2 e 
; As chaves 7 6 e 5 definem a sequencia a ser mostrada
; TRAP vai mostrar seq1
;RST5.5 escreve 1234 no campo de endereços
;RST6,5 escreve 65 no campo de dados
;RST7.5 apaga os 2 displays
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
COMMAND EQU 20H
LEDS    EQU 22H
chaves  equ 21h
DELAY   EQU 05F1H
RST5.5  EQU 20C8h
RST6.5  EQU 20CBh
RST7.5  EQU 20CEH
TRAP    EQU 20D1h
MOSTRAA EQU  036EH
MOSTRAD EQU  0363H

        ORG 2000H
        LXI SP,20C0H    ; Inicializa pilha
        MVI A,02H       ; Porta B como saida
        OUT COMMAND
	MVI A,00011000B
        SIM             ; habilita INT
        EI

inicio: mvi c,16
	in chaves
	ani 80h
	JNZ SEQUE3
	IN chaves
	ani 40h
	JNZ SEQUE2
	ani 20h

	lxi H,seq1
	jmp LOOP

SEQUE2: LXI H,seq2
	jmp LOOP

SEQUE3: lxi h,seq3

LOOP:   mov a,m
	OUT LEDS        ; Acende o LED correspondente a A
        in chaves
	ANI 07
	inr A
	MOV d,a
        CALL DELAY      ; Espera para ver LED aceso
        inx h
	dcr c
	jnz LOOP
        JMP inicio
  
seq1  db 81h,42h,24h,18h,18h,24h,42h,81h,81h,42h,24h,18h,18h,24h,42h,81h
seq2  db 0c0h,60h,30h,18h,0ch,06h,03h,81h,0c0h,60h,30h,18h,0ch,06h,03h,81h
seq3  db 80h,0c0h,0e0h,0f0h,0f8h,0fch,0feh,0ffh,0FFH,0FEh,0FCh,0F8h,0f0h,0E0h,0c0h,80h
	

	org RST5.5
	jmp T55
	org RST6.5
	JMP T65
	org RST7.5 
	PUSH PSW
	PUSH D
	mvi a,0
	call MOSTRAA
	lxi D,0
	call MOSTRAD
	POP D
	POP PSW
	EI
	RET

	org TRAP
        lxi H,seq1
	POP PSW ; retirar endereço de retorno da pilha !!!!
	EI
	jmp LOOP
	
T55:    PUSH D
      	lxi d,1234h
	call MOSTRAD
	pop D
	EI
        RET

T65:    push PSW
        mvi a,65h
	call MOSTRAA
	POP PSW
	EI
        RET
	END 
