/*
 * BCD-rotacao.c
 *
 * Created: 11/10/2015 19:54:20
 * Author : Gustavo, Vitor Garcez, Bruno Guarezi
 * Programa para realiza rotacao horaria em display LED de 7 segmentos
 */

#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>
#include <avr/pgmspace.h>

#define set_bit(Y,bit_x) (Y|=(1<<bit_x)) //ativa o bit x da variavel Y (coloca em 1)
#define clr_bit(Y,bit_x) (Y&=~(1<<bit_x)) //limpa o bit x da variavel Y (coloca em 0)

#define muda(Y, bit_x, bit_y) (set_bit(Y,bit_x),clr_bit(Y,bit_y),_delay_ms(10)) //coloca o bit x em 1 e o bit y em 0, tendo um delay de 10ms

int main(void)
{
	unsigned int Tabela[] = {PD0, PD1, PD2, PD3, PD4, PD5, PD0}; //array de pinos representando os segmentos
	int i = 0;
	PORTD = 0b11111111; //habilita pull-up em todas as entradas
	DDRD = 0xFF; //configura todos os pinos como saida
	set_bit(PORTD, PD6);
    while (1) 
    {
		for(i=0;i<6;i++) //loop para a funcao "muda"
		{
			muda(PORTD, Tabela[i], Tabela[i+1]); //funcao para ligar e desligar segmento de acordo com o array Tabela
		}
    }
}

