/*
 * BCD-rotacao.c
 *
 * Created: 11/10/2015 21:34:20
 * Author : Gustavo, Vitor Garcez, Bruno Guarezi
 * Programa para realiza rotacao horaria em display LED de 7 segmentos
 */

#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>
#include <avr/pgmspace.h>

#define set_bit(Y,bit_x) (Y|=(1<<bit_x)) //ativa o bit x da variavel Y (coloca em 1)
#define clr_bit(Y,bit_x) (Y&=~(1<<bit_x)) //limpa o bit x da variavel Y (coloca em 0)

#define liga(Y, bit_x) (clr_bit(Y,bit_x),_delay_ms(10)) //realiza funcao set_bit e aplica delay de 10ms
#define desliga(Y, bit_x) (set_bit(Y,bit_x),_delay_ms(10)) //realiza funcao clr_bit e aplica delay de 10ms

int main(void)
{
	int Tabela[] = {PD0, PD1, PD2, PD3, PD4, PD5, PD6}; //array de pinos representando os segmentos
	int i = 0;
	PORTD = 0b11111111; //habilita pull-up em todas as entradas
	DDRD = 0xFF; //configura todos os pinos como saida
    while (1) 
    {
		for(i=0;i<7;i++) //loop para a funcao liga
		{
			liga(PORTD, Tabela[i]);
		}
		for(i=0;i<7;i++) //loop para a funcao desliga
		{
			desliga(PORTD, Tabela[i]);
		}
    }
}



