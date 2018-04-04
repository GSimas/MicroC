;UFSC - CTC - Eng Eletronica
;Gustavo Simas da Silva
;2018.1
;Programa ESCREVE_MSG.asm
CS 			EQU P0.7
EN 			EQU P1.2
RS_0 		EQU 0
RS_1 		EQU 00001000b
Atraso 		EQU 50H

			ORG 0H

			CLR CS ; INIBE DECODIFICADOR DOS DISPLAYS DE 7 SEGMENTOS
			CALL INITDSP ; ROTINA QUE CONFIGURA CONTROLADOR LCD

			;ESCREVE MENSAGEM
			MOV DPTR,#MENS
			MOV R2,#RS_1 ; SETB P1.3 (RS) - ENVIO DE DADO para LCD
			CALL WRT
			JMP $

DELAY: 		MOV R0, #Atraso
			DJNZ R0, $
			RET

INITDSP: 	; subrotina para inicializar o display
			; 001(DL)_NFxx = 0010 1000b (function set)
			; DL=0: interface 4 bits; N=1: 2 linhas; F=0: caractere 5x8
			; En (P1.2): 1-> 0 = escreve; RS (P1.3): 0=comando;1=dado
			MOV P1,#20H ; FUNCTION SET - high nibble = 0010b -- interface 4 bits
			SETB EN ; GERA EN
			CLR EN
			CALL DELAY ; AGUARDA LCD FICAR PRONTO
			; Nibble alto do Function Set é enviado 2x.
			MOV R2,#RS_0 ; CLR P1.3 (RS) - comando vai ser enviado para LCD
			MOV DPTR,#comando
			CALL WRT ; escreve dados para o LCD
			RET

WRT:		MOV A,#0 ; OFFSET de END. do NRO de COMANDOS/DADOS
			MOVC A,@A+DPTR
			MOV R6,A ; R6=NRO DE COMANDOS/DADOS
			MOV R1,#1H ; DESLOCAMENTO DO COMANDO/MENSAGEM INICIAL
			
			LOOP:	MOV A,R1 ; OFFSET de END. de DADO/COMANDO em A
					MOVC A,@A+DPTR
					MOV B,A ; BYTE A SER ESCRITO EM B
					ANL A,#0F0H ; APAGA NIBBLE LS
					ORL A,R2 ; R2 DEVE CONTER RS (0: COMANDO; 8: DADO) ou seja valor de P1.3
					MOV P1,A ; ENVIA PARA LCD
					SETB EN ; GERA EN - SETB P1.2
					CLR EN
					MOV A,B ;RECUPERA BYTE a SER ESCRITO de B
					SWAP A ;TROCA NIBBLES MS-LS
					ANL A,#0F0H ; APAGA NIBBLE LS
					ORL A,R2 ; (RS) se R2 =RS_1;
					MOV P1,A ; ENVIA PARA LCD
					SETB EN ; GERA EN
					CLR EN
					CALL DELAY ; AGUARDA LCD ESTAR PRONTO PARA NOVO COMANDO
					INC R1 ; R1 APONTA PARA PRÓXIMO COMANDO/DADO
					DJNZ R6,LOOP ; VERIFICA SE ÚLTIMO DADO/COMANDO
			RET

comando: 	DB 03h,28h,0fh,06h ; nro. decomandos - function set - display on/off - entry mode

MENS: 		DB 13,"EEL7030 - LCD"
		
END