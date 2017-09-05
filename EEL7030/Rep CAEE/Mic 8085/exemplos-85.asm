; Exemplo2
  Fazer um programa que seja executado no Abacus e que:

; 1) Faz piscar o LED1 com velocidade proporcional as 
;    chaves 2 e 3 ( Delay de 1, 2, 3 ou 4)
; 2) a iNTERRUPCAO trap NAO produz efeito nenhum
; 3) A Interrupçao RST5.5 liga os 3 LEDs Mais significativos 
; 4) A Interrupçao RST6.5 mostra o estado das 4 chaves MAIS
;   significativas nos LEDs e nao altera os demais LEDs
; 5) Interrupçao RST7.5 faz a leitura de um numero de 2 digitos
;   no teclado e mostra no campo de dados.
;


; exemplo3
                           
; Fazer um programa para atender os seguintes requisitos:
;
; 1 Ler um numero de 2 digitos do teclado
; 2 Fazer um contador hexadecimal de 2 digitos no
;    byte menos significativo do campo de enderecos
;    que inicia com o valor lido em 1
; 3 A chave 4 muda a velocidade do contador
;    Aberto = delay = 4
;    Fechado   delay = 1
; 4 A int RST5.5 faz a leitura das 4 chaves mais significativas
;    e faz a contagem reiniciar neste valor
; 5 As outras chaves e interrupcoes nao devem produzir efeito nenhum


exemplo4
; Fazer um programa para rodar em loop e:
; 1)  Ler um numero decimal de dois digitos no teclado e guardar o mesmo 
;     em uma posicao de  memoria imediatamente apos o programa e mostrar 
;     no campo de endereços.
; 2) A INT RST5.5 deve ligar os  4 LEDs da  direita 
;    e a RST6.5 liga os 4 led da esquerda permanecendo os demais como estao 
;    RST7.5 nao tem efeito algum e TRAP apaga todos os LEDS.
; 3) O programa deve ficar em loop lendo o  valor das chaves e colocar este
;    valor nos dois bytes do campo de enderecos.


;
;exemplo9.asm 
;Prof. Hari Bruno Mohr
;1 Ler 2 digitos e mostrar no campo de dados
;2 Contador de 4 digitos no campo de endereços
;3 Velocidade do contador definida pelas chaves 4 e 5 e deve
; ser mostrada pelos LEDS
;4 Chaves 2 e 3 definem o incremento do contador
;5 Trap zera contador
;6 RST5.5 zera parte alta do contador
;7 RST6.5 muda parte alta do contador para 88
;8 RST7.5 - liga LED 8 durante intervalo definido pelas chaves 7 e 8
;



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
