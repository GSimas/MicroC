/*
 * Interrupcoes.c
 *
 * Created: 21/10/2015 14:51:57
 *  Author: Aluno
 */ 

#define F_CPU 16000000UL

#include <avr/io.h>
#include <avr/interrupt.h>
#include <ls_atmega328.h>

#define set_bit(Y, bit_x) (Y|=(1<<bit_x))
#define clr_bit(Y, bit_x) (Y&=~(1<<bit_x))
#define tst_bit(Y, bit_x) (Y&(1<<bit_x))
#define cpl_bit(Y, bit_x) (Y^=(1<<bit_x))

#define LED_PORT PORTC
#define LED_DDR DDRC

#define LED_GREEN PC4
#define LED_RED PC5

#define SN74595_PORT PORTB
#define SN74595_DDR DDRB

#define SN74595_DATA PB0
#define SN74595_SHIFT PB1
#define SN74595_SROBE PB2

int main(void)
{
	LED_PORT = 0xFF;
	LED_DDR = 0xFF;
	SN74595_PORT = 0xFF;
	SN74595_DDR = 0xFF;
	
	unsigned char cont = 0;
	
    while(1)
    {
		
        
    }
}